import 'dart:async';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:getxdemo/components/push_to_refresh_header.dart';
import 'package:loading_more_list/loading_more_list.dart';

import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

class PullToRefreshLoadMoreDemo extends StatefulWidget {
  const PullToRefreshLoadMoreDemo({Key? key}) : super(key: key);

  @override
  _PullToRefreshLoadMoreDemoState createState() =>
      _PullToRefreshLoadMoreDemoState();
}

class _PullToRefreshLoadMoreDemoState extends State<PullToRefreshLoadMoreDemo>
    with TickerProviderStateMixin {
  late final TabController primaryTC;
  int _length1 = 50;
  final int _length2 = 50;
  DateTime lastRefreshTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    primaryTC = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    primaryTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScaffoldBody(),
    );
  }

  Widget _buildScaffoldBody() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double pinnedHeaderHeight =
        //statusBar height
        statusBarHeight +
            //pinned SliverAppBar height in header
            kToolbarHeight;
    return PullToRefreshNotification(
      color: Colors.blue,
      onRefresh: () => Future<bool>.delayed(const Duration(seconds: 1), () {
        setState(() {
          _length1 += 10;
          lastRefreshTime = DateTime.now();
        });
        return true;
      }),
      maxDragOffset: maxDragOffset,
      child: GlowNotificationWidget(
        ExtendedNestedScrollView(
          headerSliverBuilder: (BuildContext c, bool f) {
            return <Widget>[
              const SliverAppBar(
                pinned: true,
                title: Text('pull to refresh in header'),
              ),
              PullToRefreshContainer(
                (PullToRefreshScrollNotificationInfo? info) {
                  return SliverToBoxAdapter(
                    child: PullToRefreshHeader(info, lastRefreshTime),
                  );
                },
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.red,
                  alignment: Alignment.center,
                  height: 200,
                  child: const Text('other things'),
                ),
              ),
            ];
          },
          //1.[pinned sliver header issue](https://github.com/flutter/flutter/issues/22393)
          pinnedHeaderSliverHeightBuilder: () {
            return pinnedHeaderHeight;
          },
          //2.[inner scrollables in tabview sync issue](https://github.com/flutter/flutter/issues/21868)
          onlyOneScrollInBody: true,
          body: Column(
            children: <Widget>[
              TabBar(
                controller: primaryTC,
                labelColor: Colors.blue,
                indicatorColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 2.0,
                isScrollable: false,
                unselectedLabelColor: Colors.grey,
                tabs: const <Tab>[Tab(text: 'Tab0'), Tab(text: 'Tab1')],
              ),
              Expanded(
                child: TabBarView(
                  controller: primaryTC,
                  children: const <Widget>[
                    TabViewItem(),
                    TabViewItem(),
                    // ListView.builder(
                    //   //store Page state
                    //   key: const PageStorageKey<String>('Tab0'),
                    //   physics: const ClampingScrollPhysics(),
                    //   itemBuilder: (BuildContext c, int i) {
                    //     return Container(
                    //       alignment: Alignment.center,
                    //       height: 60.0,
                    //       child: Text(
                    //         const Key('Tab0').toString() +
                    //             ': ListView$i of $_length1',
                    //       ),
                    //     );
                    //   },
                    //   itemCount: _length1,
                    //   padding: const EdgeInsets.all(0.0),
                    // ),
                    // ListView.builder(
                    //   //store Page state
                    //   key: const PageStorageKey<String>('Tab1'),
                    //   physics: const ClampingScrollPhysics(),
                    //   itemBuilder: (BuildContext c, int i) {
                    //     return Container(
                    //       alignment: Alignment.center,
                    //       height: 60.0,
                    //       child: Text(
                    //         const Key('Tab1').toString() +
                    //             ': ListView$i of $_length2',
                    //       ),
                    //     );
                    //   },
                    //   itemCount: _length2,
                    //   padding: const EdgeInsets.all(0.0),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoadMoreListSource extends LoadingMoreBase<int> {
  @override
  Future<bool> loadData([bool isloadMoreAction = false]) {
    return Future<bool>.delayed(const Duration(seconds: 1), () {
      for (int i = 0; i < 10; i++) {
        add(0);
      }

      return true;
    });
  }
}

class TabViewItem extends StatefulWidget {
  const TabViewItem();

  @override
  _TabViewItemState createState() => _TabViewItemState();
}

class _TabViewItemState extends State<TabViewItem>
    with AutomaticKeepAliveClientMixin {
  late final LoadMoreListSource source = LoadMoreListSource();

  @override
  void dispose() {
    source.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final LoadingMoreList<int> child = LoadingMoreList<int>(
      ListConfig<int>(
        sourceList: source,
        itemBuilder: (BuildContext c, int item, int index) {
          return Container(
            alignment: Alignment.center,
            height: 60.0,
            child: Text(': ListView$index'),
          );
        },
      ),
    );
    return child;
  }
}
