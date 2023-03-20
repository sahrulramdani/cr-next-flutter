import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpJamaah {
  bool status;
  String foto;
  String ktpx;

  HttpJamaah({this.status, this.foto, this.ktpx});

  // JAMAAH
  static Future<HttpJamaah> saveFotoJamaah(
    String nik,
    String fotoJamaah,
    String fotoKtpJamaah,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/jamaah/jamaah/save-foto");

    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "NOXX_IDNT": nik,
        "FOTO_JMAH": fotoJamaah,
        "FOTO_KTPX": fotoKtpJamaah,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpJamaah(
      status: data["status"],
      foto: data["foto"],
      ktpx: data["ktpx"],
    );
  }

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
    String namaFoto,
    String namaKtp,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/jamaah/jamaah/save");

    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
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
        "NAMA_FOTO": namaFoto,
        "NAMA_KTPX": namaKtp,
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

  static Future<HttpJamaah> updateFotoJamaah(
    String nik,
    String fotoJamaah,
    String fotoKtpJamaah,
    String fotoLamaJamaah,
    String fotoLamaKtpJamaah,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/jamaah/jamaah/update-foto");

    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "NOXX_IDNT": nik,
        "FOTO_JMAH": fotoJamaah,
        "FOTO_KTPX": fotoKtpJamaah,
        "FOTO_LAMA": fotoLamaJamaah,
        "KTPX_LAMA": fotoLamaKtpJamaah,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpJamaah(
      status: data["status"],
      foto: data["foto"],
      ktpx: data["ktpx"],
    );
  }

  static Future<HttpJamaah> updateJamaah(
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
    String namaFoto,
    String namaKtp,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/jamaah/jamaah/update");

    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
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
        "NOXX_PSPR": noPaspor ?? '',
        "KLUR_DIXX": dikeluarkanDi ?? '',
        "TGLX_KLUR": tglKeluar ?? '',
        "TGLX_EXPX": tglExpire ?? '',
        "NAMA_FOTO": namaFoto,
        "NAMA_KTPX": namaKtp,
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
      headers: {
        'pte-token': kodeToken,
      },
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
