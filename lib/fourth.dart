import 'package:flutter/material.dart';
import 'package:getxdemo/store/person.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('home widget build');
    return Scaffold(
      appBar: AppBar(),
      body: StreamProvider<String>(
        create: (context) => Person().age,
        initialData: '数据初始化中...',
        catchError: (context, error) => error.toString(),
        child: ChildWidget(),
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('home child widget build');
    return Text('年龄:${context.watch<String>()}');
  }
}
