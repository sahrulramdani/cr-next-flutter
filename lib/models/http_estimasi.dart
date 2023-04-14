import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpEstimasi {
  bool status;
  HttpEstimasi({this.status});

  static Future<HttpEstimasi> saveEstimasi(
    String kodePaket,
    String jenisSumberDana,
    String nominalSumberDana,
    String listDetailBiaya,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/finance/estimasi-paket/save");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KDXX_PKET": kodePaket,
        "SUMB_DANA": jenisSumberDana,
        "NOMX_SUMD": nominalSumberDana,
        "LIST_DETX": listDetailBiaya,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpEstimasi(
      status: data["status"],
    );
  }
}
