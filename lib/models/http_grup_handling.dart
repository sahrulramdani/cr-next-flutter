// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpGrupHandling {
  bool status;

  HttpGrupHandling({this.status});

  static Future<HttpGrupHandling> saveGrupHandlingDetail(
    String idGrupHeader,
    String idBarang,
    String quantity,
  ) async {
    Uri urlApi =
        Uri.parse("$urlAddress/inventory/handling/handling-barang/save");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KDXX_GHAN": idGrupHeader,
        "KDXX_BRGX": idBarang,
        "QTYX_BRGX": quantity,
        "CRTX_BYXX": username,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpGrupHandling(
      status: data["status"],
    );
  }

  static Future<HttpGrupHandling> deleteGrupHandlingDetail(
    String idGrup,
    String idBarang,
  ) async {
    Uri urlApi =
        Uri.parse("$urlAddress/inventory/handling/handling-barang/delete");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KDXX_GHAN": idGrup,
        "KDXX_BRGX": idBarang,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpGrupHandling(
      status: data["status"],
    );
  }
}
