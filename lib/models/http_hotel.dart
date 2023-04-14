import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpHotel {
  bool status;

  HttpHotel({this.status});

  static Future<HttpHotel> saveHotel(String namaHotel, String idbintang,
      String lokasi, String alamat, String idKategori) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/hotel/save");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "NAMA_HTLX": namaHotel,
        "BINTG_HTLX": idbintang,
        "LOKX_HTLX": lokasi,
        "ALMT_HTLX": alamat,
        'KTGR_HTLX': idKategori,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpHotel(
      status: data["status"],
    );
  }

  static Future<HttpHotel> updateHotel(String idHotel, String namaHotel,
      String idbintang, String lokasi, String alamat, String idKategori) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/hotel/update");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "IDXX_HTLX": idHotel,
        "NAMA_HTLX": namaHotel,
        "BINTG_HTLX": idbintang,
        "LOKX_HTLX": lokasi,
        "ALMT_HTLX": alamat,
        "KTGR_HTLX": idKategori,
      },
    );
    var data = json.decode(hasilResponse.body);
    return HttpHotel(
      status: data["status"],
    );
  }

  static Future<HttpHotel> deleteHotel(String idHotel) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/hotel/delete");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "IDXX_HTLX": idHotel,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpHotel(
      status: data["status"],
    );
  }
}
