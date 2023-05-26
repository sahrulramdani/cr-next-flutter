// ignore_for_file: non_constant_identifier_names

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
      headers: {
        'pte-token': kodeToken,
      },
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
    String kategori,
    String agen,
    String kantor,
    String namaPengguna,
    String grupAkses,
    String email,
    String namaFoto,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/register");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "USER_IDXX": username,
        "USER_PASS": password,
        "KATX_USER": kategori,
        "KDXX_MRKT": agen,
        "UNIT_KNTR": kantor,
        "NAME_USER": namaPengguna,
        "GRUP_MENU": grupAkses,
        "EMAIL": email,
        "FOTO_USER": namaFoto,
      },
    );

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
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "USER_IDXX": username,
        "DETX_MENU": detailAkses,
      },
    );

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
      headers: {
        'pte-token': kodeToken,
      },
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
    String kategori,
    String agen,
    String kantor,
    String namaPengguna,
    String grupAkses,
    String email,
    String namaFoto,
    String status,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/menu/daftar-pengguna/update");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "USER_IDXX": username,
        "USER_PASS": password,
        "KATX_USER": kategori,
        "KDXX_MRKT": agen,
        "UNIT_KNTR": kantor,
        "NAME_USER": namaPengguna,
        "GRUP_MENU": grupAkses,
        "EMAIL": email,
        "FOTO_USER": namaFoto,
        "ACTIVE": status,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpPengguna(
      status: data["status"],
    );
  }

  static Future<HttpPengguna> saveMenu(
    String modulecode,
    String modulenama,
    String path,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/menu/menus/save");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "MDUL_CODE": modulecode,
        "MENU_NAME": modulenama,
        "PATH": path,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpPengguna(
      status: data["status"],
    );
  }

  static Future<HttpPengguna> saveSubmenu(
    String idMenu,
    String subMenuName,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/menu/submenus/save");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "MDUL_CODE": idMenu,
        "SUBMENU_NAME": subMenuName,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpPengguna(
      status: data["status"],
    );
  }

  static Future<HttpPengguna> savelistmenu(
    String idSubmenu,
    String idmenu,
    String listName,
    String Path,
    String typemdul,
  ) async {
    Uri urlApi = Uri.parse("$urlAddress/menu/listmenus/save");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "SUBMENU_CODE": idSubmenu,
        "ID_MENU": idmenu,
        "LIST_NAME": listName,
        "PATH": Path,
        "TYPE_MDUL": typemdul,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpPengguna(
      status: data["status"],
    );
  }

  static Future<HttpPengguna> deletePengguna(String idKantor) async {
    Uri urlApi = Uri.parse("$urlAddress/menu/daftar-pengguna/delete");
    var hasilResponse = await http.post(
      urlApi,
      headers: {
        'pte-token': kodeToken,
      },
      body: {
        "USER_IDXX": idKantor,
      },
    );

    var data = json.decode(hasilResponse.body);
    return HttpPengguna(
      status: data["status"],
    );
  }
}
