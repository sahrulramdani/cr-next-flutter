import 'dart:async';
import 'dart:convert';
import 'package:flutter_web_course/constants/style.dart';
import "package:http/http.dart" as http;

class HttpStateful {
  bool status;
  String userToken;
  String namaUser;
  String fotoUser;

  HttpStateful({this.status, this.userToken, this.namaUser, this.fotoUser});

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
    // ignore: avoid_print
    // print(data);
    // print(hasilResponse.body);
    return HttpStateful(
      status: data["status"],
      userToken: data["token"],
      namaUser: data["namaUser"],
      fotoUser: data["fotoUser"],
    );
  }
}
