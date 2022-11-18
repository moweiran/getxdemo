import 'package:flutter/material.dart';
import 'package:getxdemo/pages/render_object/shirt_widget.dart';

class RenderObjectPageDemo extends StatefulWidget {
  const RenderObjectPageDemo({Key? key}) : super(key: key);

  @override
  State<RenderObjectPageDemo> createState() => _RenderObjectPageDemoState();
}

class _RenderObjectPageDemoState extends State<RenderObjectPageDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('render object'),
      ),
      body: const ShirtWidget(
        color: Colors.yellow,
      ),
    );
  }
}
