import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpMaskapai {
  bool status;
  String foto;

  HttpMaskapai({this.status, this.foto});

  static Future<HttpMaskapai> saveFotoMaskapai(
    String fotoMaskapai,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/maskapai/save-foto");

    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "FOTO_PSWT": fotoMaskapai,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpMaskapai(
      status: data["status"],
      foto: data["foto"],
    );
  }

  static Future<HttpMaskapai> updateFotoMaskapai(
    String idPswt,
    String fotoPswt,
    String fotoLamaPswt,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/maskapai/update-foto");

    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "NOXX_IDNT": idPswt,
        "FOTO_PSWT": fotoPswt,
        "FOTO_LAMA": fotoLamaPswt,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpMaskapai(
      status: data["status"],
      foto: data["foto"],
    );
  }

  static Future<HttpMaskapai> saveMaskapai(
    String kodeMaskapai,
    String namaMaskapai,
    String fotoMaskapai,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/maskapai/save");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "KODE_PSWT": kodeMaskapai,
        "NAMA_PSWT": namaMaskapai,
        "FOTO_PSWT": fotoMaskapai,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpMaskapai(
      status: data["status"],
    );
  }

  static Future<HttpMaskapai> updateMaskapai(
    String idMaskapai,
    String kodeMaskapai,
    String namaMaskapai,
    String fotoMaskapai,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/maskapai/update");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "IDXX_PSWT": idMaskapai,
        "KODE_PSWT": kodeMaskapai,
        "NAMA_PSWT": namaMaskapai,
        "FOTO_PSWT": fotoMaskapai,
      },
    );
    var data = json.decode(hasilResponse.body);
    return HttpMaskapai(
      status: data["status"],
    );
  }

  static Future<HttpMaskapai> deleteMaskapai(
    String idMaskapai,
    String fotoMaskapai,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/marketing/maskapai/delete");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "IDXX_PSWT": idMaskapai,
        "FOTO_PSWT": fotoMaskapai,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpMaskapai(
      status: data["status"],
    );
  }
}
