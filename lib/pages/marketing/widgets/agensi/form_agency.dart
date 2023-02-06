// ignore_for_file: missing_return, deprecated_member_use
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/constants/public_variable.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/pages/marketing/widgets/agensi/modal_upload_foto_agency.dart';
import 'package:flutter_web_course/pages/marketing/widgets/agensi/modal_upload_ktp_agency.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy_marketing.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:intl/intl.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import '../../../../models/http_agency.dart';

class AgencyForm extends StatefulWidget {
  const AgencyForm({Key key}) : super(key: key);

  @override
  State<AgencyForm> createState() => _AgencyFormState();
}

class _AgencyFormState extends State<AgencyForm> {
  String namaJamaah;
  String nik;
  String namaAgency;
  String jenisKelamin;
  String jk;
  String tempatLahir;
  String alamat;
  String idKantor;
  String namaKantor;
  String idProvinsi;
  String namaProvinsi;
  String idKota;
  String namaKota;
  String idKec;
  String namaKec;
  String idKel;
  String namaKel;
  String kodePos;
  String idLeader;
  String namaLeader;
  String idFee;
  String namaFee;
  String namaAyah;
  String noTelp;
  String idMenikah;
  String namaMenikah;
  String idPendidikan;
  String namaPendidikan;
  String idPekerjaan;
  String namaPekerjaan;
  String cekpaspor;
  String noPaspor;
  String dikeluarkanDi;

  String fileFoto;
  String fileKtp;

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
  List<Map<String, dynamic>> listJamaah = [];

  TextEditingController dateLahir = TextEditingController();
  TextEditingController dateKeluar = TextEditingController();
  TextEditingController dateExp = TextEditingController();

  void getJamaah() async {
    var response =
        await http.get(Uri.parse("$urlAddress/marketing/calon-agency"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    listJamaah = dataStatus;
    setState(() {});
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

    listKota = dataStatus;
    setState(() {});
  }

  getKec(id) async {
    var response = await http.get(Uri.parse(
        "https://www.emsifa.com/api-wilayah-indonesia/api/districts/$id.json"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    listKec = dataStatus;
    setState(() {});
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
    getJamaah();
    getProvinsi();
    getKantor();
    getLeader();
    getFeeLevel();
    getMenikah();
    getPendidikan();
    getPekerjaan();
  }

  // -----------------------------------------------------------------------------------------------
  // -----------------------------------------------------------------------------------------------
  Widget inputJamaah() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Nama Jamaah",
        items: listJamaah,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              nik = value['NOXX_IDNT'];
              namaAgency = value['NAMA_LGKP'];
              jenisKelamin = value['JENS_KLMN'];
              jk = value['JENS_KLMN'] == 'P' ? 'Pria' : 'Wanita';
              tempatLahir = value['TMPT_LHIR'];
              dateLahir.text = DateFormat("dd-MM-yyyy")
                  .format(DateTime.parse(value['TGLX_LHIR']));
              alamat = value['ALAMAT'];
              namaProvinsi = value['KDXX_PROV'];
              namaKota = value['KDXX_KOTA'];
              namaKec = value['KDXX_KECX'];
              namaKel = value['KDXX_KELX'];
              kodePos = value['KDXX_POSX'].toString();
              namaAyah = value['NAMA_AYAH'];
              noTelp = value['NOXX_TELP'];
              idMenikah = value['JENS_MNKH'];
              namaMenikah = value['MENIKAH'];
              idPendidikan = value['JENS_PEND'];
              namaPendidikan = value['PENDIDIKAN'];
              idPekerjaan = value['JENS_PKRJ'];
              namaPekerjaan = value['PEKERJAAN'];
              fotoCalonAgen = value['FOTO_JMAH'];
              fileFoto = value['FOTO_JMAH'];
              ktpCalonAgen = value['FOTO_KTPX'];
              fileKtp = value['FOTO_KTPX'];
              cekpaspor = value['NOXX_PSPR'] != null ? 'Ada' : 'Belum Ada';
              noPaspor = value['NOXX_PSPR'];
              dikeluarkanDi = value['KLUR_DIXX'];
              dateKeluar.text = DateFormat("dd-MM-yyyy")
                  .format(DateTime.parse(value['TGLX_KLUR']));
              dateExp.text = DateFormat("dd-MM-yyyy")
                  .format(DateTime.parse(value['TGLX_EXPX']));
            });
          }
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['NAMA_LGKP'].toString()),
          leading: CircleAvatar(
            backgroundImage:
                NetworkImage('$urlAddress/uploads/${item['FOTO_JMAH']}'),
          ),
          subtitle: Text(item['NOXX_IDNT'].toString()),
          trailing: Text(
              DateFormat("dd-MM-yyyy")
                  .format(DateTime.parse(item['TGLX_LHIR'].toString())),
              textAlign: TextAlign.center),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaJamaah ?? "Jika Berasal Dari Jamaah"),
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget inputNIK() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration:
          const InputDecoration(labelText: 'NIK', hintText: '32xxxxxxxxxxx'),
      onChanged: (value) {
        nik = value;
      },
      initialValue: nik,
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
      decoration: const InputDecoration(labelText: 'Nama Lengkap'),
      onChanged: (value) {
        namaAgency = value;
      },
      initialValue: namaAgency,
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
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
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
      decoration: const InputDecoration(labelText: 'Tempat Lahir'),
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
      decoration: const InputDecoration(labelText: 'Tanggal Lahir'),
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
      decoration: const InputDecoration(labelText: 'Alamat'),
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
        dropdownBuilder: (context, selectedItem) => Text(
          namaKantor ?? "Nama Kantor belum Dipilih",
          style:
              TextStyle(color: namaKantor == null ? Colors.red : Colors.black),
        ),
        validator: (value) {
          if (value == "Nama Kantor belum Dipilih") {
            return "Kantor masih kosong !";
          }
        },
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
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
          if (value == "Nama Provinsi belum Dipilih") {
            return "Provinsi masih kosong !";
          }
        },
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
      ),
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
          if (value == "Nama Kota belum Dipilih") {
            return "Kota masih kosong !";
          }
        },
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
      ),
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
        dropdownBuilder: (context, selectedItem) =>
            Text(namaKec ?? "Nama Kecamatan belum Dipilih"),
        validator: (value) {
          if (value == "Nama Kecamatan belum Dipilih") {
            return "Kecamatan masih kosong !";
          }
        },
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
      ),
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
          if (value == "Nama Kelurahan belum Dipilih") {
            return "Kelurahan masih kosong !";
          }
        },
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget inputKodePos() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Kode Pos'),
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
              DateFormat("dd-MM-yyyy")
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
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
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
        dropdownBuilder: (context, selectedItem) => Text(
            namaFee ?? "Fee Level belum Dipilih",
            style:
                TextStyle(color: namaFee == null ? Colors.red : Colors.black)),
        validator: (value) {
          if (value == "Fee Level belum Dipilih") {
            return "Fee Level masih kosong !";
          }
        },
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget inputNamaAyah() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Nama Ayah'),
      onChanged: (value) {
        namaAyah = value;
      },
      initialValue: namaAyah,
    );
  }

  Widget inputTelp() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Telepon', hintText: "08xxxxxxxxxxx"),
      onChanged: (value) {
        noTelp = value;
      },
      initialValue: noTelp,
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
        dropdownBuilder: (context, selectedItem) => Text(
            namaMenikah ?? "Status menikah belum Dipilih",
            style: TextStyle(
                color: namaMenikah == null ? Colors.red : Colors.black)),
        validator: (value) {
          if (value == "Status menikah belum Dipilih") {
            return "Status menikah masih kosong !";
          }
        },
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
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
        dropdownBuilder: (context, selectedItem) => Text(
            namaPendidikan ?? "Pendidikan terakhir Belum dipilih",
            style: TextStyle(
                color: namaPendidikan == null ? Colors.red : Colors.black)),
        validator: (value) {
          if (value == "Pendidikan terakhir Belum dipilih") {
            return "Pendidikan masih kosong !";
          }
        },
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
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
        dropdownBuilder: (context, selectedItem) => Text(
            namaPekerjaan ?? "Pekerjaan Belum dipilih",
            style: TextStyle(
                color: namaPekerjaan == null ? Colors.red : Colors.black)),
        validator: (value) {
          if (value == "Pekerjaan Belum dipilih") {
            return "Pekerjaan masih kosong !";
          }
        },
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
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
            cekpaspor = 'Ada';
          } else {
            cekpaspor = 'Belum Ada';
          }
        },
        selectedItem: cekpaspor ?? "Pilih Status Paspor",
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget inputNoPaspor() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'No. Paspor'),
      onChanged: (value) {
        noPaspor = value;
      },
      initialValue: noPaspor,
    );
  }

  Widget inputPasporKeluar() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Dikeluarkan Di'),
      onChanged: (value) {
        dikeluarkanDi = value;
      },
      initialValue: dikeluarkanDi,
    );
  }

  Widget inputTglKeluar() {
    return TextField(
      controller: dateKeluar,
      decoration: const InputDecoration(
        labelText: 'Tanggal Dikeluarkan',
      ),
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
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
      ),
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
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
      initialValue: fileFoto ?? "Pilih",
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Upload Foto',
      ),
    );
  }

  Widget inputUploadKTP() {
    return TextFormField(
      initialValue: fileKtp ?? "Pilih",
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Upload KTP',
      ),
    );
  }

  fncBersih() {
    setState(() {
      nik = null;
      namaAgency = null;
      jenisKelamin = null;
      jk = null;
      tempatLahir = null;
      dateLahir.text = null;
      alamat = null;
      namaProvinsi = null;
      namaKota = null;
      namaKec = null;
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
      fotoCalonAgen = '';
      fileFoto = null;
      ktpCalonAgen = '';
      fileKtp = null;
      cekpaspor = null;
      noPaspor = null;
      dikeluarkanDi = null;
      dateKeluar.text = null;
      dateExp.text = null;
    });
  }

  fncSaveData() {
    HttpAgency.saveAgency(
      nik,
      namaAgency,
      jenisKelamin,
      tempatLahir,
      fncTanggal(dateLahir.text),
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
      noTelp,
      idMenikah,
      idPendidikan,
      idPekerjaan,
      fotoAgencyBase != '' ? fotoAgencyBase : 'TIDAK',
      fotoKtpAgencyBase != '' ? fotoKtpAgencyBase : 'TIDAK',
      noPaspor,
      dikeluarkanDi,
      dateKeluar.text != '' ? fncTanggal(dateKeluar.text) : null,
      dateExp.text != '' ? fncTanggal(dateExp.text) : null,
      fotoCalonAgen,
      ktpCalonAgen,
    ).then(
      (value) {
        if (value.status == true) {
          showDialog(
              context: context, builder: (context) => const ModalSaveSuccess());

          menuController.changeActiveitemTo('Agency');
          navigationController.navigateTo('/mrkt/agency');

          setState(() {
            fotoAgency = '';
            fotoAgencyBase = '';
            fotoAgencyByte = null;

            fotoKtpAgency = '';
            fotoKtpAgencyBase = '';
            fotoKtpAgencyByte = null;

            fotoCalonAgen = '';
            ktpCalonAgen = '';
          });
        } else {
          showDialog(
              context: context, builder: (context) => const ModalSaveFail());

          setState(() {
            fotoAgency = '';
            fotoAgencyBase = '';
            fotoAgencyByte = null;

            fotoKtpAgency = '';
            fotoKtpAgencyBase = '';
            fotoKtpAgencyByte = null;

            fotoCalonAgen = '';
            ktpCalonAgen = '';
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final screenHeight = MediaQuery.of(context).size.height;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tambah Data Baru',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: myBlue),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox(width: 20)),
              ElevatedButton.icon(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    fncSaveData();
                  } else {
                    return null;
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text(
                  'Simpan Data',
                  style: TextStyle(fontFamily: 'Gilroy'),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: myBlue,
                  minimumSize: const Size(100, 40),
                  shadowColor: Colors.grey,
                  elevation: 5,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    fotoAgency = '';
                    fotoAgencyBase = '';
                    fotoAgencyByte = null;

                    fotoKtpAgency = '';
                    fotoKtpAgencyBase = '';
                    fotoKtpAgencyByte = null;

                    fotoCalonAgen = '';
                    ktpCalonAgen = '';
                  });

                  menuController.changeActiveitemTo('Agency');
                  navigationController.navigateTo('/mrkt/agency');
                },
                icon: const Icon(Icons.cancel),
                label: const Text(
                  'Batal',
                  style: TextStyle(fontFamily: 'Gilroy'),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: myBlue,
                  minimumSize: const Size(100, 40),
                  shadowColor: Colors.grey,
                  elevation: 5,
                ),
              )
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: 0.47 * screenHeight,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 525,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 410, child: inputJamaah()),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        fncBersih();
                                      },
                                      icon: const Icon(
                                          Icons.cleaning_services_outlined),
                                      label: const Text(
                                        'Clear',
                                        style: TextStyle(fontFamily: 'Gilroy'),
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
                              ),
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
                              inputKodePos(),
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
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const ModalUploadFotoAgency());
                                      },
                                      icon: const Icon(Icons.save),
                                      label: const Text(
                                        'Upload Foto',
                                        style: TextStyle(fontFamily: 'Gilroy'),
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
                          width: 525,
                          child: Column(
                            children: [
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
                                children: [
                                  SizedBox(width: 370, child: inputUploadKTP()),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const ModalUploadKtpAgency());
                                      },
                                      icon: const Icon(Icons.save),
                                      label: const Text(
                                        'Upload KTP',
                                        style: TextStyle(fontFamily: 'Gilroy'),
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
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
