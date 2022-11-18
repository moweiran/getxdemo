import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getxdemo/pages/mock_demo/api.dart';
import 'package:getxdemo/pages/mock_demo/xhttp.dart';

class MockDemoPage extends StatefulWidget {
  const MockDemoPage({Key? key}) : super(key: key);

  @override
  State<MockDemoPage> createState() => _MockDemoPageState();
}

class _MockDemoPageState extends State<MockDemoPage> {
  @override
  void initState() {
    XHttp.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mock Demo')),
      body: Column(
        children: [
          CupertinoButton(
            child: const Text('test'),
            onPressed: () {
              try {
                UserApi().getUpdateInfo();
              } catch (e, s) {
                //
              }
            },
          ),
        ],
      ),
    );
  }
}
