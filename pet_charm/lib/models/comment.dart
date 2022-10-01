class Comment {
  final String commentAuthor;
  final String commentContent;
  final String commentIconUrl;
  final String commentDate;

  Comment(
    this.commentAuthor,
    this.commentContent,
    this.commentIconUrl,
      this.commentDate,
  );

  Comment.fromJson(Map<String, dynamic> json)
      : commentIconUrl = json["commentIconUrl"] ?? "",
        commentAuthor = json["commentAuthor"] ?? "",
        commentContent = json["commentContent"] ?? "",
        commentDate = json["commentDate"] ?? "";

  Map<String, dynamic> toJson() => <String, dynamic>{
        "commentIconUrl": commentIconUrl,
        "commentAuthor": commentAuthor,
        "commentContent": commentContent,
        "commentDate": commentDate,
      };
}
