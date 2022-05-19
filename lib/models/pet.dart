class Pet {
  String petName;
  String petType;
  String petBreed;
  String petGender;
  String time;
  // String vaccinatedStatus;//为0表示还未打疫苗，为1表示已经打了疫苗

  Pet(
    this.petName,
    this.petType,
    this.petBreed,
    this.petGender,
    this.time,
      // this.vaccinatedStatus,
  );

  Pet.fromJson(Map<String, dynamic> json)
      : petName = json["petName"] ?? "",
        petType = json["petType"] ?? "",
        petBreed = json["petBreed"] ?? "",
        petGender = json["petGender"] ?? "",
        time = json["time"] ?? ""
        // vaccinatedStatus = json["petVaccinatedStatus"]
  ;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "petName": petName,
        "petType": petType,
        "petBreed": petBreed,
        "petGender": petGender,
        "time": time,
        // "petVaccinatedStatus": vaccinatedStatus,
      };

  void setPetName(String _petName) {
    petName = _petName;
  }

  void setPetType(String _petType) {
    petType = _petType;
  }

  void setPetBreed(String _petBreed) {
    petBreed = _petBreed;
  }

  void setPetGender(String _petGender) {
    petGender = _petGender;
  }

  void setTime(String _time) {
    time = _time;
  }

  // void setVaccinatedStatus(String _vaccinatedStatus){
  //   vaccinatedStatus = _vaccinatedStatus;
  // }

}
