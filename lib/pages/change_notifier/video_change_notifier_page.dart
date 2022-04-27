import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'video_change_notifier.dart';
import 'video_model.dart';

class VideoChangeNotifierPage extends StatefulWidget {
  final VideoInteractionItemModel? videoInteractionItem;
  const VideoChangeNotifierPage({
    Key? key,
    this.videoInteractionItem,
  }) : super(key: key);

  @override
  State<VideoChangeNotifierPage> createState() =>
      _VideoChangeNotifierPageState();
}

class _VideoChangeNotifierPageState extends State<VideoChangeNotifierPage> {
  late VideoChangeNotifier videoDetailProvider;
  @override
  void initState() {
    this.videoDetailProvider = VideoChangeNotifier(
      this.widget.videoInteractionItem,
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant VideoChangeNotifierPage oldWidget) {
    if (oldWidget.videoInteractionItem != this.widget.videoInteractionItem) {
      this.videoDetailProvider = VideoChangeNotifier(
        this.widget.videoInteractionItem,
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VideoChangeNotifierPage'),
      ),
      body: ChangeNotifierProvider.value(
        value: videoDetailProvider,
        child: Consumer<VideoChangeNotifier>(
          builder: (context, value, child) {
            return Column(
              children: [
                Text(value.isLike),
                Text(value.isCollect),
              ],
            );
          },
        ),
      ),
    );
  }
}
