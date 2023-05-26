// ignore: undefined_prefixed_name
// ignore_for_file: unused_import, missing_return, deprecated_member_use, void_checks

import 'dart:ui' as ui;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/pages/landing/pendaftaran/content/data_diri_content.dart';
import 'package:flutter_web_course/pages/landing/pendaftaran/content/detail_biaya_content.dart';
import 'package:flutter_web_course/pages/landing/pendaftaran/widgets/description-paket-daftar.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/not_find_widget.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/responsive_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_web_course/models/http_pendaftaran.dart';
import 'package:flutter_web_course/models/http_jamaah.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:js/js_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormPendaftaranContent extends ResponsiveWidget {
  const FormPendaftaranContent({Key key}) : super(key: key);

  @override
  Widget buildDesktop(BuildContext context) =>
      const DesktopFormPendaftaranContent();

  @override
  Widget buildMobile(BuildContext context) =>
      const DesktopFormPendaftaranContent();
}

class DesktopFormPendaftaranContent extends StatefulWidget {
  const DesktopFormPendaftaranContent({Key key}) : super(key: key);

  @override
  State<DesktopFormPendaftaranContent> createState() =>
      _DesktopFormPendaftaranContentState();
}

class _DesktopFormPendaftaranContentState
    extends State<DesktopFormPendaftaranContent> with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> listProvinsi = [];
  List<Map<String, dynamic>> listKota = [];
  List<Map<String, dynamic>> listKec = [];
  List<Map<String, dynamic>> listKel = [];
  List<Map<String, dynamic>> listMenikah = [];
  List<Map<String, dynamic>> listPendidikan = [];
  List<Map<String, dynamic>> listPekerjaan = [];

  List<Map<String, dynamic>> listJadwal = [];
  List<Map<String, dynamic>> listBiayaPaspor = [];
  List<Map<String, dynamic>> listBiayaVaksin = [];
  List<Map<String, dynamic>> listBiayaKamar = [];

  List<Map<String, dynamic>> listBarangHandling = [];
  List<Map<String, dynamic>> listBarangPelanggan = [];
  List<Map<String, dynamic>> listTagihan = [];

  String identitas;
  String jamaah;
  String jenisKelamin;
  String jk;
  String tempatLahir;
  String alamat;
  String idProvinsi;
  String namaProvinsi;
  String idKota;
  String namaKota;
  String idKec;
  String namaKec;
  String idKel;
  String namaKel;
  String kodePos;
  String namaAyah;
  String noTelp;
  String idMenikah;
  String namaMenikah;
  String idPendidikan;
  String namaPendidikan;
  String idPekerjaan;
  String namaPekerjaan;

  String idProduk;
  String judul;
  String keterangan;
  int harga;
  String mataUang;
  String pesawatBgkt;
  String pesawatPlng;
  String rute;
  String hotelMek;
  String hotelMad;
  String hotelTra;
  String hotelPls;
  int sisa;
  String berangkat;
  String pulang;
  int durasi;

  String kk;
  String ktp;
  String lampiran;
  String pembuatan = '';
  String vaksin;
  String kamar;
  String handling;
  String textHandling = 'List Barang Handling';
  String refrensi;
  String idAgency;
  String namaAgency;
  String totalEst;

  String paket;
  String tarif;
  String umur;
  String paspor;
  String fasilitas;
  // String biaya;
  String biayaVaksin = '0';
  String biayaPaspor = '0';
  String biayaAdmin = '0';
  String biayaKamar = '0';
  String biayaHandling = '0';
  String estimasi = '0';

  String fotoJadwal = "";

  String ktpPelanggan = "";
  String ktpPelangganBase = "";
  Uint8List ktpPelangganByte;

  String fotoKkPelanggan = "";
  String fotoKkPelangganBase = "";
  Uint8List fotoKkPelangganByte;

  String fotoDokPelanggan = "";
  String fotoDokPelangganBase = "";
  Uint8List fotoDokPelangganByte;

  TextEditingController dateLahir = TextEditingController();

  // ==== GET DATA ==========

  void getAgency() async {
    var idAgen = Get.parameters['kode'];
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/agency/detail/$idAgen"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    if (dataStatus.isNotEmpty) {
      setState(() {
        idAgency = dataStatus[0]['KDXX_MRKT'];
        namaAgency = dataStatus[0]['NAMA_LGKP'];
      });
    }
  }

  void getProvinsi() async {
    var response = await http.get(Uri.parse(
        "https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    listProvinsi = dataStatus;
    setState(() {});
  }

  getKota(id) async {
    var response = await http.get(Uri.parse(
        "https://www.emsifa.com/api-wilayah-indonesia/api/regencies/$id.json"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listKota = dataStatus;
    });
  }

  getKec(id) async {
    var response = await http.get(Uri.parse(
        "https://www.emsifa.com/api-wilayah-indonesia/api/districts/$id.json"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listKec = dataStatus;
    });
  }

  getKel(id) async {
    var response = await http.get(Uri.parse(
        "https://www.emsifa.com/api-wilayah-indonesia/api/villages/$id.json"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listKel = dataStatus;
    });
  }

  getMenikah() async {
    var response =
        await http.get(Uri.parse("$urlAddress/setup/status-menikah"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listMenikah = dataStatus;
    });
  }

  getPendidikan() async {
    var response =
        await http.get(Uri.parse("$urlAddress/setup/pendidikans"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listPendidikan = dataStatus;
    });
  }

  getPekerjaan() async {
    var response =
        await http.get(Uri.parse("$urlAddress/setup/pekerjaans"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listPekerjaan = dataStatus;
    });
  }

  getJadwal() async {
    var id = Get.parameters['id'];
    NumberFormat myformat = NumberFormat.decimalPattern('en_us');

    var response = await http.get(
        Uri.parse("$urlAddress/marketing/jadwal/getDetailDash/$id"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    if (data.isNotEmpty) {
      setState(() {
        listJadwal = data;
        idProduk = data[0]['IDXX_JDWL'];
        judul = data[0]['jenisPaket'];
        keterangan = data[0]['KETERANGAN'];
        tarif = myformat.format(data[0]['TARIF_PKET'] ?? 0);
        harga = data[0]['TARIF_PKET'];
        mataUang = data[0]['MATA_UANG'];
        pesawatBgkt = data[0]['PESAWAT_BERANGKAT'];
        pesawatPlng = data[0]['PESAWAT_PULANG'];
        rute = data[0]['KETX_RUTE'];
        hotelMek = data[0]['HOTEL_MEKKAH'];
        hotelMad = data[0]['HOTEL_MADINAH'];
        hotelTra = data[0]['HOTEL_TAMBAH'];
        hotelPls = data[0]['HOTEL_PLUS'];
        sisa = data[0]['SISA'];
        berangkat = data[0]['TGLX_BGKT'];
        pulang = data[0]['TGLX_PLNG'];
        durasi = data[0]['JMLX_HARI'];
        fotoJadwal = data[0]['FOTO_PKET'];
        paket = data[0]["namaPaket"] +
            ' ' +
            data[0]['jenisPaket'] +
            ' - ' +
            data[0]['KETERANGAN'];
      });
    }

    fncTotal();
  }

  void getBiayaPaspor() async {
    var response =
        await http.get(Uri.parse("$urlAddress/setup/biaya-paspor"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listBiayaPaspor = dataStatus;
    });
  }

  void getBiayaVaksin() async {
    var response =
        await http.get(Uri.parse("$urlAddress/setup/biaya-vaksin"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listBiayaVaksin = dataStatus;
    });
  }

  void getBiayaKamar() async {
    var response =
        await http.get(Uri.parse("$urlAddress/setup/biaya-kamar"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listBiayaKamar = dataStatus;
    });
  }

  void getBarangHandling(jk) async {
    var response = await http.get(
        Uri.parse("$urlAddress/jamaah/pendaftaran/get-handling/$jk"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listBarangHandling = [];
    });

    for (var i = 0; i < dataStatus.length; i++) {
      var barang = {
        "KDXX_BRGX": dataStatus[i]['KDXX_BRGX'].toString(),
        "NAMA_BRGX": dataStatus[i]['NAMA_BRGX'].toString(),
        "JENS_BRGX": dataStatus[i]['JENS_BRGX'].toString(),
        "STOK_BRGX": dataStatus[i]['STOK_BRGX'].toString(),
        "HRGX_BELI": dataStatus[i]['HRGX_BELI'].toString(),
        "HRGX_JUAL": dataStatus[i]['HRGX_JUAL'].toString(),
        "KETERANGAN": dataStatus[i]['KETERANGAN'].toString(),
        "JMLH": dataStatus[i]['JMLH'].toString(),
        "SUBTOTAL":
            (dataStatus[i]['HRGX_JUAL'] * dataStatus[i]['JMLH']).toString(),
        "CEK": dataStatus[i]['JMLH'] == 0 ? false : true,
      };
      listBarangHandling.add(barang);
    }

    int ttl = 0;
    for (var j = 0; j < dataStatus.length; j++) {
      if (dataStatus[j]['JMLH'] != 0) {
        ttl += (dataStatus[j]['HRGX_JUAL'] * dataStatus[j]['JMLH']);
      }
    }

    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    setState(() {
      biayaHandling = myFormat.format(ttl).toString();
    });
  }

  fncClear() {
    setState(() {
      listBarangHandling = [];
      listBarangPelanggan = [];
      listTagihan = [];
      identitas = null;
      jamaah = null;
      jenisKelamin = null;
      jk = null;
      tempatLahir = null;
      alamat = null;
      idProvinsi = null;
      namaProvinsi = null;
      idKota = null;
      namaKota = null;
      idKec = null;
      namaKec = null;
      idKel = null;
      namaKel = null;
      kodePos = null;
      namaAyah = null;
      noTelp = null;
      idMenikah = null;
      namaMenikah = null;
      idPendidikan = null;
      namaPendidikan = null;
      idPekerjaan = null;
      namaPekerjaan = null;
      kk = null;
      ktp = null;
      lampiran = null;
      pembuatan = null;
      vaksin = null;
      kamar = null;
      handling = null;
      textHandling = 'List Barang Handling';
      refrensi = null;
      totalEst = null;
      umur = null;
      paspor = null;
      fasilitas = null;
      biayaVaksin = '0';
      biayaPaspor = '0';
      biayaAdmin = '0';
      biayaKamar = '0';
      biayaHandling = '0';
      estimasi = '0';
      ktpPelanggan = "";
      ktpPelangganBase = "";
      ktpPelangganByte = null;
      fotoKkPelanggan = "";
      fotoKkPelangganBase = "";
      fotoKkPelangganByte = null;
      fotoDokPelanggan = "";
      fotoDokPelangganBase = "";
      fotoDokPelangganByte = null;
      dateLahir.text = '';
    });
  }

  @override
  void initState() {
    getAgency();
    getJadwal();
    getProvinsi();
    getMenikah();
    getPendidikan();
    getPekerjaan();
    getBiayaPaspor();
    getBiayaVaksin();
    getBiayaKamar();
    super.initState();
  }

  // ==== GET DATA ==========

  Widget inputNIK() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: InputDecoration(
        label: const Text('NIK *'),
        hintText: '327xxxxxxxx',
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey[200])),
      ),
      onChanged: (value) {
        identitas = value;
      },
      initialValue: identitas,
      validator: (value) {
        if (value.isEmpty) {
          return "NIK masih kosong !";
        }
      },
    );
  }

  Widget inputNama() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: InputDecoration(
        label: const Text('Nama Lengkap *'),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey[200])),
      ),
      onChanged: (value) {
        jamaah = value;
      },
      initialValue: jamaah,
      validator: (value) {
        if (value.isEmpty) {
          return "Nama masih kosong !";
        }
      },
    );
  }

  Widget inputJenisKelamin() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "Jenis Kelamin *",
        mode: Mode.MENU,
        items: const ["Pria", "Wanita"],
        onChanged: (value) {
          if (value == "Pria") {
            jenisKelamin = 'P';
            jk = value;
            getBarangHandling('L');
          } else {
            jenisKelamin = 'W';
            jk = value;
            getBarangHandling('P');
          }
        },
        dropdownBuilder: (context, selectedItem) => Text(
          jk ?? "Pilih Jenis Kelamin",
        ),
        validator: (value) {
          if (jk == null) {
            return "Jenis Kelamin masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputTempatLahir() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: InputDecoration(
          label: const Text('Tempat Lahir *'),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey[200]))),
      onChanged: (value) {
        tempatLahir = value;
      },
      initialValue: tempatLahir,
      validator: (value) {
        if (value.isEmpty) {
          return "Tempat lahir masih kosong !";
        }
      },
    );
  }

  Widget inputTglLahir() {
    return TextFormField(
      controller: dateLahir,
      decoration: InputDecoration(
          label: const Text('Tanggal Lahir *'),
          hintText: 'DD-MM-YYYY',
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey[200]))),
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          dateLahir.text = formattedDate;
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Tgl Lahir masih kosong !";
        }
      },
    );
  }

  Widget inputAlamat() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: InputDecoration(
          label: const Text('Alamat *'),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey[200]))),
      onChanged: (value) {
        alamat = value;
      },
      initialValue: alamat,
      validator: (value) {
        if (value.isEmpty) {
          return "Alamat masih kosong !";
        }
      },
    );
  }

  Widget inputProvinsi() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Provinsi *",
        items: listProvinsi,
        onChanged: (value) {
          if (value != null) {
            namaProvinsi = value["name"];
            idProvinsi = value["id"];
            getKota(value['id']);
          } else {
            namaProvinsi = null;
            idProvinsi = null;
          }
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['name'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaProvinsi ?? "Nama Provinsi belum Dipilih"),
        validator: (value) {
          if (idProvinsi == null) {
            return "Provinsi masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputKota() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Kab / Kota *",
        items: listKota,
        onChanged: (value) {
          if (value != null) {
            namaKota = value["name"];
            idKota = value["id"];
            getKec(value['id']);
          } else {
            namaKota = null;
            idKota = null;
          }
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['name'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaKota ?? "Nama Kota belum Dipilih"),
        validator: (value) {
          if (idKota == null) {
            return "Kota masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputKec() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Kecamatan *",
        items: listKec,
        onChanged: (value) {
          if (value != null) {
            namaKec = value["name"];
            idKec = value["id"];
            getKel(value["id"]);
          } else {
            namaKec = null;
            idKec = null;
          }
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['name'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
          namaKec ?? "Nama Kecamatan belum Dipilih",
        ),
        validator: (value) {
          if (idKec == null) {
            return "Kecamatan masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputKel() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Kelurahan *",
        items: listKel,
        onChanged: (value) {
          if (value != null) {
            namaKel = value["name"];
            idKel = value["id"];
          } else {
            namaKel = null;
            idKel = null;
          }
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['name'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaKel ?? "Nama Kelurahan belum Dipilih"),
        validator: (value) {
          if (idKel == null) {
            return "Kelurahan masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputKodePos() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: InputDecoration(
          label: const Text('Kode Pos *'),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey[200]))),
      onChanged: (value) {
        kodePos = value;
      },
      initialValue: kodePos,
      validator: (value) {
        if (value.isEmpty) {
          return "Kode Pos masih kosong !";
        }
      },
    );
  }

  Widget inputNamaAyah() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: InputDecoration(
          labelText: 'Nama Ayah',
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey[200]))),
      onChanged: (value) {
        namaAyah = value;
      },
      initialValue: namaAyah,
    );
  }

  Widget inputTelp() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: InputDecoration(
          labelText: 'Telepon *',
          hintText: "08xxxxxxxxxxx",
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey[200]))),
      onChanged: (value) {
        noTelp = value;
      },
      initialValue: noTelp,
    );
  }

  Widget inputMenikah() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Status Menikah *",
        items: listMenikah,
        onChanged: (value) {
          namaMenikah = value['CODD_DESC'];
          idMenikah = value['CODD_VALU'];
          setState(() {});
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaMenikah ?? "Status menikah belum Dipilih"),
        validator: (value) {
          if (value == "Status menikah belum Dipilih") {
            return "Status menikah masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputPendidikan() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Pendidikan *",
        items: listPendidikan,
        onChanged: (value) {
          namaPendidikan = value['CODD_DESC'];
          idPendidikan = value['CODD_VALU'];
          setState(() {});
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaPendidikan ?? "Pendidikan terakhir Belum dipilih"),
        validator: (value) {
          if (value == "Pendidikan terakhir Belum dipilih") {
            return "Pendidikan masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputPekerjaan() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Pekerjaan *",
        items: listPekerjaan,
        onChanged: (value) {
          namaPekerjaan = value['CODD_DESC'];
          idPekerjaan = value['CODD_VALU'];
          setState(() {});
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaPekerjaan ?? "Pekerjaan Belum dipilih"),
        validator: (value) {
          if (value == "Pekerjaan Belum dipilih") {
            return "Pekerjaan masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputNamaMarketing() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      readOnly: true,
      decoration: InputDecoration(
          labelText: 'Nama Marketing',
          hintText: "??",
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey[200]))),
      initialValue: namaAgency,
    );
  }

  Widget inputNamaJadwal() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      readOnly: true,
      decoration: InputDecoration(
          labelText: 'Paket Yang Dipilih',
          hintText: "??",
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey[200]))),
      initialValue: paket,
    );
  }

  Widget inputKTP() {
    return SizedBox(
        height: 50,
        child: DropdownSearch(
          label: "KTP *",
          mode: Mode.MENU,
          items: const [
            "KTP",
            "Belum",
          ],
          onChanged: (value) {
            ktp = value;
          },
          dropdownBuilder: (context, selectedItem) =>
              Text(ktp ?? "Pilih Status KTP"),
          validator: (value) {
            if (ktp == null) {
              return "Status KTP masih kosong !";
            }
          },
        ));
  }

  Widget inputKK() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "KK *",
        mode: Mode.MENU,
        items: const [
          "KK",
          "Belum",
        ],
        onChanged: (value) {
          kk = value;
        },
        dropdownBuilder: (context, selectedItem) =>
            Text(kk ?? "Pilih Status KK"),
        validator: (value) {
          if (kk == null) {
            return "Status KK masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputLampiran() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "Lampiran lainnya *",
        mode: Mode.MENU,
        items: const [
          "Akte",
          "Surat Nikah",
          "Ijazah",
          "Belum",
        ],
        onChanged: (value) {
          lampiran = value;
        },
        dropdownBuilder: (context, selectedItem) =>
            Text(lampiran ?? "Lampiran"),
        validator: (value) {
          if (lampiran == null) {
            return "Lampiran masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputPaspor() {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pembuatan Paspor",
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: myBlue, fontSize: 15)),
            const SizedBox(height: 15),
            Column(
              children: listBiayaPaspor.map((e) {
                return RadioListTile(
                    value: '${e['NAMA_BYAX']}',
                    controlAffinity: ListTileControlAffinity.leading,
                    secondary: const Icon(
                      Icons.file_open_outlined,
                      color: Colors.blue,
                    ),
                    groupValue: pembuatan,
                    title: Text(e['NAMA_BYAX']),
                    subtitle:
                        Text("Harga : ${myFormat.format(e['JMLH_BYAX'])}"),
                    onChanged: (value) {
                      setState(() {
                        pembuatan = value;
                        biayaPaspor = myFormat
                            .format(int.parse(e['JMLH_BYAX'].toString()));
                      });

                      fncTotal();
                    });
              }).toList(),
            )
          ]),
    );
  }

  Widget inputVaksin() {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pembuatan Vaksin",
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: myBlue, fontSize: 15)),
            const SizedBox(height: 15),
            Column(
              children: listBiayaVaksin.map((e) {
                return RadioListTile(
                    value: '${e['NAMA_BYAX']}',
                    controlAffinity: ListTileControlAffinity.leading,
                    secondary: const Icon(
                      Icons.medical_services_outlined,
                      color: Colors.blue,
                    ),
                    groupValue: vaksin,
                    title: Text(e['NAMA_BYAX']),
                    subtitle:
                        Text("Harga : ${myFormat.format(e['JMLH_BYAX'])}"),
                    onChanged: (value) {
                      setState(() {
                        vaksin = value;
                        biayaVaksin = myFormat
                            .format(int.parse(e['JMLH_BYAX'].toString()));
                      });
                    });
              }).toList(),
            )
          ]),
    );
  }

  Widget inputKamar() {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pemilihan Kamar",
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: myBlue, fontSize: 15)),
            const SizedBox(height: 15),
            Column(
              children: listBiayaKamar.map((e) {
                return RadioListTile(
                    value: '${e['NAMA_BYAX']}',
                    controlAffinity: ListTileControlAffinity.leading,
                    secondary: const Icon(
                      Icons.bed_outlined,
                      color: Colors.blue,
                    ),
                    groupValue: kamar,
                    title: Text(e['NAMA_BYAX']),
                    subtitle:
                        Text("Harga : ${myFormat.format(e['JMLH_BYAX'])}"),
                    onChanged: (value) {
                      setState(() {
                        kamar = value;
                        biayaKamar = myFormat
                            .format(int.parse(e['JMLH_BYAX'].toString()));
                      });
                    });
              }).toList(),
            )
          ]),
    );
  }

  Widget barangHandling(context) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    final screenWidth = MediaQuery.of(context).size.width;
    int x = 1;
    return Column(
      children: [
        SizedBox(
          width: screenWidth < 550 ? 650 : screenWidth,
          child: DataTable(
              dataRowHeight: 45,
              headingRowHeight: 40,
              columnSpacing: screenWidth < 550 ? 0 : 30,
              headingRowColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                return Colors.blue;
              }),
              headingTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy',
                  fontSize: 16),
              columns: const [
                DataColumn(label: Text('No.')),
                DataColumn(label: Text('Nama Barang')),
                DataColumn(label: Text('Harga')),
                // DataColumn(label: Text('')),
                DataColumn(label: Text('Jumlah')),
                // DataColumn(label: Text('')),
                DataColumn(label: Text('Subtotal')),
              ],
              rows: listBarangHandling.map((data) {
                return DataRow(cells: [
                  DataCell(Text((x++).toString())),
                  DataCell(Text(data['NAMA_BRGX'] ?? '-')),
                  DataCell(Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        myFormat.format(int.parse(data['HRGX_JUAL'])) ?? '-'),
                  )),
                  DataCell(Row(
                    children: [
                      // IconButton(
                      //   onPressed: () {
                      //     if (data['JMLH'] != '0') {
                      //       setState(() {
                      //         data['JMLH'] =
                      //             (int.parse(data['JMLH']) - 1).toString();
                      //         data['SUBTOTAL'] = (int.parse(data['HRGX_JUAL']) *
                      //                 int.parse(data['JMLH']))
                      //             .toString();
                      //       });
                      //       fncTotalHandling();
                      //     }
                      //   },
                      //   icon: const Icon(
                      //     Icons.do_disturb_on_rounded,
                      //     color: Colors.red,
                      //     size: 25,
                      //   ),
                      // ),
                      // const SizedBox(width: 10),
                      Align(
                          child: Text(
                        data['JMLH'] ?? '-',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'Gilroy'),
                      )),
                      // const SizedBox(width: 10),
                      // IconButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       data['JMLH'] =
                      //           (int.parse(data['JMLH']) + 1).toString();
                      //       data['SUBTOTAL'] = (int.parse(data['HRGX_JUAL']) *
                      //               int.parse(data['JMLH']))
                      //           .toString();
                      //     });
                      //     fncTotalHandling();
                      //   },
                      //   icon: const Icon(
                      //     Icons.add_circle,
                      //     color: Colors.green,
                      //     size: 25,
                      //   ),
                      // )
                    ],
                  )),
                  DataCell(Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          myFormat.format(int.parse(data['SUBTOTAL'])) ??
                              '-'))),
                ]);
              }).toList()),
        ),
      ],
    );
  }

  Widget resultFotoKTP() {
    if (ktpPelangganByte != null) {
      return Image.memory(
        ktpPelangganByte,
        height: 100,
      );
    } else {
      return const Image(
        image: AssetImage('assets/images/ktp_pict.jpg'),
        height: 100,
      );
    }
  }

  Widget resultFotoKK() {
    if (fotoKkPelangganByte != null) {
      return Image.memory(
        fotoKkPelangganByte,
        height: 100,
      );
    } else {
      return const Image(
        image: AssetImage('assets/images/kartu_keluarga.png'),
        height: 100,
      );
    }
  }

  Widget resultFotoDok() {
    if (fotoDokPelangganByte != null) {
      return Image.memory(
        fotoDokPelangganByte,
        height: 100,
      );
    } else {
      return const Image(
        image: AssetImage('assets/images/NO_IMAGE.jpg'),
        height: 100,
      );
    }
  }

  Widget inputUploadKTP() {
    return TextFormField(
      initialValue: ktpPelanggan != "" ? ktpPelanggan : "Pilih",
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: InputDecoration(
          labelText: 'Upload KTP *',
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey[200]))),
    );
  }

  Widget inputUploadKK() {
    return TextFormField(
      initialValue: fotoKkPelanggan != "" ? fotoKkPelanggan : "Pilih",
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: InputDecoration(
          labelText: 'Upload KK *',
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey[200]))),
    );
  }

  Widget inputUploadLampiran() {
    return TextFormField(
      initialValue: fotoDokPelanggan != "" ? fotoDokPelanggan : "Pilih",
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: InputDecoration(
          labelText: 'Upload Lampiran *',
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey[200]))),
    );
  }

  Widget btnUploadKTP() {
    return ElevatedButton.icon(
      onPressed: () {
        getImageKTP();
      },
      icon: const Icon(Icons.save),
      label: const Text(
        'Upload KTP',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 50),
        shadowColor: Colors.grey,
        elevation: 10,
      ),
    );
  }

  Widget btnUploadKK() {
    return ElevatedButton.icon(
      onPressed: () {
        getImageKK();
      },
      icon: const Icon(Icons.save),
      label: const Text(
        'Upload KK',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 50),
        shadowColor: Colors.grey,
        elevation: 10,
      ),
    );
  }

  Widget btnUploadLampiran() {
    return ElevatedButton.icon(
      onPressed: () {
        getImageDok();
      },
      icon: const Icon(Icons.save),
      label: const Text(
        'Upload Dokumen',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 50),
        shadowColor: Colors.grey,
        elevation: 10,
      ),
    );
  }

  getImageKTP() async {
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    Uint8List bytes = fileResult.files.first.bytes;
    String encodeFoto = base64.encode(bytes);

    if (fileResult != null) {
      setState(() {
        ktpPelanggan = fileResult.files.first.name;
        ktpPelangganByte = fileResult.files.first.bytes;
        ktpPelangganBase = encodeFoto;
      });
    }
  }

  getImageKK() async {
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    Uint8List bytes = fileResult.files.first.bytes;
    String encodeFoto = base64.encode(bytes);

    if (fileResult != null) {
      setState(() {
        fotoKkPelanggan = fileResult.files.first.name;
        fotoKkPelangganByte = fileResult.files.first.bytes;
        fotoKkPelangganBase = encodeFoto;
      });
    }
  }

  getImageDok() async {
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    Uint8List bytes = fileResult.files.first.bytes;
    String encodeFoto = base64.encode(bytes);

    if (fileResult != null) {
      setState(() {
        fotoDokPelanggan = fileResult.files.first.name;
        fotoDokPelangganByte = fileResult.files.first.bytes;
        fotoDokPelangganBase = encodeFoto;
      });
    }
  }

  fncTotalHandling() {
    int ttl = 0;
    for (var i = 0; i < listBarangHandling.length; i++) {
      if (listBarangHandling[i]['JMLH'] != 0) {
        ttl += int.parse(
            listBarangHandling[i]['SUBTOTAL'].toString().replaceAll(',', ''));
      }
    }

    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    setState(() {
      biayaHandling = myFormat.format(ttl).toString();
    });
  }

  fncTotal() {
    int cek = (
        // (biaya != null ? int.parse(biaya.replaceAll(',', '')) : 0) +
        (harga ?? 0) +
            (biayaPaspor != null
                ? int.parse(biayaPaspor.replaceAll(',', ''))
                : 0) +
            (biayaAdmin != null
                ? int.parse(biayaAdmin.replaceAll(',', ''))
                : 0) +
            (biayaVaksin != null
                ? int.parse(biayaVaksin.replaceAll(',', ''))
                : 0) +
            (biayaHandling != null
                ? int.parse(biayaHandling.replaceAll(',', ''))
                : 0) +
            (biayaKamar != null
                ? int.parse(biayaKamar.replaceAll(',', ''))
                : 0));

    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    setState(() {
      estimasi = ('${mataUang ?? 'Rp'}.${myFormat.format(cek)}').toString();
      totalEst = cek.toString();
    });
  }

  fncSaveJamaah() {
    HttpJamaah.saveJamaah(
      identitas,
      jamaah,
      jenisKelamin,
      tempatLahir,
      fncTanggal(dateLahir.text),
      alamat,
      namaProvinsi,
      namaKota,
      namaKec,
      namaKel,
      kodePos,
      namaAyah,
      noTelp,
      idMenikah,
      idPendidikan,
      idPekerjaan,
      null,
      null,
      null,
      null,
      '',
      ktpPelanggan != '' ? "$identitas.png" : '',
    ).then(
      (value) {
        if (value.status == true) {
          fncSaveFoto();
        } else {
          showDialog(
              context: context, builder: (context) => const ModalSaveFail());
        }
      },
    );
  }

  fncSaveFoto() {
    HttpPendaftaran.saveFotoPendaftaran(
      identitas,
      ktpPelangganBase != '' ? ktpPelangganBase : 'TIDAK',
      fotoKkPelangganBase != '' ? fotoKkPelangganBase : 'TIDAK',
      fotoDokPelangganBase != '' ? fotoDokPelangganBase : 'TIDAK',
    ).then((value) {
      if (value.status == true) {
        fncSaveData(value.namaKk, value.namaDok);
      } else {
        print('UPLOAD FOTO GAGAL');
      }
    });
  }

  fncSaveData(namaKk, namaDok) async {
    // GET ID PELANGGAN
    var response1 = await http
        .get(Uri.parse("$urlAddress/jamaah/pendaftaran/kode"), headers: {
      'pte-token': kodeToken,
    });
    dynamic body1 = json.decode(response1.body);
    String idPelanggan = body1['idPelanggan'];

    listTagihan = [];
    listBarangPelanggan = [];

    var tagihan = {
      {
        '"nama_tagihan"': '"Biaya Paket"',
        '"total_tagihan"': '"${tarif.replaceAll(',', '')}"',
      },
      if (biayaVaksin != '0')
        {
          '"nama_tagihan"': '"Vaksin"',
          '"total_tagihan"': '"${biayaVaksin.replaceAll(',', '')}"',
        },
      if (biayaPaspor != '0')
        {
          '"nama_tagihan"': '"Paspor"',
          '"total_tagihan"': '"${biayaPaspor.replaceAll(',', '')}"',
        },
      // if (biayaAdmin != '0')
      //   {
      //     '"nama_tagihan"': '"Biaya Admin"',
      //     '"total_tagihan"': '"${biayaAdmin.replaceAll(',', '')}"',
      //   },
      if (biayaHandling != '0')
        {
          '"nama_tagihan"': '"Biaya Handling"',
          '"total_tagihan"': '"${biayaHandling.replaceAll(',', '')}"',
        },
      if (biayaKamar != '0')
        {
          '"nama_tagihan"': '"Biaya Kamar"',
          '"total_tagihan"': '"${biayaKamar.replaceAll(',', '')}"',
        },
    };

    listTagihan.addAll(tagihan);

    for (var i = 0; i < listBarangHandling.length; i++) {
      if (listBarangHandling[i]['JMLH'] != '0') {
        var barang = {
          '"KDXX_BRGX"': '"${listBarangHandling[i]['KDXX_BRGX'].toString()}"',
          '"NAMA_BRGX"': '"${listBarangHandling[i]['NAMA_BRGX'].toString()}"',
          '"JENS_BRGX"': '"${listBarangHandling[i]['JENS_BRGX'].toString()}"',
          '"STOK_BRGX"': '"${listBarangHandling[i]['STOK_BRGX'].toString()}"',
          '"HRGX_BELI"': '"${listBarangHandling[i]['HRGX_BELI'].toString()}"',
          '"HRGX_JUAL"': '"${listBarangHandling[i]['HRGX_JUAL'].toString()}"',
          '"KETERANGAN"': '"${listBarangHandling[i]['KETERANGAN'].toString()}"',
          '"JMLH"': '"${listBarangHandling[i]['JMLH'].toString()}"',
          '"SUBTOTAL"': '"${listBarangHandling[i]['SUBTOTAL'].toString()}"',
        };
        listBarangPelanggan.add(barang);
      }
    }

    HttpPendaftaran.savePendaftaran(
      idPelanggan,
      'ONLINE',
      identitas,
      idProduk,
      ktp,
      kk,
      lampiran,
      pembuatan,
      vaksin,
      'Belum Diterima',
      'MARKETING',
      Get.parameters['kode'],
      totalEst,
      fncJatuhTempo(berangkat).toString(),
      '$listTagihan',
      '$listBarangPelanggan',
      namaKk,
      namaDok,
    ).then((value) {
      if (value.status == true) {
        showDialog(
            context: context, builder: (context) => const ModalSaveSuccess());

        fncClear();

        // menuController.changeActiveitemTo("");
        // navigationController.navigateTo(
        //     "/pendaftaran/${Get.parameters['kode']}/${Get.parameters['id']}");

        fncClear();
      } else {
        showDialog(
            context: context, builder: (context) => const ModalSaveFail());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TabController tabController = TabController(vsync: this, length: 3);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final decorationBox = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 3,
          blurRadius: 4,
          offset: const Offset(0, 3),
        ),
      ],
    );

    return DefaultTabController(
      length: 3,
      child: Form(
        key: formKey,
        child: SizedBox(
          child: namaAgency == null
              ? Container(
                  padding: const EdgeInsets.all(50),
                  width: screenWidth,
                  child: const NotFindWidget(
                      description: 'Link Salah, Agen Tidak Ditemukan'))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: myBlue,
                      width: screenWidth,
                      height: 50,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  fncSaveJamaah();
                                } else {
                                  return Get.snackbar(
                                    "Ada data yang belum diisi nih",
                                    "Silahkan Cek Kembali Data Kamu",
                                    icon: const Icon(Icons.person,
                                        color: Colors.white),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                }
                              },
                              icon: Icon(Icons.save, color: myBlue),
                              label:
                                  fncLabelButtonMarketStyle('Simpan', context),
                              style: fncButtonMarketStyle(context),
                            ),
                            const SizedBox(width: 15),
                            ElevatedButton.icon(
                              onPressed: () {
                                fncClear();
                              },
                              icon: Icon(Icons.cancel, color: myBlue),
                              label:
                                  fncLabelButtonMarketStyle('Batal', context),
                              style: fncButtonMarketStyle(context),
                            ),
                          ]),
                    ),
                    Container(
                      width: screenWidth,
                      height: 50,
                      color: myBlue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TabBar(
                              // controller: tabController,
                              indicatorColor: Colors.white,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.grey[300],
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gilroy'),
                              tabs: const [
                                Tab(text: 'Paket'),
                                Tab(text: 'Data Diri'),
                                Tab(text: 'Detail'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: screenHeight * 0.81,
                      width: screenWidth < 550
                          ? screenWidth * 0.9
                          : screenWidth * 0.7,
                      child: TabBarView(
                        // controller: tabController,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 25),
                                  decoration: decorationBox,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Paket Umroh / Haji",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: myBlue,
                                                fontSize: 15)),
                                        const SizedBox(height: 15),
                                        Column(
                                          children: [
                                            Container(
                                              width: screenWidth * 0.7,
                                              height: screenWidth * 0.7,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: fotoJadwal != ""
                                                        ? NetworkImage(
                                                            '$urlAddress/uploads/paket/$fotoJadwal')
                                                        : const AssetImage(
                                                            'assets/images/none-produk.png')),
                                              ),
                                              child: const SizedBox(),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 20),
                                        SizedBox(
                                          width: screenWidth,
                                          child: DescriptionPaketDaftar(
                                            judul: judul ?? '',
                                            keterangan: keterangan ?? '',
                                            harga: harga ?? '',
                                            mu: mataUang ?? '',
                                            pesawatBgkt: pesawatBgkt ?? '',
                                            pesawatPlng: pesawatPlng ?? '',
                                            rute: rute ?? '',
                                            hotelMek: hotelMek,
                                            hotelMad: hotelMad,
                                            hotelTra: hotelTra,
                                            hotelPls: hotelPls,
                                            sisa: sisa ?? '',
                                            berangkat: berangkat ?? '',
                                            pulang: pulang ?? '',
                                            durasi: durasi ?? '',
                                          ),
                                        ),
                                      ]),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 25),
                                  decoration: decorationBox,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Pemilihan Paket",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: myBlue,
                                                fontSize: 15)),
                                        const SizedBox(height: 15),
                                        inputNamaMarketing(),
                                        const SizedBox(height: 15),
                                        inputNamaJadwal(),
                                        const SizedBox(height: 15),
                                        inputKTP(),
                                        const SizedBox(height: 15),
                                        inputKK(),
                                        const SizedBox(height: 15),
                                        inputLampiran(),
                                        const SizedBox(height: 15),
                                      ]),
                                ),
                                const SizedBox(height: 20),
                                inputPaspor(),
                                const SizedBox(height: 20),
                                inputVaksin(),
                                const SizedBox(height: 20),
                                inputKamar(),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 2,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/hero-dashboard.png'),
                                      ),
                                    )),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 25),
                                  decoration: decorationBox,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Informasi Data Diri",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: myBlue,
                                                fontSize: 15)),
                                        const SizedBox(height: 15),
                                        inputNIK(),
                                        const SizedBox(height: 15),
                                        inputNama(),
                                        const SizedBox(height: 15),
                                        inputJenisKelamin(),
                                        const SizedBox(height: 15),
                                        inputTempatLahir(),
                                        const SizedBox(height: 15),
                                        inputTglLahir(),
                                        const SizedBox(height: 15),
                                        inputAlamat(),
                                        const SizedBox(height: 15),
                                        inputProvinsi(),
                                        const SizedBox(height: 15),
                                        inputKota(),
                                        const SizedBox(height: 15),
                                        inputKec(),
                                        const SizedBox(height: 15),
                                        inputKel(),
                                        const SizedBox(height: 15),
                                        inputKodePos(),
                                        const SizedBox(height: 15),
                                        inputNamaAyah(),
                                        const SizedBox(height: 15),
                                        inputTelp(),
                                        const SizedBox(height: 15),
                                        inputMenikah(),
                                        const SizedBox(height: 15),
                                        inputPendidikan(),
                                        const SizedBox(height: 15),
                                        inputPekerjaan(),
                                      ]),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 25),
                                  decoration: decorationBox,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Barang Handling",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: myBlue,
                                                fontSize: 15)),
                                        const SizedBox(height: 15),
                                        screenWidth < 550
                                            ? SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: barangHandling(context),
                                              )
                                            : barangHandling(context),
                                        const SizedBox(height: 10),
                                        Divider(thickness: 1, color: myBlue),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(child: Container()),
                                            const Text("Total Harga :        ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15)),
                                            Text(biayaHandling,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15)),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Divider(thickness: 1, color: myBlue),
                                        const SizedBox(height: 10),
                                      ]),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 25),
                                  decoration: decorationBox,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Dokumen Pendukung",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: myBlue,
                                                fontSize: 15)),
                                        const SizedBox(height: 15),
                                        screenWidth < 550
                                            ? Column(
                                                children: [
                                                  resultFotoKTP(),
                                                  const SizedBox(height: 10),
                                                  resultFotoKK(),
                                                  const SizedBox(height: 10),
                                                  resultFotoDok()
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  resultFotoKTP(),
                                                  const SizedBox(width: 10),
                                                  resultFotoKK(),
                                                  const SizedBox(width: 10),
                                                  resultFotoDok()
                                                ],
                                              ),
                                        const SizedBox(height: 15),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: inputUploadKTP(),
                                            )),
                                            const SizedBox(width: 10),
                                            btnUploadKTP()
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: inputUploadKK(),
                                            )),
                                            const SizedBox(width: 10),
                                            btnUploadKK()
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: inputUploadLampiran(),
                                            )),
                                            const SizedBox(width: 10),
                                            btnUploadLampiran()
                                          ],
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DetailBiayaContent(
                              nik: identitas,
                              tarif: tarif,
                              biayaVaksin: biayaVaksin,
                              biayaPaspor: biayaPaspor,
                              biayaAdmin: biayaAdmin,
                              biayaHandling: biayaHandling,
                              biayaKamar: biayaKamar,
                              estimasi: estimasi,
                              paket: paket,
                              berangkat: berangkat,
                              pulang: pulang,
                              namaPelanggan: jamaah,
                              umur: umur,
                              harga: harga.toString(),
                              alamat: alamat,
                              paspor: paspor,
                              vaksin: vaksin,
                              pembuatan: pembuatan,
                              fotoJadwal: fotoJadwal,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
