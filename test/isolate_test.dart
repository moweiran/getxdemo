import 'dart:async';
import 'dart:developer';
import 'dart:io';
import "dart:isolate";

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  test('Test Queue', () async {
    // 1.创建管道
    ReceivePort receivePort = ReceivePort();

    // 2.创建新的Isolate
    Isolate isolate = await Isolate.spawn<SendPort>(foo, receivePort.sendPort);

    // 3.监听管道消息
    receivePort.listen((data) {
      print('单向通信Data：$data');
      // 不再使用时，我们会关闭管道
      receivePort.close();
      // 需要将isolate杀死
      isolate.kill(priority: Isolate.immediate);
    });
  });

  /// 子Isolate的入口函数，可以在该函数中做耗时操作
  void newIsolate(SendPort mainSendPort) {
    print('newIsolate == ${Isolate.current.debugName}');
    ReceivePort newReceivePort = ReceivePort();
    mainSendPort.send(newReceivePort.sendPort);

    newReceivePort.listen((data) {
      print('[mainToNewIsolateStream] $data');
      var sum = 0;
      for (int i = 1; i <= data; i++) {
        sum += i;
      }
      mainSendPort.send('计算结果：$sum');
    });
  }

  /// 双向通信
  Future<SendPort> initIsolate() async {
    print('initIsolate == ${Isolate.current.debugName}');
    Completer<SendPort> completer = Completer<SendPort>();
    //主isolate中的接收者（接收子isolate中发送的消息）
    ReceivePort mainReceivePort = ReceivePort();
    //接受者的监听
    mainReceivePort.listen((data) {
      if (data is SendPort) {
        //接收到子isolate中创建的 SendPort，可使用该SendPort向子isolate发送消息
        SendPort newSendPort = data;
        completer.complete(newSendPort);
      } else {
        print('[newIsolateToMainStream] $data');
      }
    });
    //创建子isolate，传入 入口函数 和 接受者sendPort  ，子isolate可使用该sendPort向主isolate发送消息
    Isolate newIsolateInstance =
        await Isolate.spawn(newIsolate, mainReceivePort.sendPort);
    print('newIsolateInstance == ${newIsolateInstance.debugName}');
    return completer.future;
  }

  // 打印
  // [log] initIsolate == main
  // [log] newIsolate == newIsolate
  // [log] newIsolateInstance == newIsolate
  // [log] [mainToNewIsolateStream] 1000000000
  // [log] [newIsolateToMainStream] 计算结果：500000000500000000

  test('Test 双向通信', () async {
    SendPort newSendPort = await initIsolate();
    //接收到子ioslate中的 SendPort   可向子isolate中发送消息
    newSendPort.send(1000000000);
  });

  String doWork(String value) {
    print('new isolate doWork start == ${DateTime.now()}');
    // 模拟耗时5秒
    sleep(const Duration(seconds: 5));

    print('new isolate doWork end == ${DateTime.now()}');
    return "complete:$value";
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

  // 创建一个新的Isolate，在其中运行任务doWork
  test('Test compute', () async {
    var str = 'New Task';
    var result = await compute(doWork, str);
    print(result);

    var result2 = await compute(summ, 10000000000);
    print(result2);

    //SchedulerBinding.instance.scheduleTask(() => null, priority)
    // 打印
    // flutter: new isolate doWork start == 2022-06-21 20:37:43.615597
    // flutter: new isolate doWork end == 2022-06-21 20:37:48.622028
    // flutter: complete:New Task
    // flutter: 开始计算
    // flutter: 计算结束
    // flutter: 500000000500000000
  });
}

void foo(SendPort sendPort) {
  sendPort.send("Hello World2");
}

// 打印
// [log] 单向通信data：Hello World