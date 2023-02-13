import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpTransit {
  bool status;

  HttpTransit({this.status});

  static Future<HttpTransit> saveRuteTransit(String namaTransit) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/rutetransit/save");
    var hasilResponse = await http.post(urlApi, body: {
      "NAMA_NEGR": namaTransit,
    });

    var data = json.decode(hasilResponse.body);
    return HttpTransit(
      status: data["status"],
    );
  }

  static Future<HttpTransit> updateRuteTransit(
      String idTransit, String namaTransit) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/rutetransit/update");
    var hasilResponse = await http.post(urlApi, body: {
      "IDXX_RTS": idTransit,
      "NAMA_NEGR": namaTransit,
    });
    var data = json.decode(hasilResponse.body);
    return HttpTransit(
      status: data["status"],
    );
  }

  static Future<HttpTransit> deleteRuteTransit(String idTransit) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/rutetransit/delete");
    var hasilResponse = await http.post(urlApi, body: {
      "IDXX_RTS": idTransit,
    });

    var data = json.decode(hasilResponse.body);
    return HttpTransit(
      status: data["status"],
    );
  }
}
