import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../main.dart';

class CameraDemoPage extends StatefulWidget {
  const CameraDemoPage({super.key});

  @override
  State<CameraDemoPage> createState() => _CameraDemoPageState();
}

class _CameraDemoPageState extends State<CameraDemoPage> {
  late CameraController controller;
  @override
  void initState() {
    init();

    super.initState();
  }

  init() async {
    controller = CameraController(cameras[0], ResolutionPreset.max);
    await controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera Demo')),
      body: ValueListenableBuilder<CameraValue>(
        valueListenable: controller,
        builder: (_, value, __) {
          return Visibility(
            visible: value.isInitialized,
            child: CameraPreview(controller),
          );
        },
      ),
    );
  }
}
