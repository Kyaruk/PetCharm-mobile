///index： 0是电话号码，1是邮箱, 2是宠物种类, 3是宠物性别
bool formatChecker(String input, int index) {
  var reg = RegExp(r'');
  if (index == 0) {
    reg = RegExp(r'[0-9]{11}');
    return reg.hasMatch(input);
  } else if (index == 1) {
    reg = RegExp(r'[A-Za-z0-9_\-\.]+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})');
  } else if (index == 2) {
    return input == '狗' ||
        input == '猫' ||
        input == '鱼' ||
        input == '鸟' ||
        input == '猪' ||
        input == '兔子' ||
        input == '老鼠' ||
        input == '其他';
  } else if (index == 3) {
    return input == '男孩子' || input == '女孩子' || input == '其他';
  }
  return reg.hasMatch(input);
}
