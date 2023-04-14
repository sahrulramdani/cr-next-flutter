import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';

class HttpKompPendapatan {
  bool status;

  HttpKompPendapatan({this.status});

  static Future<HttpKompPendapatan> saveKompPendapatan(
      String deskripsi, String tipe) async {
    Uri urlApi = Uri.parse("$urlAddress/finance/pendapatan-biaya/save");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "DESKRIPSI": deskripsi,
        "TIPE_PBYA": tipe,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpKompPendapatan(
      status: data["status"],
    );
  }

  static Future<HttpKompPendapatan> updateKompPendapatan(
      String idBiaya, String deskripsi, String tipe) async {
    Uri urlApi = Uri.parse("$urlAddress/finance/pendapatan-biaya/update");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KDXX_PBYA": idBiaya,
        "DESKRIPSI": deskripsi,
        "TIPE_PBYA": tipe,
      },
    );
    var data = json.decode(hasilResponse.body);
    return HttpKompPendapatan(
      status: data["status"],
    );
  }

  static Future<HttpKompPendapatan> deleteKompPendapatan(String idBiaya) async {
    Uri urlApi = Uri.parse("$urlAddress/finance/pendapatan-biaya/delete");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KDXX_PBYA": idBiaya,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpKompPendapatan(
      status: data["status"],
    );
  }
}
