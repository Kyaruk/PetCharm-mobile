class Post {
  final int id;
  final String cover;
  final String title;
  final String author;
  final String content;
  final String date;
  final List<dynamic> keywords;

  Post(
    this.id,
    this.cover,
    this.title,
    this.author,
    this.content,
    this.date,
    this.keywords,
  );

  Post.fromJson(Map<String, dynamic> json)
      : id = json['postId'] ?? "",
        cover = json["postCover"] ?? "",
        title = json["postTitle"] ?? "",
        author = json["postAuthor"] ?? "",
        content = json["postContent"] ?? "",
        date = json["postDate"] ?? "",
        keywords = json["keywords"] ?? ["宠物"];

  Map<String, dynamic> toJson() => <String, dynamic>{
        "postId": id,
        "postCover": cover,
        "postTitle": title,
        "postAuthor": author,
        "postContent": content,
        "postDate": date,
        "keywords": keywords,
      };
}
