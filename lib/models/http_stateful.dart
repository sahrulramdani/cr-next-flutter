// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'dart:convert';
import 'package:flutter_web_course/constants/style.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpStateful {
  bool status;
  String userToken;
  String namaUser;
  String username;
  String fotoUser;
  String kodeAgen;

  HttpStateful({
    this.status,
    this.userToken,
    this.namaUser,
    this.username,
    this.fotoUser,
    this.kodeAgen,
  });

  static Future<HttpStateful> connectAPI(
      String user, String pass, String company) async {
    Uri urlApi = Uri.parse("$urlAddress/signin");

    var hasilResponse = await http.post(
      urlApi,
      body: {
        "USER_LOGN": user,
        "BUSS_CODE": company,
        "PASS_IDXX": pass,
      },
    );

    var data = json.decode(hasilResponse.body);
    // print(data);
    // SharedPreferences.setMockInitialValues({});
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('token', data["token"]);

    // final myPrefs = json.encode({
    //   "userToken": data["token"],
    //   "namaUser": data["namaUser"],
    //   "username": data["username"],
    //   "fotoUser": data["fotoUser"],
    //   "kodeAgen": data["kodeAgen"],
    // });

    // prefs.setString('authData', myPrefs);

    return HttpStateful(
      status: data["status"],
      userToken: data["token"],
      namaUser: data["namaUser"],
      username: data["username"],
      fotoUser: data["fotoUser"],
      kodeAgen: data["kodeAgen"],
    );
  }
}
