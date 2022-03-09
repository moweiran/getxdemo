import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefreshIndicatorDemo extends StatefulWidget {
  const RefreshIndicatorDemo({Key? key}) : super(key: key);

  @override
  _RefreshIndicatorDemoState createState() => _RefreshIndicatorDemoState();
}

class _RefreshIndicatorDemoState extends State<RefreshIndicatorDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: RefreshIndicator(
      //   onRefresh: () async {
      //     //
      //     return Future.delayed(Duration(seconds: 5));
      //   },
      //   child: ListView.builder(
      //     itemBuilder: (context, index) {
      //       return Text("");
      //     },
      //     itemCount: 100,
      //   ),
      // ),
      body: CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 5));
              return Future.value(true);
            },
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  title: Text('sfsdfsdf'),
                );
              },
              childCount: 100,
            ),
          )
        ],
      ),
    );
  }
}
