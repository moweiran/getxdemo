class VideoInteractionItemModel {
  VideoInteractionItemModel({
    required this.videoId,
    required this.userId,
    required this.likes,
    required this.collections,
    required this.comments,
    required this.isLike,
    required this.isCollect,
    required this.isFollow,
  });

  String videoId;
  int userId;
  int likes;
  int collections;
  int comments;
  bool isLike;
  bool isCollect;
  bool isFollow;

  factory VideoInteractionItemModel.fromJson(Map<String, dynamic> json) =>
      VideoInteractionItemModel(
        videoId: json["videoId"],
        userId: json["userId"],
        likes: json["likes"],
        collections: json["collections"],
        comments: json["comments"],
        isLike: json["isLike"],
        isCollect: json["isCollect"],
        isFollow: json["isFollow"],
      );

  Map<String, dynamic> toJson() => {
        "videoId": videoId,
        "userId": userId,
        "likes": likes,
        "collections": collections,
        "comments": comments,
        "isLike": isLike,
        "isCollect": isCollect,
        "isFollow": isFollow,
      };
}
