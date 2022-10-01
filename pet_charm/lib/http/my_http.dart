import 'package:pet_charm/main.dart';
import 'package:pet_charm/models/consultation.dart';
import 'package:pet_charm/models/post.dart';
import 'package:pet_charm/models/comment.dart';
import 'package:pet_charm/models/rating.dart';
import 'package:pet_charm/models/user.dart';
import 'package:dio/dio.dart';
import 'package:pet_charm/common/toast.dart';

import '../models/consultationReply.dart';

// class MyHttp {
Future<List<Post>> getAllPosts() async {
  try {
    var response = await Global.dio.get('post/list/');

    if (response.statusCode == 200) {
      List<dynamic> body = response.data['posts'];

      List<Post> posts =
          body.map((dynamic item) => Post.fromJson(item)).toList();

      return posts;
    } else {
      toast("请检查您的网络情况并稍后重试");
      throw "Can't get posts.";
    }
  } catch (e) {
    toast("请检查您的网络情况并稍后重试");
    throw Exception(e.toString());
  }
}

Future<List<Post>> getUserPosts() async {
  try {
    var response = await Global.dio.get('post/user/');

    if (response.statusCode == 200) {
      List<dynamic> body = response.data['posts'];

      List<Post> posts =
          body.map((dynamic item) => Post.fromJson(item)).toList();

      return posts;
    } else {
      toast("请检查您的网络情况并稍后重试");
      throw "Can't get posts.";
    }
  } on DioError catch (e) {
    toast("请检查您的网络情况并稍后重试");
    throw Exception(e.response?.data);
  }
}

Future<List<User>> getVets() async {
  try {
    var response = await Global.dio.get('service/list/');

    if (response.statusCode == 200) {
      List<dynamic> body = response.data['services'];

      List<User> vets =
          body.map((dynamic item) => User.fromJson(item)).toList();

      return vets;
    } else {
      toast("请检查您的网络情况并稍后重试");
      throw "Can't get posts.";
    }
  } catch (e) {
    toast("请检查您的网络情况并稍后重试");
    throw Exception(e.toString());
  }
}

Future<List<Comment>> getAllComments() async {
  try {
    var response = await Global.dio.get('comment/list/');

    if (response.statusCode == 200) {
      List<dynamic> body = response.data['comments'];

      List<Comment> comments =
          body.map((dynamic item) => Comment.fromJson(item)).toList();

      return comments;
    } else {
      toast("请检查您的网络情况并稍后重试");
      throw "Can't get posts.";
    }
  } on DioError catch (e) {
    toast("请检查您的网络情况并稍后重试");
    throw Exception(e.response?.data);
  }
}

Future<List<Consultation>> getAllConsultation() async {
  try {
    var response = await Global.dio.get('consultation/user/');

    if (response.statusCode == 200) {
      List<dynamic> body = response.data['consultations'];

      List<Consultation> consultations =
          body.map((dynamic item) => Consultation.fromJson(item)).toList();

      return consultations;
    } else {
      toast("请检查您的网络情况并稍后重试");
      throw "Can't get posts.";
    }
  } on DioError catch (e) {
    toast("请检查您的网络情况并稍后重试");
    throw Exception(e.response?.data);
  }
}

Future<List<ConsultationReply>> getConsultationReplies(
    int consultationId) async {
  try {
    Map<String, dynamic> map = <String, dynamic>{};
    map["consultationId"] = consultationId;

    var response =
        await Global.dio.get('consultation/reply/list/', queryParameters: map);

    if (response.statusCode == 200) {
      List<dynamic> body = response.data['consultationReplies'];

      List<ConsultationReply> consultationReplies =
          body.map((dynamic item) => ConsultationReply.fromJson(item)).toList();

      return consultationReplies;
    } else {
      toast("请检查您的网络情况并稍后重试");
      throw "Can't get posts.";
    }
  } on DioError catch (e) {
    toast("请检查您的网络情况并稍后重试");
    throw Exception(e.response?.data);
  }
}

Future<List<Comment>> getPostComments(int postId) async {
  try {
    // FormData formData = FormData.fromMap({"postId": postId});
    // var response = await Global.dio.post('comment/list/', data: formData);

    Map<String, dynamic> map = <String, dynamic>{};
    map["postId"] = postId;
    var response = await Global.dio.get("comment/list/", queryParameters: map);

    if (response.statusCode == 200) {
      List<dynamic> body = response.data['comments'];

      List<Comment> comments =
          body.map((dynamic item) => Comment.fromJson(item)).toList();

      return comments;
    } else {
      toast("请检查您的网络情况并稍后重试");
      throw "Can't get posts.";
    }
  } on DioError catch (e) {
    toast("请检查您的网络情况并稍后重试");
    throw Exception(e.response?.data);
  }
}

Future<List<Post>> getVetPosts(int vetId) async {
  try {
    // FormData formData = FormData.fromMap({"vetId": vetId});
    // var response = await Global.dio.post('comment/list/', data: formData);

    Map<String, dynamic> map = <String, dynamic>{};
    map["vetId"] = vetId;
    var response = await Global.dio.get("comment/list/", queryParameters: map);

    if (response.statusCode == 200) {
      List<dynamic> body = response.data['comments'];

      List<Post> comments =
          body.map((dynamic item) => Post.fromJson(item)).toList();

      return comments;
    } else {
      toast("请检查您的网络情况并稍后重试");
      throw "Can't get posts.";
    }
  } on DioError catch (e) {
    toast("请检查您的网络情况并稍后重试");
    throw Exception(e.response?.data);
  }
}

Future<List<Rating>> getRatings(int userId) async {
  try {
    // FormData formData = FormData.fromMap({"vetId": vetId});
    // var response = await Global.dio.post('comment/list/', data: formData);

    Map<String, dynamic> map = <String, dynamic>{};
    map["userId"] = userId;
    var response = await Global.dio.get("service/", queryParameters: map);

    if (response.statusCode == 200) {
      List<dynamic> body = response.data['service']['ratings'];

      List<Rating> ratings =
          body.map((dynamic item) => Rating.fromJson(item)).toList();

      return ratings;
    } else {
      toast("请检查您的网络情况并稍后重试");
      throw "Can't get posts.";
    }
  } on DioError catch (e) {
    toast("请检查您的网络情况并稍后重试");
    throw Exception(e.response?.data);
  }
}

Future<List<Comment>> getUserComments() async {
  try {
    var response = await Global.dio.get('comment/user/');

    if (response.statusCode == 200) {
      List<dynamic> body = response.data['comments'];

      List<Comment> comments =
          body.map((dynamic item) => Comment.fromJson(item)).toList();

      return comments;
    } else {
      toast("请检查您的网络情况并稍后重试");
      throw "Can't get posts.";
    }
  } on DioError catch (e) {
    toast("请检查您的网络情况并稍后重试");
    throw Exception(e.response?.data);
  }
}

Future<User> getUserInfo() async {
  try {
    var response = await Global.dio.get(
      'user/',
    );
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else {
      // print("ERROR:\nhttp请求出现错误，错误编码为:" + response.statusCode.toString());
      toast("请检查您的网络连接或稍后重试");
      return User(0, "", "", "", "", "", "", 0, false);
    }
  } on DioError catch (e) {
    toast("请检查您的网络情况并稍后重试");
    throw Exception(e.response?.data);
  }
}

Future<dynamic> getPetInfo() async {
  try {
    var response = await Global.dio.get(
      'pet/',
    );
    return response;
  } on DioError catch (e) {
    toast("请检查您的网络情况并稍后重试");
    throw Exception(e.response?.data);
  }
}

// }
