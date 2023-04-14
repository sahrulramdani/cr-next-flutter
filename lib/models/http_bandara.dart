import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpBandara {
  bool status;

  HttpBandara({this.status});

  static Future<HttpBandara> saveBandara(
    String kodeBandara,
    String namaBandara,
    String jenis,
    String negara,
    String provinsi,
    String kota,
    String keterangan,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/bandara/save");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KDXX_BAND": kodeBandara,
        "NAMA_BAND": namaBandara,
        "JENS_BAND": jenis,
        "NEGR_BAND": negara,
        'PROV_BAND': provinsi,
        'KOTA_BAND': kota,
        'KETERANGAN': keterangan,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpBandara(
      status: data["status"],
    );
  }

  static Future<HttpBandara> updateBandara(
    String idBandara,
    String kodeBandara,
    String namaBandara,
    String jenis,
    String negara,
    String provinsi,
    String kota,
    String keterangan,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/bandara/update");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "IDXX_BAND": idBandara,
        "KDXX_BAND": kodeBandara,
        "NAMA_BAND": namaBandara,
        "JENS_BAND": jenis,
        "NEGR_BAND": negara,
        'PROV_BAND': provinsi,
        'KOTA_BAND': kota,
        'KETERANGAN': keterangan,
      },
    );
    var data = json.decode(hasilResponse.body);
    return HttpBandara(
      status: data["status"],
    );
  }

  static Future<HttpBandara> deleteBandara(String idBandara) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/bandara/delete");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "IDXX_BAND": idBandara,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpBandara(
      status: data["status"],
    );
  }
}
