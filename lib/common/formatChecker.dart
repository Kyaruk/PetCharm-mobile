///index： 0是电话号码，1是邮箱
bool formatChecker(String input, int index) {
  var reg = RegExp(r'');
  if(index == 0) {
    reg = RegExp(r'[0-9]{11}');
    return reg.hasMatch(input);
  }
  else if(index == 1) {
    reg = RegExp(r'[A-Za-z0-9_\-\.]+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})');
  }
  return reg.hasMatch(input);
}