import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = Dio();
  login(name, password) async {
    try {
      return await dio.post('http://localhost:3000/authenticate',
          data: {"username": name, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  addUser(name, username, mobile, password) async {
    return await dio.post('http://localhost:3000/addUser',
        data: {
          "name": name,
          "username": username,
          "mobile": mobile,
          "password": password
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  getInfo(token) async {
    dio.options.headers['Authorization'] = 'Bearer $token';
    return await dio.get('http://localhost:3000/getInfo');
  }

  getAlldoc(patid) async {
    return await dio
        .post('http://localhost:3000/getAlldoc', data: {"patid": patid});
  }

  setupMeeting(docid, pateinttoken) async {
    print(docid);
    print(pateinttoken);
    final response = await dio.post('http://localhost:3000/setupMeeting',
        data: {"docid": docid, "patid": pateinttoken});
  }
}
