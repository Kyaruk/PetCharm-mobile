class User {
  int userId;
  String userName;
  String userFirstName;
  String userEmail;
  String userIconUrl;
  String userPhoneNumber;

  ///userType为固定string的枚举："兽医" "护工"
  String userType;
  num userScore;
  bool userEmailValid;

  User(this.userId, this.userName, this.userFirstName, this.userEmail,
      this.userIconUrl, this.userPhoneNumber, this.userType, this.userScore, this.userEmailValid);

  User.fromJson(Map<String, dynamic> json)
      : userId = json["userId"] ?? 0,
        userName = json["userName"] ?? "",
        userFirstName = json["userFirstName"] ?? "",
        userEmail = json["userEmail"] ?? "",
        userIconUrl = json["userIconUrl"] ?? "",
        userPhoneNumber = json["userPhoneNumber"] ?? "",
        userType = json["userType"] ?? "",
        userScore = json["userScore"] ?? 0.0,
        userEmailValid = json["userEmailValid"] ?? false;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "userId": userId,
        "userName": userName,
        "userFirstName": userFirstName,
        "userEmail": userEmail,
        "userIconUrl": userIconUrl,
        "userPhoneNumber": userPhoneNumber,
        "userType": userType,
        "userScore": userScore,
        "userEmailValid": userEmailValid,
      };

  void setFirstName(String _userFirstName) {
    userFirstName = _userFirstName;
  }

  void setEmail(String _userEmail) {
    userEmail = _userEmail;
  }

  void setPhoneNumber(String _phoneNumber) {
    userPhoneNumber = _phoneNumber;
  }

  void setUserIconUrl(String _userIconUrl) {
    userIconUrl = _userIconUrl;
  }
}
