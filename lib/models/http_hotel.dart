import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpHotel {
  bool status;

  HttpHotel({this.status});

  static Future<HttpHotel> saveHotel(String namaHotel, String idbintang) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/hotel/save");
    var hasilResponse = await http.post(urlApi, body: {
      "NAMA_HTLX": namaHotel,
      "BINTG_HTLX": idbintang,
    });

    var data = json.decode(hasilResponse.body);
    return HttpHotel(
      status: data["status"],
    );
  }

  static Future<HttpHotel> updateHotel(
      String idHotel, String namaHotel, String idbintang) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/hotel/update");
    var hasilResponse = await http.post(urlApi, body: {
      "IDXX_HTLX": idHotel,
      "NAMA_HTLX": namaHotel,
      "BINTG_HTLX": idbintang,
    });
    var data = json.decode(hasilResponse.body);
    return HttpHotel(
      status: data["status"],
    );
  }

  static Future<HttpHotel> deleteHotel(String idHotel) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/hotel/delete");
    var hasilResponse = await http.post(urlApi, body: {
      "IDXX_PSWT": idHotel,
    });

    var data = json.decode(hasilResponse.body);
    return HttpHotel(
      status: data["status"],
    );
  }
}
