import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpSatuan {
  bool status;

  HttpSatuan({this.status});

  static Future<HttpSatuan> saveSatuan(String satuan) async {
    Uri urlApi = Uri.parse("$urlAddress/inventory/satuan/save");
    var hasilResponse = await http.post(urlApi, body: {
      "IDXX_STAN": fncRandomId(10),
      "NAMA_STAN": satuan,
    });

    var data = json.decode(hasilResponse.body);
    return HttpSatuan(
      status: data["status"],
    );
  }

  static Future<HttpSatuan> updateSatuan(
      String idSatuan, String namaSatuan) async {
    Uri urlApi = Uri.parse("$urlAddress/inventory/satuan/update");
    var hasilResponse = await http.post(urlApi, body: {
      "IDXX_STAN": idSatuan,
      "NAMA_STAN": namaSatuan,
    });

    var data = json.decode(hasilResponse.body);
    return HttpSatuan(
      status: data["status"],
    );
  }

  static Future<HttpSatuan> deleteSatuan(String idSatuan) async {
    Uri urlApi = Uri.parse("$urlAddress/inventory/satuan/delete");
    var hasilResponse = await http.post(
      urlApi,
      body: {
        "IDXX_STAN": idSatuan,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpSatuan(
      status: data["status"],
    );
  }
}
