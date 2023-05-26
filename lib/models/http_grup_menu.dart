import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpGrupMenu {
  bool status;

  HttpGrupMenu({this.status});

  static Future<HttpGrupMenu> saveGrupMenu(
    String kodeGrup,
    String namaGrup,
    String keterangan,
    String detailGrup,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/menu/grup-user/save");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KDXX_GRUP": kodeGrup,
        "NAMA_GRUP": namaGrup,
        "KETERANGAN": keterangan,
        "DETX_GRUP": detailGrup
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpGrupMenu(
      status: data["status"],
    );
  }

  static Future<HttpGrupMenu> updateGrupMenu(
    String kodeGrup,
    String namaGrup,
    String keterangan,
    String statusGrup,
    String detailGrup,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/menu/grup-user/update");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KDXX_GRUP": kodeGrup,
        "NAMA_GRUP": namaGrup,
        "KETERANGAN": keterangan,
        "STAS_GRUP": statusGrup,
        "DETX_GRUP": detailGrup
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpGrupMenu(
      status: data["status"],
    );
  }

  static Future<HttpGrupMenu> deleteGrupMenu(String idGrup) async {
    Uri urlApi = Uri.parse("$urlAddress/menu/grup-user/delete");
    var hasilResponse = await http.post(urlApi, body: {
      "KDXX_GRUP": idGrup,
    });

    var data = json.decode(hasilResponse.body);
    return HttpGrupMenu(
      status: data["status"],
    );
  }
}
