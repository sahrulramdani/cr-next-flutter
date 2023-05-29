import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpMusim {
  bool status;

  HttpMusim({this.status});

  static Future<HttpMusim> saveMusim(
    String tglAwal,
    String tglAkhir,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/setup/musim/save");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "AWAL_MUSM": tglAwal,
        "AKHR_MUSM": tglAkhir,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpMusim(
      status: data["status"],
    );
  }

  static Future<HttpMusim> updateMusim(
    String idMusim,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/setup/musim/update-aktif");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KDXX_MUSM": idMusim,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpMusim(
      status: data["status"],
    );
  }
}
