import 'dart:io';

import 'package:dio/dio.dart';

class UploadService {
  static const String uploadBaseUrl = 'http://localhost:3900/api/upload/';
  static Future uploadImage(String key, File file) async {
    FormData formData =
    FormData.fromMap({key: await MultipartFile.fromFile(file.path)});
    var result = await Dio().post(uploadBaseUrl + 'image', data: formData);

    return result;
  }
}