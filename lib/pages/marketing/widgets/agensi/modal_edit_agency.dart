// ignore_for_file: deprecated_member_use, missing_return, must_be_immutable

// import 'package:flutter_web_course/constants/public_variable.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import '../../../../models/http_agency.dart';

class ModalEditAgency extends StatefulWidget {
  String idAgency;
  ModalEditAgency({Key key, @required this.idAgency}) : super(key: key);

  @override
  State<ModalEditAgency> createState() => _ModalEditAgencyState();
}

class _ModalEditAgencyState extends State<ModalEditAgency> {
  String nik;
  String nama;
  String jenisKelamin;
  String jk;
  String tempatLahir;
  String alamat;
  String idKantor;
  String namaKantor;
  String namaProvinsi;
  String namaKota;
  String namaKec;
  String namaKel;
  String kodePos;
  String idLeader;
  String namaLeader;
  String idFee;
  String namaFee;
  String namaAyah;
  String telepon;
  String idMenikah;
  String menikah;
  String idPendidikan;
  String namaPendidikan;
  String idPekerjaan;
  String namaPekerjaan;
  String cekPaspor;
  String noPaspor;
  String dikeluarkanDi;
  String statusAgen;
  String idStatus;

  String fotoAgency = "";
  String fotoAgencyBase = "";
  Uint8List fotoAgencyByte;
  String fotoLamaAgen = "";

  String fotoKtpAgency = "";
  String fotoKtpAgencyBase = "";
  Uint8List fotoKtpAgencyByte;
  String fotoLamaKtpAgen = "";

  List<Map<String, dynamic>> dataAgensi = [];
  List<Map<String, dynamic>> listProvinsi = [];
  List<Map<String, dynamic>> listKota = [];
  List<Map<String, dynamic>> listKec = [];
  List<Map<String, dynamic>> listKel = [];
  List<Map<String, dynamic>> listKantor = [];
  List<Map<String, dynamic>> listLeader = [];
  List<Map<String, dynamic>> listFee = [];
  List<Map<String, dynamic>> listMenikah = [];
  List<Map<String, dynamic>> listPendidikan = [];
  List<Map<String, dynamic>> listPekerjaan = [];

  TextEditingController dateLhir = TextEditingController();
  TextEditingController dateKeluar = TextEditingController();
  TextEditingController dateExp = TextEditingController();

  void getDetail() async {
    String id = widget.idAgency;
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/agency/detail/$id"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataAgen =
        List.from(json.decode(response.body) as List);

    setState(() {
      dataAgensi = dataAgen;
      nik = dataAgen[0]['NOXX_IDNT'];
      nama = dataAgen[0]['NAMA_LGKP'];
      jenisKelamin = dataAgen[0]['JENS_KLMN'];
      if (dataAgen[0]['JENS_KLMN'] == 'P') {
        jk = 'Pria';
      } else {
        jk = 'Wanita';
      }
      tempatLahir = dataAgen[0]['TMPT_LHIR'];
      dateLhir.text = DateFormat("dd-MM-yyyy")
          .format(DateTime.parse(dataAgen[0]['TGLX_LHIR']));
      alamat = dataAgen[0]['ALAMAT'];
      idKantor = dataAgen[0]['KDXX_KNTR'];
      namaKantor = dataAgen[0]['NAMA_KNTR'];
      namaProvinsi = dataAgen[0]['KDXX_PROV'];
      namaKota = dataAgen[0]['KDXX_KOTA'];
      namaKec = dataAgen[0]['KDXX_KECX'];
      namaKel = dataAgen[0]['KDXX_KELX'];
      kodePos = dataAgen[0]['KDXX_POSX'].toString();
      idLeader = dataAgen[0]['KDXX_LEAD'];
      namaLeader = dataAgen[0]['UPLINE'];
      idFee = dataAgen[0]['FEEX_LVEL'];
      namaFee = dataAgen[0]['FEE'];
      namaAyah = dataAgen[0]['NAMA_AYAH'];
      telepon = dataAgen[0]['NOXX_TELP'];
      idMenikah = dataAgen[0]['JENS_MNKH'];
      menikah = dataAgen[0]['MENIKAH'];
      idPendidikan = dataAgen[0]['JENS_PEND'];
      namaPendidikan = dataAgen[0]['PENDIDIKAN'];
      idPekerjaan = dataAgen[0]['JENS_PKRJ'];
      namaPekerjaan = dataAgen[0]['PEKERJAAN'];
      if (dataAgen[0]['NOXX_PSPR'] != null) {
        cekPaspor = 'Ada';
        noPaspor = dataAgen[0]['NOXX_PSPR'];
        dikeluarkanDi = dataAgen[0]['KLUR_DIXX'];
        dateKeluar.text = DateFormat("dd-MM-yyyy")
            .format(DateTime.parse(dataAgen[0]['TGLX_KLUR']));
        dateExp.text = DateFormat("dd-MM-yyyy")
            .format(DateTime.parse(dataAgen[0]['TGLX_EXPX']));
      } else {
        cekPaspor = 'Belum Ada';
      }
      statusAgen = dataAgen[0]['STATUS_AGEN'];
      idStatus = dataAgen[0]['STAS_AGEN'].toString();
      fotoAgency = dataAgen[0]['FOTO_AGEN'];
      fotoLamaAgen = dataAgen[0]['FOTO_AGEN'];
      fotoKtpAgency = dataAgen[0]['FOTO_KTPX'];
      fotoLamaKtpAgen = dataAgen[0]['FOTO_KTPX'];
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

  getKantor() async {
    var response = await http.get(Uri.parse("$urlAddress/setup/kantor"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listKantor = dataStatus;
    });
  }

  getLeader() async {
    var response =
        await http.get(Uri.parse("$urlAddress/marketing/all-agency"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listLeader = dataStatus;
    });
  }

  getFeeLevel() async {
    var response = await http.get(Uri.parse("$urlAddress/setup/fee-level"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listFee = dataStatus;
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
    getKantor();
    getLeader();
    getFeeLevel();
    getMenikah();
    getPendidikan();
    getPekerjaan();
  }

  Widget inputKodeMarket() {
    return TextFormField(
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Kode Marketing',
          hintText: '',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      initialValue: widget.idAgency,
    );
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
      initialValue: nama ?? '',
      onChanged: (value) {
        nama = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Nama masih kosong !";
        }
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
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
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

  Widget inputKantor() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Nama Kantor",
        items: listKantor,
        onChanged: (value) {
          namaKantor = value['NAMA_KNTR'];
          idKantor = value['KDXX_KNTR'];
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['NAMA_KNTR'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaKantor ?? "Nama Kantor belum Dipilih"),
        validator: (value) {
          if (value == "Nama Kantor belum Dipilih") {
            return "Kantor masih kosong !";
          }
        },
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
      ),
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

  Widget inputStatusAgen() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Status Agen",
        mode: Mode.MENU,
        items: const ["Aktif", "Tidak Aktif"],
        onChanged: (value) {
          if (value == "Aktif") {
            statusAgen = 'Aktif';
            idStatus = '1';
          } else {
            statusAgen = 'Tidak Aktif';
            idStatus = '0';
          }
        },
        selectedItem: statusAgen ?? "Pilih Status Agen",
        dropdownSearchDecoration: const InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == "Pilih Status Agen") {
            return "Status Agen masih kosong !";
          }
        },
      ),
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

  Widget inputNamaLeader() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Nama Leader",
        items: listLeader,
        onChanged: (value) {
          if (value != null) {
            idLeader = value["KDXX_MRKT"];
            namaLeader = value["NAMA_LGKP"];
          } else {
            idLeader = null;
            namaLeader = null;
          }
        },
        showClearButton: true,
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['NAMA_LGKP'].toString()),
          leading: CircleAvatar(
            backgroundImage:
                NetworkImage('$urlAddress/uploads/${item['FOTO_AGEN']}'),
          ),
          subtitle: Text(item['NOXX_IDNT'].toString()),
          trailing: Text(
              DateFormat("yyyy-MM-dd")
                  .format(DateTime.parse(item['TGLX_LHIR'].toString())),
              textAlign: TextAlign.center),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaLeader ?? "Leader belum Dipilih"),
        validator: (value) {
          if (value == "Leader belum dipilih") {
            return "Nama Leader masih kosong !";
          }
        },
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
      ),
    );
  }

  Widget inputFeeLevel() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Fee Level",
        items: listFee,
        onChanged: (value) {
          namaFee = value['CODD_DESC'];
          idFee = value['CODD_VALU'];
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaFee ?? "Fee Level belum Dipilih"),
        validator: (value) {
          if (value == "Fee Level belum Dipilih") {
            return "Fee Level masih kosong !";
          }
        },
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
      ),
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
        telepon = value;
      },
      initialValue: telepon ?? "",
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
          menikah = value['CODD_DESC'];
          idMenikah = value['CODD_VALU'];
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(menikah ?? "Status menikah belum Dipilih"),
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
            cekPaspor = 'Ada';
          } else {
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
      initialValue: noPaspor ?? "",
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
      initialValue: fotoAgency != "" ? fotoAgency : "Pilih",
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
      initialValue: fotoKtpAgency != "" ? fotoKtpAgency : "Pilih",
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Upload KTP',
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget resultFotoAgency() {
    if (fotoAgencyByte != null) {
      return Image.memory(
        fotoAgencyByte,
        width: 150,
      );
    } else {
      if (fotoAgency != "") {
        return Image(
          image: NetworkImage('$urlAddress/uploads/$fotoAgency'),
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
    if (fotoKtpAgencyByte != null) {
      return Image.memory(
        fotoKtpAgencyByte,
        width: 150,
      );
    } else {
      if (fotoKtpAgency != "") {
        return Image(
          image: NetworkImage('$urlAddress/uploads/$fotoKtpAgency'),
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

  getImageAgency() async {
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    Uint8List bytes = fileResult.files.first.bytes;
    String encodeFoto = base64.encode(bytes);

    if (fileResult != null) {
      setState(() {
        fotoAgency = fileResult.files.first.name;
        fotoAgencyByte = fileResult.files.first.bytes;
        fotoAgencyBase = encodeFoto;
      });
    }
  }

  getImageKtp() async {
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    Uint8List bytes = fileResult.files.first.bytes;
    String encodeFoto = base64.encode(bytes);

    if (fileResult != null) {
      setState(() {
        fotoKtpAgency = fileResult.files.first.name;
        fotoKtpAgencyByte = fileResult.files.first.bytes;
        fotoKtpAgencyBase = encodeFoto;
      });
    }
  }

  fncSaveData() {
    // print(widget.idAgency);
    // print(nik);
    // print(nama);
    // print(jenisKelamin);
    // print(tempatLahir);
    // print(fncTanggal(dateLhir.text));
    // print(alamat);
    // print(idKantor);
    // print(namaProvinsi);
    // print(namaKota);
    // print(namaKec);
    // print(namaKel);
    // print(kodePos);
    // print(idLeader);
    // print(idFee);
    // print(namaAyah);
    // print(telepon);
    // print(idMenikah);
    // print(idPendidikan);
    // print(idPekerjaan);
    // print(fotoAgencyBase != '' ? fotoAgencyBase : 'ADA');
    // print(fotoKtpAgencyBase != '' ? fotoKtpAgencyBase : 'ADA');
    // print(noPaspor);
    // print(dikeluarkanDi);
    // print(dateKeluar.text != '' ? fncTanggal(dateKeluar.text) : null);
    // print(dateExp.text != '' ? fncTanggal(dateExp.text) : null);
    // showDialog(
    //     context: context, builder: (context) => const ModalSaveSuccess());

    // menuController.changeActiveitemTo('Data Jamaah');
    // navigationController.navigateTo('/jamaah/master');

    HttpAgency.updateAgency(
      widget.idAgency,
      nik,
      nama,
      jenisKelamin,
      tempatLahir,
      fncTanggal(dateLhir.text),
      alamat,
      idKantor,
      namaProvinsi,
      namaKota,
      namaKec,
      namaKel,
      kodePos,
      idLeader,
      idFee,
      namaAyah,
      telepon,
      idMenikah,
      idPendidikan,
      idPekerjaan,
      noPaspor,
      dikeluarkanDi,
      dateKeluar.text != '' ? fncTanggal(dateKeluar.text) : null,
      dateExp.text != '' ? fncTanggal(dateExp.text) : null,
      idStatus,
      fotoAgencyBase != '' ? fotoAgencyBase : 'TIDAK',
      fotoKtpAgencyBase != '' ? fotoKtpAgencyBase : 'TIDAK',
      fotoLamaAgen,
      fotoLamaKtpAgen,
    ).then(
      (value) {
        if (value.status == true) {
          menuController.changeActiveitemTo('Agency');
          navigationController.navigateTo('/mrkt/agency');
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
                                inputKodeMarket(),
                                const SizedBox(height: 8),
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
                                inputKantor(),
                                const SizedBox(height: 8),
                                inputProvinsi(),
                                const SizedBox(height: 8),
                                inputKota(),
                                const SizedBox(height: 8),
                                inputKec(),
                                const SizedBox(height: 8),
                                inputKel(),
                                const SizedBox(height: 8),
                                inputStatusAgen(),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    resultFotoAgency(),
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
                                          getImageAgency();
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
                                inputNamaLeader(),
                                const SizedBox(height: 8),
                                inputFeeLevel(),
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
