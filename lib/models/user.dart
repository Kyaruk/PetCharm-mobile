class User {
  String userId;
  String userName;
  String email;
  String userIconUrl;
  String userPhoneNumber;

  ///userType为固定string的枚举："兽医" "技师"
  String userType;

  User(this.userId, this.userName, this.email, this.userIconUrl, this.userPhoneNumber,
      this.userType);

  User.fromJson(Map<String, dynamic> json)
      : userId = json["userId"] ?? "",
        userName = json["userName"] ?? "",
        email = json["email"] ?? "",
        userIconUrl = json["userIconUrl"] ?? "",
        userPhoneNumber = json["userPhoneNumber"] ?? "",
        userType = json["userType"] ?? "";

  Map<String, dynamic> toJson() => <String, dynamic>{
        "userId": userId,
        "userName": userName,
        "email": email,
        "userIconUrl": userIconUrl,
        "userPhoneNumber": userPhoneNumber,
        "userType": userType,
      };

  void setUserName(String _userName) {
    userName = _userName;
  }

  void setEmail(String _email) {
    email = _email;
  }

  void setPhoneNumber(String _phoneNumber) {
    userPhoneNumber = _phoneNumber;
  }

  void setUserIconUrl(String _userIconUrl) {
    userIconUrl = _userIconUrl;
  }
}
