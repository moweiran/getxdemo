import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureDemoPage extends StatefulWidget {
  const FutureDemoPage({Key? key}) : super(key: key);

  @override
  State<FutureDemoPage> createState() => _FutureDemoPageState();
}

class _FutureDemoPageState extends State<FutureDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Future Demo')),
      body: Column(
        children: [
          CupertinoButton(
            child: const Text('test'),
            onPressed: () {
              _testAsyncKeyword();
            },
          ),
          CupertinoButton(
            child: const Text('test 2'),
            onPressed: () {
              _testAsyncKeyword2();
            },
          ),
          CupertinoButton(
            child: const Text('test 3'),
            onPressed: () {
              _testKeyword3();
            },
          ),
        ],
      ),
    );
  }

  _testAsyncKeyword() {
    print("test函数开始了：${DateTime.now()}");
    _testString().then((value) => print(value));
    print("test函数结束了：${DateTime.now()}");
  }

  _testAsyncKeyword2() async {
    print("test函数开始了：${DateTime.now()}");
    print(await _testString());
    print("test函数结束了：${DateTime.now()}");
  }

  _testKeyword3() async {
    print("test函数开始了：${DateTime.now()}");
    print(await firstString());
    print(await secondString());
    print(await thirdString());
    print("test函数结束了：${DateTime.now()}");
  }

  Future<String> _testString() async {
    String result = await Future.delayed(Duration(milliseconds: 300), () {
      return "我是测试字符串===1";
    });
    print("我是测试字符串===2");
    return result;
  }

  Future<String> firstString() {
    return Future.delayed(Duration(milliseconds: 300), () {
      return "我是一个字符串";
    });
  }

  Future<String> secondString() {
    return Future.delayed(Duration(milliseconds: 200), () {
      return "我是二个字符串";
    });
  }

  Future<String> thirdString() {
    return Future.delayed(Duration(milliseconds: 100), () {
      return "我是三个字符串";
    });
  }
}
