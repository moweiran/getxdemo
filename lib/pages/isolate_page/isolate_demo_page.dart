import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IsolateDemoPage extends StatefulWidget {
  const IsolateDemoPage({super.key});

  @override
  State<IsolateDemoPage> createState() => _IsolateDemoPageState();
}

class _IsolateDemoPageState extends State<IsolateDemoPage> {
  Timer? _timer;
  String _timerTime = '';
  // 1.创建管道
  final receivePort = ReceivePort();
  final receivePort2 = ReceivePort();
  final receivePort3 = ReceivePort();
  late Isolate isolate3;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timerTime = DateTime.now().toString();
      print(_timerTime);
      if (mounted) {
        setState(() {});
      }
    });

    init();
    receivePort2.listen((message) {
      print(message);
    });
    init3();

    super.initState();
  }

  void init() async {
    // 2.创建新的Isolate
    final isolate = await Isolate.spawn<SendPort>(foo, receivePort.sendPort);
    // 3.监听管道消息
    receivePort.listen((data) {
      print('单向通信Data：$data');
      // 不再使用时，我们会关闭管道
      receivePort.close();
      // 需要将isolate杀死
      isolate.kill(priority: Isolate.immediate);
    });
  }

  void init3() async {
    isolate3 = await Isolate.spawn(entryPoint, receivePort3.sendPort);
    receivePort3.listen((message) {
      print(message);
    });
  }

  @override
  void dispose() async {
    receivePort3.close();
    isolate3.kill(priority: Isolate.immediate);
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isolate Demo')),
      body: Column(
        children: [
          Text(_timerTime),
          ElevatedButton(
            onPressed: () => doWork('111'),
            child: const Text('dowork'),
          ),
          ElevatedButton(
            onPressed: () => summ(10000000000),
            child: const Text('summ'),
          ),
          ElevatedButton(
            onPressed: () async {
              await isPrime(10000000000);
            },
            child: const Text('summ compute'),
          ),
          ElevatedButton(
            onPressed: () {
              receivePort2.sendPort.send("这是通信消息");
              receivePort2.sendPort.send(1);
            },
            child: const Text('receivePort2'),
          )
        ],
      ),
    );
  }

  Future<String> doWork(String value) async {
    print('new isolate doWork start == ${DateTime.now()}');
    // 模拟耗时5秒
    sleep(const Duration(seconds: 5));
    // await Future.delayed(const Duration(seconds: 5));

    print('new isolate doWork end == ${DateTime.now()}');
    return "complete:$value";
  }

  Future<num> isPrime(int value) {
    return compute(summ, value);
  }
}

void foo(SendPort sendPort) {
  sendPort.send("Hello World");
}

//计算0到 num 数值的总和
num summ(int num) {
  print('开始计算');
  int count = 0;
  while (num > 0) {
    count = count + num;
    num--;
  }
  print('计算结束');
  return count;
}

void entryPoint(SendPort sendPort) {
  // 模拟耗时操作
  // Future.delayed(const Duration(seconds: 2), () {
  //   sendPort.send("子isolate里面给你发的消息");
  // });
  Timer.periodic(const Duration(seconds: 1), (timer) {
    sendPort.send("子isolate里面给你发的消息");
  });
}
