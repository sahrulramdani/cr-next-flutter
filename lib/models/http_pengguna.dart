import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';

class HttpPengguna {
  bool status;
  String foto;

  HttpPengguna({
    this.status,
    this.foto,
  });

  static Future<HttpPengguna> saveFotoUser(
    String username,
    String fotoUser,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/menu/daftar-pengguna/save-foto");

    var hasilResponse = await http.post(
      urlApi,
      body: {
        "USER_IDXX": username,
        "FOTO_USER": fotoUser,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpPengguna(
      status: data["status"],
      foto: data["foto"],
    );
  }

  static Future<HttpPengguna> savePengguna(
    String username,
    String password,
    String namaPengguna,
    String grupAkses,
    String email,
    String namaFoto,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/register");
    var hasilResponse = await http.post(urlApi, body: {
      "USER_IDXX": username,
      "USER_PASS": password,
      "NAME_USER": namaPengguna,
      "GRUP_MENU": grupAkses,
      "EMAIL": email,
      "FOTO_USER": namaFoto,
    });

    var data = json.decode(hasilResponse.body);
    return HttpPengguna(
      status: data["status"],
    );
  }

  static Future<HttpPengguna> updateAksesPengguna(
    String username,
    String detailAkses,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/menu/daftar-pengguna/update-akses");
    var hasilResponse = await http.post(urlApi, body: {
      "USER_IDXX": username,
      "DETX_MENU": detailAkses,
    });

    var data = json.decode(hasilResponse.body);
    return HttpPengguna(
      status: data["status"],
    );
  }

  static Future<HttpPengguna> updateFotoUser(
    String username,
    String fotoUser,
    String fotoLama,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/menu/daftar-pengguna/update-foto");

    var hasilResponse = await http.post(
      urlApi,
      body: {
        "USER_IDXX": username,
        "FOTO_USER": fotoUser,
        "FOTO_LAMA": fotoLama,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpPengguna(
      status: data["status"],
      foto: data["foto"],
    );
  }

  static Future<HttpPengguna> updatePengguna(
    String username,
    String password,
    String namaPengguna,
    String grupAkses,
    String email,
    String namaFoto,
    String status,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/menu/daftar-pengguna/update");
    var hasilResponse = await http.post(urlApi, body: {
      "USER_IDXX": username,
      "USER_PASS": password,
      "NAME_USER": namaPengguna,
      "GRUP_MENU": grupAkses,
      "EMAIL": email,
      "FOTO_USER": namaFoto,
      "Active": status,
    });

    var data = json.decode(hasilResponse.body);
    return HttpPengguna(
      status: data["status"],
    );
  }

  // static Future<HttpPengguna> deleteHotel(String idHotel) async {
  //   Uri urlApi = Uri.parse("$urlAddress/marketing/hotel/delete");
  //   var hasilResponse = await http.post(urlApi, body: {
  //     "IDXX_PSWT": idHotel,
  //   });

  //   var data = json.decode(hasilResponse.body);
  //   return HttpPengguna(
  //     status: data["status"],
  //   );
  // }
}
