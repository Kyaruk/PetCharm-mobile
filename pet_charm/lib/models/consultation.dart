class Consultation {
  final int consultationId;
  final String consultationUser1;
  final String consultationUser2;
  final String consultationTitle;
  final String consultationContent;
  final String consultationCover;
  final DateTime consultationDate;

  Consultation(
    this.consultationId,
    this.consultationUser1,
    this.consultationUser2,
    this.consultationTitle,
    this.consultationContent,
    this.consultationCover,
    this.consultationDate,
  );

  Consultation.fromJson(Map<String, dynamic> json)
      : consultationId = json['consultationId'] ?? "",
        consultationUser1 = json["consultationUser1"] ?? "",
        consultationUser2 = json["consultationUser2"] ?? "",
        consultationTitle = json["consultationTitle"] ?? "",
        consultationContent = json["consultationContent"] ?? "",
        consultationCover = json["consultationCover"] ?? "",
        consultationDate = json["consultationDate"] == null
            ? DateTime.parse(json["consultationDate"])
            : DateTime.now();

  Map<String, dynamic> toJson() => <String, dynamic>{
        "consultationId": consultationId,
        "consultationUser1": consultationUser1,
        "consultationUser2": consultationUser2,
        "consultationTitle": consultationTitle,
        "consultationContent": consultationContent,
        "consultationCover": consultationCover,
        "consultationDate": consultationDate,
      };
}
