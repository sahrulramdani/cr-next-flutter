import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpJamaah {
  bool status;

  HttpJamaah({this.status});

  // JAMAAH
  static Future<HttpJamaah> saveJamaah(
    String nik,
    String namaJamaah,
    String jenisKelamin,
    String tempatLahir,
    String tanggalLahir,
    String alamat,
    String provinsi,
    String kota,
    String kecamatan,
    String kelurahan,
    String kodePos,
    String namaAyah,
    String noTelp,
    String menikah,
    String pendidikan,
    String pekerjaan,
    String noPaspor,
    String dikeluarkanDi,
    String tglKeluar,
    String tglExpire,
    String fotoJamaah,
    String fotoKtpJamaah,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/jamaah/jamaah/save");

    var hasilResponse = await http.post(
      urlApi,
      body: {
        "NOXX_IDNT": nik,
        "NAMA_LGKP": namaJamaah,
        "JENS_KLMN": jenisKelamin,
        "TMPT_LHIR": tempatLahir,
        "TGLX_LHIR": tanggalLahir,
        "ALAMAT": alamat,
        "KDXX_PROV": provinsi,
        "KDXX_KOTA": kota,
        "KDXX_KECX": kecamatan,
        "KDXX_KELX": kelurahan,
        "KDXX_POSX": kodePos,
        "NAMA_AYAH": namaAyah,
        "NOXX_TELP": noTelp,
        "JENS_MNKH": menikah,
        "JENS_PEND": pendidikan,
        "JENS_PKRJ": pekerjaan,
        "FOTO_JMAH": fotoJamaah,
        "FOTO_KTPX": fotoKtpJamaah,
        "NOXX_PSPR": noPaspor ?? '',
        "KLUR_DIXX": dikeluarkanDi ?? '',
        "TGLX_KLUR": tglKeluar ?? '',
        "TGLX_EXPX": tglExpire ?? '',
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpJamaah(
      status: data["status"],
    );
  }

  static Future<HttpJamaah> updateJamaah(
    // String nik,
    // String namaJamaah,
    // String jenisKelamin,
    // String tempatLahir,
    // String tanggalLahir,
    // String alamat,
    // String provinsi,
    // String kota,
    // String kecamatan,
    // String kelurahan,
    // String kodePos,
    // String namaAyah,
    // String noTelp,
    // String menikah,
    // String pendidikan,
    // String pekerjaan,
    // String noPaspor,
    // String dikeluarkanDi,
    // String tglKeluar,
    // String tglExpire,
    String fotoJamaah,
    String fotoKtpJamaah,
    String fotoLamaJamaah,
    String fotoLamaKtpJamaah,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/jamaah/jamaah/update");

    var hasilResponse = await http.post(
      urlApi,
      body: {
        // "NOXX_IDNT": nik,
        // "NAMA_LGKP": namaJamaah,
        // "JENS_KLMN": jenisKelamin,
        // "TMPT_LHIR": tempatLahir,
        // "TGLX_LHIR": tanggalLahir,
        // "ALAMAT": alamat,
        // "KDXX_PROV": provinsi,
        // "KDXX_KOTA": kota,
        // "KDXX_KECX": kecamatan,
        // "KDXX_KELX": kelurahan,
        // "KDXX_POSX": kodePos,
        // "NAMA_AYAH": namaAyah,
        // "NOXX_TELP": noTelp,
        // "JENS_MNKH": menikah,
        // "JENS_PEND": pendidikan,
        // "JENS_PKRJ": pekerjaan,
        "FOTO_JMAH": fotoJamaah,
        "FOTO_KTPX": fotoKtpJamaah,
        // "NOXX_PSPR": noPaspor ?? '',
        // "KLUR_DIXX": dikeluarkanDi ?? '',
        // "TGLX_KLUR": tglKeluar ?? '',
        // "TGLX_EXPX": tglExpire ?? '',
        "FOTO_LAMA": fotoLamaJamaah,
        "KTPX_LAMA": fotoLamaKtpJamaah,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpJamaah(
      status: data["status"],
    );
  }

  static Future<HttpJamaah> deleteJamaah(String kodeJamaah) async {
    Uri urlApi = Uri.parse("$urlAddress/jamaah/jamaah/delete");

    var hasilResponse = await http.post(
      urlApi,
      body: {
        "NOXX_IDNT": kodeJamaah,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpJamaah(
      status: data["status"],
    );
  }
}
