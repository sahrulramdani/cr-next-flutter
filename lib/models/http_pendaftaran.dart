import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpPendaftaran {
  bool status;
  String namaKk;
  String namaDok;

  HttpPendaftaran({this.status, this.namaKk, this.namaDok});

  static Future<HttpPendaftaran> saveFotoPendaftaran(
    String nik,
    String kkBase,
    String dokumenBase,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/jamaah/pendaftaran/save-foto");
    var hasilResponse = await http.post(urlApi, body: {
      "NOXX_IDNT": nik,
      "FOTO_KKXX": kkBase,
      "FOTO_DOCX": dokumenBase,
    });

    var data = json.decode(hasilResponse.body);
    return HttpPendaftaran(
      status: data["status"],
      namaKk: data["kkxx"],
      namaDok: data["dokx"],
    );
  }

  static Future<HttpPendaftaran> savePendaftaran(
    String idPelanggan,
    String idKantor,
    String nik,
    String idProduk,
    String ktp,
    String kk,
    String lampiran,
    String pembuatan,
    String vaksin,
    String handling,
    String refrensi,
    String namaAgency,
    String estimasi,
    String jatuhTempo,
    String listTagihan,
    String namaKk,
    String namaDok,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/jamaah/pendaftaran/save");
    var hasilResponse = await http.post(urlApi, body: {
      "KDXX_DFTR": idPelanggan,
      "KDXX_KNTR": idKantor,
      "NOXX_IDNT": nik,
      "KDXX_JDWL": idProduk,
      "DOKX_KTPX": ktp,
      "DOKX_KKXX": kk,
      "DOKX_LAIN": lampiran,
      "PEMB_PSPR": pembuatan,
      "PRSS_VKSN": vaksin,
      "HANDLING": handling,
      "REFRENSI": refrensi,
      "KDXX_MRKT": namaAgency,
      "ESTX_TOTL": estimasi,
      "JTUH_TEMP": jatuhTempo,
      "NAMA_KKXX": namaKk,
      "NAMA_DOCX": namaDok,
      "TAGIHAN": listTagihan,
    });

    var data = json.decode(hasilResponse.body);
    return HttpPendaftaran(
      status: data["status"],
    );
  }
}
