import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpCostStructure {
  bool status;
  HttpCostStructure({this.status});

  static Future<HttpCostStructure> saveCostSructure(
    String sumberDana,
    String namaBiaya,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/finance/cost-structure/save");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "SUMB_DANA": sumberDana,
        "NAMA_BIAYA": namaBiaya,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpCostStructure(
      status: data["status"],
    );
  }

  static Future<HttpCostStructure> deleteCostSructure(
    String idBiaya,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/finance/cost-structure/delete");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KDXX_CSXX": idBiaya,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpCostStructure(
      status: data["status"],
    );
  }
}
