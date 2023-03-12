import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpBiaya {
  bool status;

  HttpBiaya({this.status});

  static Future<HttpBiaya> saveBiaya(
    String idBiaya,
    String namaBiaya,
    String jenisBiaya,
    String nominal,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/finance/biaya/biaya/save");
    var hasilResponse = await http.post(urlApi, body: {
      "KDXX_BYAX": idBiaya,
      "NAMA_BYAX": namaBiaya,
      "JENS_BYAX": jenisBiaya,
      "JMLH_BYAX": nominal,
    });

    var data = json.decode(hasilResponse.body);
    return HttpBiaya(
      status: data["status"],
    );
  }

  static Future<HttpBiaya> updateBiaya(
    String idBiaya,
    String namaBiaya,
    String jenisBiaya,
    String nominal,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/finance/biaya/biaya/update");
    var hasilResponse = await http.post(urlApi, body: {
      "KDXX_BYAX": idBiaya,
      "NAMA_BYAX": namaBiaya,
      "JENS_BYAX": jenisBiaya,
      "JMLH_BYAX": nominal,
    });

    var data = json.decode(hasilResponse.body);
    return HttpBiaya(
      status: data["status"],
    );
  }

  static Future<HttpBiaya> deleteBiaya(String idBiaya) async {
    Uri urlApi = Uri.parse("$urlAddress/finance/biaya/biaya/delete");
    var hasilResponse = await http.post(
      urlApi,
      body: {
        "KDXX_BYAX": idBiaya,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpBiaya(
      status: data["status"],
    );
  }
}
