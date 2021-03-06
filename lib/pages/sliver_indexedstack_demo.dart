import 'package:flutter/material.dart';

class SliverIndexedStackDemo extends StatefulWidget {
  const SliverIndexedStackDemo({Key? key}) : super(key: key);

  @override
  _SliverIndexedStackDemoState createState() => _SliverIndexedStackDemoState();
}

class _SliverIndexedStackDemoState extends State<SliverIndexedStackDemo> {
  late ScrollController _controller;
  late double _expandedHeight = 0;
  late String _title = "test";
  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[
            SliverAppBar(
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    setState(() {
                      if (_expandedHeight == 40) {
                        _expandedHeight = 500;
                        _title = "222";
                      } else {
                        _expandedHeight = 40;
                        _title = "123123";
                      }
                    });
                  },
                ),
              ],
              pinned: false,
              snap: false,
              floating: true,
              expandedHeight: _expandedHeight,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(_title),
                background: Container(
                  height: 200,
                  color: Colors.white,
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _MySliverPersistentHeaderDelegate(),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 1000,
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Text('====${index}');
                  },
                  itemCount: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double _minExtent = 80;
  final double _maxExtent = 250;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    //??????child?????????
    //shrinkOffset???child?????????minExtent~maxExtent
    //overlapsContent???SliverPersistentHeader???????????????????????????true???????????????false
    print('shrinkOffset = $shrinkOffset overlapsContent = $overlapsContent');
    return Container(
      alignment: Alignment.center,
      color: Colors.amber,
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: NetworkImage(ImageUrlConstant.imageUrl1),
      //     fit: BoxFit.cover,
      //   ),
      // ),
    );
  }

  //SliverPersistentHeader????????????
  @override
  double get maxExtent => _maxExtent;

  //SliverPersistentHeader????????????
  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant _MySliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
