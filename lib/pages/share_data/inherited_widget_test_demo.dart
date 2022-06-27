import 'package:flutter/material.dart';

import '../../components/share_data_widget.dart';
import 'share_data_test_widget.dart';

class InheritedWidgetTestDemo extends StatefulWidget {
  const InheritedWidgetTestDemo({Key? key}) : super(key: key);

  @override
  State<InheritedWidgetTestDemo> createState() =>
      _InheritedWidgetTestDemoState();
}

class _InheritedWidgetTestDemoState extends State<InheritedWidgetTestDemo> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('inherited test'),
      ),
      body: Center(
        child: ShareDataWidget(
          //使用ShareDataWidget
          data: count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: ShareDataTestWidget(), //子widget中依赖ShareDataWidget
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text("$count"),
              ),
              ElevatedButton(
                child: const Text("Increment"),
                //每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
                onPressed: () async {
                  setState(() => ++count);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
