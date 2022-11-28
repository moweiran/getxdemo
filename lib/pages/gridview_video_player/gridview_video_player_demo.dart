import 'package:flutter/material.dart';
import 'package:getxdemo/pages/gridview_video_player/video_urls.dart';

import 'widgets/video_player_view.dart';

class GridViewVideoPlayerDemo extends StatefulWidget {
  const GridViewVideoPlayerDemo({Key? key}) : super(key: key);

  @override
  State<GridViewVideoPlayerDemo> createState() =>
      _GridViewVideoPlayerDemoState();
}

class _GridViewVideoPlayerDemoState extends State<GridViewVideoPlayerDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('grid view videos')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //Grid按两列显示
          mainAxisSpacing: 14,
        ),
        itemBuilder: (_, int index) {
          return VideoPlayerView(
            url: videoUrls[index],
          );
        },
        itemCount: videoUrls.length,
      ),
    );
  }
}
