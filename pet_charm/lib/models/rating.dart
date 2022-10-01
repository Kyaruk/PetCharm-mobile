class Rating {
  final num ratingId;
  final String ratingContent;
  final num ratingScore;
  final String ratingByUser;
  final String ratingByUserIconUrl;

  Rating(
    this.ratingId,
    this.ratingContent,
    this.ratingScore,
    this.ratingByUser,
    this.ratingByUserIconUrl,
  );

  Rating.fromJson(Map<String, dynamic> json)
      : ratingId = json["ratingId"] ?? 0,
        ratingContent = json["ratingContent"] ?? "",
        ratingScore = json["ratingScore"] ?? 0,
        ratingByUser = json["ratingByUser"] ?? "",
        ratingByUserIconUrl = json["ratingByUserIconUrl"] ?? "";

  Map<String, dynamic> toJson() => <String, dynamic>{
        "ratingId": ratingId,
        "ratingContent": ratingContent,
        "ratingScore": ratingScore,
        "ratingByUser": ratingByUser,
        "ratingByUserIconUrl": ratingByUserIconUrl,
      };
}
