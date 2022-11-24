import 'package:flutter/material.dart';
import 'package:getxdemo/pages/render_object/circle_widget.dart';
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
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Opacity(
              opacity: 0.9,
              child: Container(
                color: Colors.amber,
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: CircleLogoWidget(),
          ),
          const Expanded(
            flex: 1,
            child: ShirtWidget(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
