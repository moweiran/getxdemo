import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getxdemo/channel.dart' as channel;

class ChannelDemoPage extends StatefulWidget {
  const ChannelDemoPage({super.key});

  @override
  State<ChannelDemoPage> createState() => _ChannelDemoPageState();
}

class _ChannelDemoPageState extends State<ChannelDemoPage> {
  String _level = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Channel Demo Page'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              onPressed: () {
                channel.invokeMethod('getBatteryLevel', (result) {
                  setState(() {
                    _level = result;
                  });
                  if (kDebugMode) {
                    print('收到原生返回：$result');
                  }
                }, '123');
              },
              child: const Text('invoke'),
            ),
            Text('battery leve $_level'),
          ],
        ),
      ),
    );
  }
}
