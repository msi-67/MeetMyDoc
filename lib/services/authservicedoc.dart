import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = Dio();
  login(name, password) async {
    try {
      return await dio.post('http://localhost:3000/authenticatedoc',
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

  addUser(name, username, speciality, mobile, password) async {
    return await dio.post('http://localhost:3000/adddoc',
        data: {
          "name": name,
          "username": username,
          "speciality": speciality,
          "mobile": mobile,
          "password": password
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  getInfo(token) async {
    dio.options.headers['Authorization'] = 'Bearer $token';
    return await dio.get('http://localhost:3000/getdocinfo');
  }

  removeLink(docid, patid) async {
    print(docid);
    print(patid);
    try {
      await dio.post('http://localhost:3000/getmypateints/removeLink',
          data: {"docid": docid, "patid": patid});
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
}
