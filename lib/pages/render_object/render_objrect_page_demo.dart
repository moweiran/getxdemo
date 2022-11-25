import 'package:flutter/material.dart';
import 'package:getxdemo/pages/render_object/circle_widget.dart';
import 'package:getxdemo/pages/render_object/shirt_widget.dart';

import 'custom_text_widget.dart';

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
            child: CustomTextWidget(
              text: 'abc2782738497289347982734729834733339323232323',
              maxLines: 2,
            ),
          ),
          Text('abc')
        ],
      ),
    );
  }
}
