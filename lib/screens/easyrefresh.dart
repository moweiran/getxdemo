import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:getxdemo/models/easyrefresh_notifier.dart';
import 'package:provider/provider.dart';

class EasyRefreshPage extends StatefulWidget {
  const EasyRefreshPage({Key? key}) : super(key: key);

  @override
  _EasyRefreshPageState createState() {
    return _EasyRefreshPageState();
  }
}

class _EasyRefreshPageState extends State<EasyRefreshPage> {
  late EasyRefreshNotifier _provider;

  @override
  void initState() {
    super.initState();
    _provider = EasyRefreshNotifier();
  }

  @override
  Widget build(BuildContext context) {
    print('=====easy refresh build====');
    return Scaffold(
      appBar: AppBar(
        title: const Text("EasyRefresh"),
      ),
      body: ChangeNotifierProvider.value(
        value: _provider,
        child: FutureBuilder(
          future: _provider.loadData(),
          builder: _builderFuture,
        ),
      ),
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
        return const _BuildEasyRefresh();
      default:
        return Container();
    }
  }

  // Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {}
}

class _BuildEasyRefresh extends StatefulWidget {
  const _BuildEasyRefresh({Key? key}) : super(key: key);

  @override
  _BuildEasyRefreshState createState() => _BuildEasyRefreshState();
}

class _BuildEasyRefreshState extends State<_BuildEasyRefresh> {
  late EasyRefreshController _controller;
  late EasyRefreshNotifier _provider;
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _provider = Provider.of<EasyRefreshNotifier>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    print('build easyrefresh custom');
    return EasyRefresh.custom(
      enableControlFinishRefresh: false,
      enableControlFinishLoad: true,
      controller: _controller,
      header: ClassicalHeader(),
      footer: ClassicalFooter(),
      onRefresh: () async {
        print('refresh');
        await _provider.refreshData();
        _controller.resetLoadState();
      },
      onLoad: () async {
        print('onLoad');
        await _provider.loadData();
        _controller.finishLoad(noMore: _provider.count >= 40000);
      },
      slivers: <Widget>[
        Consumer<EasyRefreshNotifier>(
          builder: (context, value, child) => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                print(index);
                var item = value.getItem(index);
                return Container(
                  width: 60.0,
                  height: 60.0,
                  child: Center(
                    child: Text(
                        '${index}_${item.name}_${item.nickname}_${item.age}'),
                  ),
                  color: index % 2 == 0 ? Colors.grey[300] : Colors.transparent,
                );
              },
              childCount: value.count,
            ),
          ),
        ),
      ],
    );
  }
}
