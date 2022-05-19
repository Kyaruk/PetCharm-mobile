class Post {
  final int id;
  final String cover;
  final String title;
  final String author;
  final String content;
  final String date;

  Post(
    this.id,
    this.cover,
    this.title,
    this.author,
    this.content,
    this.date,
  );

  Post.fromJson(Map<String, dynamic> json)
      : id = json['postId'] ?? "",
        cover = json["postCover"] ?? "",
        title = json["postTitle"] ?? "",
        author = json["postAuthor"] ?? "",
        content = json["postContent"] ?? "",
        date = json["postDate"] ?? "";

  Map<String, dynamic> toJson() => <String, dynamic>{
        "postId": id,
        "postCover": cover,
        "postTitle": title,
        "postAuthor": author,
        "postContent": content,
        "postDate": date,
      };
}
