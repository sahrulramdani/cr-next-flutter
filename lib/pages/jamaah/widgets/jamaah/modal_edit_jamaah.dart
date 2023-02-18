// ignore_for_file: deprecated_member_use, missing_return, must_be_immutable

import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/models/http_jamaah.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';

class ModalEditJamaah extends StatefulWidget {
  String idJamaah;
  ModalEditJamaah({Key key, @required this.idJamaah}) : super(key: key);

  @override
  State<ModalEditJamaah> createState() => _ModalEditJamaahState();
}

class _ModalEditJamaahState extends State<ModalEditJamaah> {
  String nik;
  String namaJamaah;
  String jenisKelamin;
  String jk;
  String tempatLahir;
  String alamat;
  String namaProvinsi;
  String namaKota;
  String namaKec;
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
  String paspor;
  String cekPaspor;
  String noPaspor;
  String dikeluarkanDi;

  String fotoJamaah = "";
  String fotoJamaahBase = "";
  Uint8List fotoJamaahByte;
  String fotoLamaJamaah = "";

  String fotoKtpJamaah = "";
  String fotoKtpJamaahBase = "";
  Uint8List fotoKtpJamaahByte;
  String fotoLamaKtpJamaah = "";

  List<Map<String, dynamic>> dataJamaah = [];
  List<Map<String, dynamic>> listProvinsi = [];
  List<Map<String, dynamic>> listKota = [];
  List<Map<String, dynamic>> listKec = [];
  List<Map<String, dynamic>> listKel = [];
  List<Map<String, dynamic>> listMenikah = [];
  List<Map<String, dynamic>> listPendidikan = [];
  List<Map<String, dynamic>> listPekerjaan = [];

  TextEditingController dateLhir = TextEditingController();
  TextEditingController dateKeluar = TextEditingController();
  TextEditingController dateExp = TextEditingController();

  void getDetail() async {
    String id = widget.idJamaah;
    var response = await http
        .get(Uri.parse("$urlAddress/jamaah/jamaah/detail/$id"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      dataJamaah = dataStatus;
      nik = widget.idJamaah;
      namaJamaah = dataStatus[0]['NAMA_LGKP'];
      jenisKelamin = dataStatus[0]['JENS_KLMN'];
      if (dataStatus[0]['JENS_KLMN'] == 'P') {
        jk = 'Pria';
      } else {
        jk = 'Wanita';
      }
      tempatLahir = dataStatus[0]['TMPT_LHIR'];
      dateLhir.text = DateFormat("dd-MM-yyyy")
          .format(DateTime.parse(dataStatus[0]['TGLX_LHIR']));
      alamat = dataStatus[0]['ALAMAT'];
      namaProvinsi = dataStatus[0]['KDXX_PROV'];
      namaKota = dataStatus[0]['KDXX_KOTA'];
      namaKec = dataStatus[0]['KDXX_KECX'];
      namaKel = dataStatus[0]['KDXX_KELX'];
      kodePos = dataStatus[0]['KDXX_POSX'].toString();
      namaAyah = dataStatus[0]['NAMA_AYAH'];
      noTelp = dataStatus[0]['NOXX_TELP'];
      idMenikah = dataStatus[0]['JENS_MNKH'];
      namaMenikah = dataStatus[0]['MENIKAH'];
      idPendidikan = dataStatus[0]['JENS_PEND'];
      namaPendidikan = dataStatus[0]['PENDIDIKAN'];
      idPekerjaan = dataStatus[0]['JENS_PKRJ'];
      namaPekerjaan = dataStatus[0]['PEKERJAAN'];
      if (dataStatus[0]['NOXX_PSPR'] != null) {
        cekPaspor = 'Ada';
        noPaspor = dataStatus[0]['NOXX_PSPR'];
        dikeluarkanDi = dataStatus[0]['KLUR_DIXX'];
        dateKeluar.text = DateFormat("dd-MM-yyyy")
            .format(DateTime.parse(dataStatus[0]['TGLX_KLUR']));
        dateExp.text = DateFormat("dd-MM-yyyy")
            .format(DateTime.parse(dataStatus[0]['TGLX_EXPX']));
      } else {
        cekPaspor = 'Belum Ada';
      }
      fotoJamaah = dataStatus[0]['FOTO_JMAH'];
      fotoLamaJamaah = dataStatus[0]['FOTO_JMAH'];
      fotoKtpJamaah = dataStatus[0]['FOTO_KTPX'];
      fotoLamaKtpJamaah = dataStatus[0]['FOTO_KTPX'];
    });
  }

  void getProvinsi() async {
    var response = await http.get(Uri.parse(
        "https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listProvinsi = dataStatus;
    });
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
        await http.get(Uri.parse("$urlAddress/setup/status-menikah"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listMenikah = dataStatus;
    });
  }

  getPendidikan() async {
    var response = await http.get(Uri.parse("$urlAddress/setup/pendidikans"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listPendidikan = dataStatus;
    });
  }

  getPekerjaan() async {
    var response = await http.get(Uri.parse("$urlAddress/setup/pekerjaans"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listPekerjaan = dataStatus;
    });
  }

  @override
  void initState() {
    super.initState();
    getDetail();
    getProvinsi();
    getMenikah();
    getPendidikan();
    getPekerjaan();
  }

  Widget inputNIK() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'NIK',
          hintText: '32xxxxxxxxxxx',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      initialValue: nik ?? '',
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
      decoration: const InputDecoration(
          labelText: 'Nama Lengkap',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      initialValue: namaJamaah ?? '',
      validator: (value) {
        if (value.isEmpty) {
          return "Nama masih kosong !";
        }
      },
      onChanged: (value) {
        namaJamaah = value;
      },
    );
  }

  Widget inputJenisKelamin() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Jenis Kelamin",
        mode: Mode.MENU,
        items: const ["Pria", "Wanita"],
        onChanged: (value) {
          if (value == "Pria") {
            jenisKelamin = 'P';
            jk = value;
          } else {
            jenisKelamin = 'W';
            jk = value;
          }
        },
        selectedItem: jk ?? "Pilih Jenis Kelamin",
        dropdownSearchDecoration: const InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == "Pilih Jenis Kelamin") {
            return "Jenis Kelamin masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputTempatLahir() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Tempat Lahir',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: (value) {
        tempatLahir = value;
      },
      initialValue: tempatLahir ?? '',
      validator: (value) {
        if (value.isEmpty) {
          return "Tempat lahir masih kosong !";
        }
      },
    );
  }

  Widget inputTglLahir() {
    return TextFormField(
      controller: dateLhir,
      decoration: const InputDecoration(
          labelText: 'Tanggal Lahir', filled: true, fillColor: Colors.white),
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          dateLhir.text = formattedDate;
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
      decoration: const InputDecoration(
          labelText: 'Alamat', filled: true, fillColor: Colors.white),
      onChanged: (value) {
        alamat = value;
      },
      initialValue: alamat ?? '',
      validator: (value) {
        if (value.isEmpty) {
          return "Alamat masih kosong !";
        }
      },
    );
  }

  Widget inputProvinsi() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Provinsi",
          items: listProvinsi,
          onChanged: (value) {
            if (value != null) {
              namaProvinsi = value["name"];
              getKota(value['id']);
            } else {
              namaProvinsi = null;
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['name'].toString()),
              ),
          dropdownBuilder: (context, selectedItem) =>
              Text(namaProvinsi ?? "Nama Provinsi belum Dipilih"),
          validator: (value) {
            if (value == null) {
              return "Provinsi masih kosong !";
            }
          },
          dropdownSearchDecoration: const InputDecoration(
              border: InputBorder.none, filled: true, fillColor: Colors.white)),
    );
  }

  Widget inputKota() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Kab / Kota",
          items: listKota,
          onChanged: (value) {
            if (value != null) {
              namaKota = value["name"];
              getKec(value['id']);
            } else {
              namaKota = null;
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['name'].toString()),
              ),
          dropdownBuilder: (context, selectedItem) =>
              Text(namaKota ?? "Nama Kota belum Dipilih"),
          validator: (value) {
            if (value == null) {
              return "Kota masih kosong !";
            }
          },
          dropdownSearchDecoration: const InputDecoration(
              border: InputBorder.none, fillColor: Colors.white, filled: true)),
    );
  }

  Widget inputKec() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Kecamatan",
          items: listKec,
          onChanged: (value) {
            if (value != null) {
              namaKec = value["name"];
              getKel(value["id"]);
            } else {
              namaKec = null;
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['name'].toString()),
              ),
          dropdownBuilder: (context, selectedItem) =>
              Text(namaKec ?? "Nama Kecamatan belum Dipilih"),
          validator: (value) {
            if (value == null) {
              return "Kecamatan masih kosong !";
            }
          },
          dropdownSearchDecoration: const InputDecoration(
              border: InputBorder.none, filled: true, fillColor: Colors.white)),
    );
  }

  Widget inputKel() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Kelurahan",
          items: listKel,
          onChanged: (value) {
            if (value != null) {
              namaKel = value["name"];
            } else {
              namaKel = null;
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['name'].toString()),
              ),
          dropdownBuilder: (context, selectedItem) =>
              Text(namaKel ?? "Nama Kelurahan belum Dipilih"),
          validator: (value) {
            if (value == null) {
              return "Kelurahan masih kosong !";
            }
          },
          dropdownSearchDecoration: const InputDecoration(
              border: InputBorder.none, filled: true, fillColor: Colors.white)),
    );
  }

  Widget inputKodePos() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Kode Pos',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: (value) {
        kodePos = value;
      },
      initialValue: kodePos ?? '',
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
      decoration: const InputDecoration(
          labelText: 'Nama Ayah',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: (value) {
        namaAyah = value;
      },
      initialValue: namaAyah ?? '',
    );
  }

  Widget inputTelp() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Telepon',
          hintText: "08xxxxxxxxxxx",
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: (value) {
        noTelp = value;
      },
      initialValue: noTelp ?? '',
    );
  }

  Widget inputMenikah() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Status Menikah",
        items: listMenikah,
        onChanged: (value) {
          namaMenikah = value['CODD_DESC'];
          idMenikah = value['CODD_VALU'];
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
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
      ),
    );
  }

  Widget inputPendidikan() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Pendidikan",
        items: listPendidikan,
        onChanged: (value) {
          namaPendidikan = value['CODD_DESC'];
          idPendidikan = value['CODD_VALU'];
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
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
      ),
    );
  }

  Widget inputPekerjaan() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Pekerjaan",
        items: listPekerjaan,
        onChanged: (value) {
          namaPekerjaan = value['CODD_DESC'];
          idPekerjaan = value['CODD_VALU'];
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
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
      ),
    );
  }

  Widget inputPaspor() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Paspor",
        mode: Mode.MENU,
        items: const ["Ada", "Belum Ada"],
        onChanged: (value) {
          if (value == "Ada") {
            paspor = 'a';
            cekPaspor = 'Ada';
          } else {
            paspor = 'n';
            cekPaspor = 'Belum Ada';
          }
        },
        selectedItem: cekPaspor ?? "Pilih Status Paspor",
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
      ),
    );
  }

  Widget inputNoPaspor() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Nomor Paspor',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      initialValue: noPaspor ?? '',
      onChanged: (value) {
        noPaspor = value;
      },
    );
  }

  Widget inputPasporKeluar() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Dikeluarkan di',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      initialValue: dikeluarkanDi ?? '',
      onChanged: (value) {
        dikeluarkanDi = value;
      },
    );
  }

  Widget inputTglKeluar() {
    return TextField(
      controller: dateKeluar,
      decoration: const InputDecoration(
          labelText: 'Tanggal Dikeluarkan',
          filled: true,
          fillColor: Colors.white),
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          dateKeluar.text = formattedDate;
        }
      },
    );
  }

  Widget inputTglExp() {
    return TextField(
      controller: dateExp,
      decoration: const InputDecoration(
        labelText: 'Berlaku Hingga',
        filled: true,
        fillColor: Colors.white,
      ),
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          dateExp.text = formattedDate;
        }
      },
    );
  }

  Widget inputUploadFoto() {
    return TextFormField(
      initialValue: fotoJamaah != "" ? fotoJamaah : "Pilih",
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Upload Foto',
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget inputUploadKTP() {
    return TextFormField(
      initialValue: fotoKtpJamaah != "" ? fotoKtpJamaah : "Pilih",
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Upload KTP',
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget resultFotoJamaah() {
    if (fotoJamaahByte != null) {
      return Image.memory(
        fotoJamaahByte,
        width: 150,
      );
    } else {
      if (fotoJamaah != '') {
        return Image(
          image: NetworkImage('$urlAddress/uploads/$fotoJamaah'),
          width: 150,
        );
      } else {
        return const Image(
          image: AssetImage('assets/images/NO_IMAGE.jpg'),
          width: 150,
        );
      }
    }
  }

  Widget resultFotoKTP() {
    if (fotoKtpJamaahByte != null) {
      return Image.memory(
        fotoKtpJamaahByte,
        width: 150,
      );
    } else {
      if (fotoKtpJamaah != "") {
        return Image(
          image: NetworkImage('$urlAddress/uploads/$fotoKtpJamaah'),
          width: 150,
        );
      } else {
        return const Image(
          image: AssetImage('assets/images/NO_IMAGE.jpg'),
          width: 150,
        );
      }
    }
  }

  getImageJamaah() async {
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    Uint8List bytes = fileResult.files.first.bytes;
    String encodeFoto = base64.encode(bytes);

    if (fileResult != null) {
      setState(() {
        fotoJamaah = fileResult.files.first.name;
        fotoJamaahByte = fileResult.files.first.bytes;
        fotoJamaahBase = encodeFoto;
      });
    }
  }

  getImageKtp() async {
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    Uint8List bytes = fileResult.files.first.bytes;
    String encodeFoto = base64.encode(bytes);

    if (fileResult != null) {
      setState(() {
        fotoKtpJamaah = fileResult.files.first.name;
        fotoKtpJamaahByte = fileResult.files.first.bytes;
        fotoKtpJamaahBase = encodeFoto;
      });
    }
  }

  fncSaveData() {
    HttpJamaah.updateJamaah(
      nik,
      namaJamaah,
      jenisKelamin,
      tempatLahir,
      fncTanggal(dateLhir.text),
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
      noPaspor,
      dikeluarkanDi,
      dateKeluar.text != '' ? fncTanggal(dateKeluar.text) : null,
      dateExp.text != '' ? fncTanggal(dateExp.text) : null,
      fotoJamaahBase != '' ? fotoJamaahBase : 'TIDAK',
      fotoKtpJamaahBase != '' ? fotoKtpJamaahBase : 'TIDAK',
      fotoLamaJamaah,
      fotoLamaKtpJamaah,
    ).then(
      (value) {
        if (value.status == true) {
          showDialog(
              context: context, builder: (context) => const ModalSaveSuccess());
        } else {
          showDialog(
              context: context, builder: (context) => const ModalSaveFail());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.81,
            height: 700,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      Text('Ubah Data Identitas',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 530,
                            child: Column(
                              children: [
                                inputNIK(),
                                const SizedBox(height: 8),
                                inputNama(),
                                const SizedBox(height: 8),
                                inputJenisKelamin(),
                                const SizedBox(height: 8),
                                inputTempatLahir(),
                                const SizedBox(height: 8),
                                inputTglLahir(),
                                const SizedBox(height: 8),
                                inputAlamat(),
                                const SizedBox(height: 8),
                                inputProvinsi(),
                                const SizedBox(height: 8),
                                inputKota(),
                                const SizedBox(height: 8),
                                inputKec(),
                                const SizedBox(height: 8),
                                inputKel(),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    resultFotoJamaah(),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 370, child: inputUploadFoto()),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          getImageJamaah();
                                        },
                                        icon: const Icon(Icons.save),
                                        label: const Text(
                                          'Upload Foto',
                                          style:
                                              TextStyle(fontFamily: 'Gilroy'),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: myBlue,
                                          minimumSize: const Size(100, 40),
                                          shadowColor: Colors.grey,
                                          elevation: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          SizedBox(
                            width: 530,
                            child: Column(
                              children: [
                                inputKodePos(),
                                const SizedBox(height: 8),
                                inputNamaAyah(),
                                const SizedBox(height: 8),
                                inputTelp(),
                                const SizedBox(height: 8),
                                inputMenikah(),
                                const SizedBox(height: 8),
                                inputPendidikan(),
                                const SizedBox(height: 8),
                                inputPekerjaan(),
                                const SizedBox(height: 8),
                                inputPaspor(),
                                const SizedBox(height: 8),
                                inputNoPaspor(),
                                const SizedBox(height: 8),
                                inputPasporKeluar(),
                                const SizedBox(height: 8),
                                inputTglKeluar(),
                                const SizedBox(height: 8),
                                inputTglExp(),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    resultFotoKTP(),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 370, child: inputUploadKTP()),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          getImageKtp();
                                        },
                                        icon: const Icon(Icons.save),
                                        label: const Text(
                                          'Upload KTP',
                                          style:
                                              TextStyle(fontFamily: 'Gilroy'),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: myBlue,
                                          minimumSize: const Size(100, 40),
                                          shadowColor: Colors.grey,
                                          elevation: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          fncSaveData();
                        },
                        icon: const Icon(Icons.save),
                        label: const Text(
                          'Simpan Data',
                          style: TextStyle(fontFamily: 'Gilroy'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myBlue,
                          shadowColor: Colors.grey,
                          elevation: 5,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Kembali'))
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
