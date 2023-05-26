import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';

class HttpTourleader {
  bool status;

  HttpTourleader({this.status});

  static Future<HttpTourleader> saveTugasTourleader(
    String idJadwal,
    String listTourlead,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/tourlead/save-tugas-tl");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KDXX_JDWL": idJadwal,
        "LIST_TL": listTourlead,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpTourleader(
      status: data["status"],
    );
  }

  static Future<HttpTourleader> deleteTugasTL(String idTugas) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/tourlead/delete-tugas-tl");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KDXX_JDTL": idTugas,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpTourleader(
      status: data["status"],
    );
  }
}
