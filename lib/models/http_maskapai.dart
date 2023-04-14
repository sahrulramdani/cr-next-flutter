import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpMaskapai {
  bool status;

  HttpMaskapai({this.status});

  static Future<HttpMaskapai> saveMaskapai(
      String kodeMaskapai, String namaMaskapai) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/maskapai/save");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KODE_PSWT": kodeMaskapai,
        "NAMA_PSWT": namaMaskapai,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpMaskapai(
      status: data["status"],
    );
  }

  static Future<HttpMaskapai> updateMaskapai(
      String idMaskapai, String kodeMaskapai, String namaMaskapai) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/maskapai/update");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "IDXX_PSWT": idMaskapai,
        "KODE_PSWT": kodeMaskapai,
        "NAMA_PSWT": namaMaskapai,
      },
    );
    var data = json.decode(hasilResponse.body);
    return HttpMaskapai(
      status: data["status"],
    );
  }

  static Future<HttpMaskapai> deleteMaskapai(String idMaskapai) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/maskapai/delete");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "IDXX_PSWT": idMaskapai,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpMaskapai(
      status: data["status"],
    );
  }
}
