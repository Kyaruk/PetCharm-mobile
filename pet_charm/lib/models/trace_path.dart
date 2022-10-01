class TracePath {
  final int id;
  final String startTime;
  final String endTime;
  final String note;
  final String coordinates;

  TracePath(this.id, this.startTime, this.endTime, this.note, this.coordinates);

  TracePath.fromJson(Map<String, dynamic> json)
      : id = json['tracePathId'] ?? "",
        startTime = json["tracePathStartTime"] ?? "",
        endTime = json["tracePathEndTime"] ?? "",
        note = json["tracePathNote"] ?? "",
        coordinates = json["tracePathCoordinates"] ?? "";

  @override
  String toString() {
    return 'TracePath{id: $id, startTime: $startTime, endTime: $endTime, note: $note, coordinates: $coordinates}';
  }
}
