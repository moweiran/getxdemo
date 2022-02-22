import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class EasyRefreshPage extends StatefulWidget {
  @override
  _EasyRefreshPageState createState() {
    return _EasyRefreshPageState();
  }
}

class _EasyRefreshPageState extends State<EasyRefreshPage> {
  @override
  void initState() {
    super.initState();
  }

  Future _getData() async {
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    print('=====easy refresh build====');
    return Scaffold(
      appBar: AppBar(
        title: Text("EasyRefresh"),
      ),
      body: FutureBuilder(
        future: _getData(),
        builder: _builderFuture,
      ),
      // persistentFooterButtons: <Widget>[
      //   FlatButton(
      //       onPressed: () {
      //         _controller.callRefresh();
      //       },
      //       child: Text("Refresh", style: TextStyle(color: Colors.black))),
      //   FlatButton(
      //       onPressed: () {
      //         _controller.callLoad();
      //       },
      //       child: Text("Load more", style: TextStyle(color: Colors.black))),
      // ],
    );
  }

  ///snapshot就是_calculation在时间轴上执行过程的状态快照
  Widget _builderFuture(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    print('_builderFuture');
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print('还没有开始网络请求');
        return const Text('还没有开始网络请求');
      case ConnectionState.active:
        print('active');
        return const Text('ConnectionState.active');
      case ConnectionState.waiting:
        print('waiting');
        return const Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        print('done');
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _buildEasyRefresh();
      default:
        return Container();
    }
  }

  // Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {}
}

class _buildEasyRefresh extends StatefulWidget {
  const _buildEasyRefresh({Key? key}) : super(key: key);

  @override
  __buildEasyRefreshState createState() => __buildEasyRefreshState();
}

class __buildEasyRefreshState extends State<_buildEasyRefresh> {
  late EasyRefreshController _controller;
  // 条目总数
  int _count = 20;
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      enableControlFinishRefresh: false,
      enableControlFinishLoad: true,
      controller: _controller,
      header: ClassicalHeader(),
      footer: ClassicalFooter(),
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2), () {
          print('onRefresh');
          setState(() {
            _count = 20;
          });
          _controller.resetLoadState();
        });
      },
      onLoad: () async {
        await Future.delayed(Duration(seconds: 2), () {
          print('onLoad');
          setState(() {
            _count += 10;
          });
          _controller.finishLoad(noMore: _count >= 40000);
        });
      },
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              print(index);
              return Container(
                width: 60.0,
                height: 60.0,
                child: Center(
                  child: Text('$index'),
                ),
                color: index % 2 == 0 ? Colors.grey[300] : Colors.transparent,
              );
            },
            childCount: _count,
          ),
        ),
      ],
    );
  }
}
