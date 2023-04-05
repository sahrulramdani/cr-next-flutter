import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpPembayaran {
  bool status;

  HttpPembayaran({this.status});

  static Future<HttpPembayaran> savePembayaran(
    String nomorFaktur,
    String idPendaftaran,
    String totalBayar,
    String metode,
    // String bank,
    String mutasi,
    String keterangan,
    String uangDiterima,
    String detailTagihan,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/finance/pembayaran/save");
    var hasilResponse = await http.post(urlApi, body: {
      "NOXX_FAKT": nomorFaktur,
      "KDXX_DFTR": idPendaftaran,
      "TOTL_BYAR": totalBayar,
      "METODE": metode,
      // "KDXX_BANK": bank,
      "TRNS_NUMBER": mutasi,
      "KETERANGAN": keterangan,
      "UANG_DITE": uangDiterima,
      "DETX_TGIH": detailTagihan,
    });

    var data = json.decode(hasilResponse.body);
    return HttpPembayaran(
      status: data["status"],
    );
  }
}
