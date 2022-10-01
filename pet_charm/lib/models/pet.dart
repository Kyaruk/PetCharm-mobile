class Pet {
  int petId;
  String petName;
  String petType;
  String petBreed;
  String petGender;
  DateTime petDateOfBirth;
  String petIconUrl;

  // String vaccinatedStatus;//为0表示还未打疫苗，为1表示已经打了疫苗

  Pet(
    this.petId,
    this.petName,
    this.petType,
    this.petBreed,
    this.petGender,
    this.petDateOfBirth,
    this.petIconUrl,
    // this.vaccinatedStatus,
  );

  Pet.fromJson(Map<String, dynamic> json)
      : petId = json["petId"] ?? "",
        petName = json["petName"] ?? "",
        petType = json["petType"] ?? "",
        petBreed = json["petBreed"] ?? "",
        petGender = json["petGender"] ?? "",
        petDateOfBirth = (json["petDateOfBirth"] == "")
            ? DateTime.parse(json["petDateOfBirth"])
            : DateTime.now(),
        petIconUrl = json["petIconUrl"] ?? ""
  // vaccinatedStatus = json["petVaccinatedStatus"]
  ;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "petId": petId,
        "petName": petName,
        "petType": petType,
        "petBreed": petBreed,
        "petGender": petGender,
        "petDateOfBirth": petDateOfBirth,
        "petIconUrl": petIconUrl,
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

  void setTime(DateTime _petDateOfBirth) {
    petDateOfBirth = _petDateOfBirth;
  }

  void setPetIconUrl(String _petIconUrl) {
    petIconUrl = _petIconUrl;
  }

// void setVaccinatedStatus(String _vaccinatedStatus){
//   vaccinatedStatus = _vaccinatedStatus;
// }

}
