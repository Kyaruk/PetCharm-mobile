class Comment {
  final String commentUserName;
  final String commentContent;
  final String userIconUrl;

  Comment(
    this.commentUserName,
    this.commentContent,
    this.userIconUrl,
  );

  Comment.fromJson(Map<String, dynamic> json)
      : userIconUrl = json["userIconUrl"] ?? "",
        commentUserName = json["commentUserName"] ?? "",
        commentContent = json["commentContent"] ?? "";

  Map<String, dynamic> toJson() => <String, dynamic>{
        "userIconUrl": userIconUrl,
        "commentUserName": commentUserName,
        "commentContent": commentContent,
      };
}
