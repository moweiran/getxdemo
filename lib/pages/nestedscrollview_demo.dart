import 'package:flutter/material.dart';

class NestedScrollViewDemo extends StatefulWidget {
  const NestedScrollViewDemo({Key? key}) : super(key: key);

  @override
  _NestedScrollViewDemoState createState() => _NestedScrollViewDemoState();
}

class _NestedScrollViewDemoState extends State<NestedScrollViewDemo>
    with TickerProviderStateMixin {
  final List<Tab> _tabs = const [
    Tab(
      icon: Icon(Icons.map),
      text: "Tab1",
    ),
    Tab(
      icon: Icon(Icons.camera_alt),
      text: "Tab2",
    ),
    Tab(
      icon: Icon(Icons.camera_alt),
      text: "Tab3",
    ),
    Tab(
      icon: Icon(Icons.camera_alt),
      text: "Tab4",
    ),
  ];
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            ///背景图和title展示
            SliverAppBar(
              pinned: true, //title固定在顶部不会滑动出屏幕
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: const Text("TabViewTwo"),
                background: Image.asset(
                  "images/1.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            ///tabbar展示
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  tabs: _tabs,
                  controller: _tabController,
                  isScrollable: false,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.grey,
                ),
              ),
              pinned: true,
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return Text("tab_1_${index}");
              },
              itemCount: 100,
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return Text("tab_2_${index}");
              },
              itemCount: 10,
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return Text("tab_3_${index}");
              },
              itemCount: 11,
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return Text("tab_4_${index}");
              },
              itemCount: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      child: tabBar,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => tabBar.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
