import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class GetXDemoPage extends StatefulWidget {
  const GetXDemoPage({super.key});

  @override
  State<GetXDemoPage> createState() => _GetXDemoPageState();
}

class _GetXDemoPageState extends State<GetXDemoPage> {
  final userInfo = UserInfo(age: '10', username: '', password: '').obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetX Demo'),
      ),
      body: Column(
        children: [
          Obx(
            () {
              print('username');
              return Text(
                userInfo.value.username,
              );
            },
          ),
          Obx(
            () {
              print('password');
              return Text(
                userInfo.value.password,
              );
            },
          ),
          Obx(
            () {
              print('age');
              return Text(
                userInfo.value.age,
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              userInfo.value.username = '${Random().nextInt(99999999999999)}';
            },
            child: const Text('test username'),
          ),
          ElevatedButton(
            onPressed: () {
              userInfo.value.password = '${Random().nextInt(99999999)}';
            },
            child: const Text('test password'),
          ),
          ElevatedButton(
            onPressed: () {
              userInfo.value.age = '${Random().nextInt(100)}';
            },
            child: const Text('test age'),
          )
        ],
      ),
    );
  }
}

class UserInfo {
  String username;
  String password;
  String age;
  UserInfo({
    required this.username,
    required this.password,
    required this.age,
  });
}
