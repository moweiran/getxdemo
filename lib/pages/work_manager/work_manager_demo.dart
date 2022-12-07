import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import '../../main.dart';

class WorkManagerDemoPage extends StatefulWidget {
  const WorkManagerDemoPage({super.key});

  @override
  State<WorkManagerDemoPage> createState() => _WorkManagerDemoPageState();
}

class _WorkManagerDemoPageState extends State<WorkManagerDemoPage> {
  Timer? _timer;
  String _timerTime = '';
  /*WorkerManager is Singleton. Just create link it everywhere you want*/
  // final workerManager = WorkerManager();
  // int clicks = 0;
  // List results = [];
  // DateTime time;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timerTime = DateTime.now().toString();
      print(_timerTime);
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Worker Manager')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Plugin initialization",
                style: Theme.of(context).textTheme.headline5,
              ),
              ElevatedButton(
                child: const Text("Start the Flutter background service"),
                onPressed: () {
                  Workmanager().initialize(
                    callbackDispatcher,
                    isInDebugMode: true,
                  );
                },
              ),
              const SizedBox(height: 16),

              //This task runs once.
              //Most likely this will trigger immediately
              ElevatedButton(
                child: const Text("Register OneOff Task"),
                onPressed: () {
                  Workmanager().registerOneOffTask(
                    simpleTaskKey,
                    simpleTaskKey,
                    inputData: <String, dynamic>{
                      'int': 1,
                      'bool': true,
                      'double': 1.0,
                      'string': 'string',
                      'array': [1, 2, 3],
                    },
                  );
                },
              ),
              ElevatedButton(
                child: const Text("Register rescheduled Task"),
                onPressed: () {
                  Workmanager().registerOneOffTask(
                    rescheduledTaskKey,
                    rescheduledTaskKey,
                    inputData: <String, dynamic>{
                      'key': Random().nextInt(64000),
                    },
                  );
                },
              ),
              ElevatedButton(
                child: const Text("Register failed Task"),
                onPressed: () {
                  Workmanager().registerOneOffTask(
                    failedTaskKey,
                    failedTaskKey,
                  );
                },
              ),
              //This task runs once
              //This wait at least 10 seconds before running
              ElevatedButton(
                  child: const Text("Register Delayed OneOff Task"),
                  onPressed: () {
                    Workmanager().registerOneOffTask(
                      simpleDelayedTask,
                      simpleDelayedTask,
                      initialDelay: const Duration(seconds: 10),
                    );
                  }),
              const SizedBox(height: 8),
              //This task runs periodically
              //It will wait at least 10 seconds before its first launch
              //Since we have not provided a frequency it will be the default 15 minutes
              ElevatedButton(
                onPressed: Platform.isAndroid
                    ? () {
                        Workmanager().registerPeriodicTask(
                          simplePeriodicTask,
                          simplePeriodicTask,
                          initialDelay: const Duration(seconds: 10),
                        );
                      }
                    : null,
                child: const Text("Register Periodic Task (Android)"),
              ),
              //This task runs periodically
              //It will run about every hour
              ElevatedButton(
                onPressed: Platform.isAndroid
                    ? () {
                        Workmanager().registerPeriodicTask(
                          simplePeriodicTask,
                          simplePeriodic1HourTask,
                          frequency: const Duration(hours: 1),
                        );
                      }
                    : null,
                child: const Text("Register 1 hour Periodic Task (Android)"),
              ),
              const SizedBox(height: 16),
              Text(
                "Task cancellation",
                style: Theme.of(context).textTheme.headline5,
              ),
              ElevatedButton(
                child: const Text("Cancel All"),
                onPressed: () async {
                  await Workmanager().cancelAll();
                  print('Cancel all tasks completed');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
