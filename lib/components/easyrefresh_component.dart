import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

/// EasyRefresh Future 实习上拉加载更多，下拉刷新
class EasyRefreshComponent extends StatelessWidget {
  final Function loadData;
  final Function? refreshData;

  /// Slivers集合
  final List<Widget> slivers;

  const EasyRefreshComponent({
    Key? key,
    required this.loadData,
    this.refreshData,
    required this.slivers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(),
      builder: _builderFuture,
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
        return _BuildEasyRefresh(
          refreshData: refreshData,
          loadData: loadData,
          slivers: slivers,
        );
      default:
        return Container();
    }
  }
}

class _BuildEasyRefresh extends StatefulWidget {
  final Function loadData;
  final Function? refreshData;

  /// Slivers集合
  final List<Widget>? slivers;

  const _BuildEasyRefresh({
    Key? key,
    required this.loadData,
    this.refreshData,
    this.slivers,
  }) : super(key: key);

  @override
  _BuildEasyRefreshState createState() => _BuildEasyRefreshState();
}

class _BuildEasyRefreshState extends State<_BuildEasyRefresh> {
  late EasyRefreshController _controller;
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
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
        await widget.refreshData!.call();
        _controller.resetLoadState();
      },
      onLoad: () async {
        print('onLoad');
        var noMore = await widget.loadData();
        _controller.finishLoad(noMore: noMore ?? false);
      },
      slivers: widget.slivers,
    );
  }
}
