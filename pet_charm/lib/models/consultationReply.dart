class ConsultationReply {
  final int consultationReplyId;
  final String consultationReplyUser;
  final String consultationReplyUserIconUrl;
  final String consultationReplyContent;
  final DateTime consultationReplyDate;

  ConsultationReply(
    this.consultationReplyId,
    this.consultationReplyUser,
    this.consultationReplyUserIconUrl,
    this.consultationReplyContent,
    this.consultationReplyDate,
  );

  ConsultationReply.fromJson(Map<String, dynamic> json)
      : consultationReplyId = json['consultationReplyId'] ?? "",
        consultationReplyUser = json["consultationReplyUser"] ?? "",
        consultationReplyUserIconUrl =
            json["consultationReplyUserIconUrl"] ?? "",
        consultationReplyContent = json["consultationReplyContent"] ?? "",
        consultationReplyDate = json["consultationReplyDate"] == null
            ? DateTime.parse(json["consultationReplyDate"])
            : DateTime.now();

  Map<String, dynamic> toJson() => <String, dynamic>{
        "consultationReplyId": consultationReplyId,
        "consultationReplyUser": consultationReplyUser,
        "consultationReplyUserIconUrl": consultationReplyUserIconUrl,
        "consultationReplyContent": consultationReplyContent,
        "consultationReplyDate": consultationReplyDate,
      };
}
