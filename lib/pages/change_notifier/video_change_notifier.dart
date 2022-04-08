import 'package:flutter/material.dart';

import 'video_model.dart';

class VideoChangeNotifier extends ChangeNotifier {
  var isCollect;

  var isLike;

  VideoChangeNotifier(
    VideoInteractionItemModel? videoInteractionItem,
  ) {
    if (videoInteractionItem == null) {
    } else {
      isLike = videoInteractionItem.isLike;
      isCollect = videoInteractionItem.isCollect;
    }
  }
}
