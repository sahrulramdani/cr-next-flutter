// ignore_for_file: missing_return, deprecated_member_use
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/constants/dummy_data_bandara.dart';
import 'package:flutter_web_course/constants/public_variable.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/models/http_jamaah.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/jamaah/modal_upload_foto_jamaah.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/jamaah/modal_upload_ktp_jamaah.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:intl/intl.dart';
import '../../../../models/http_agency.dart';
import 'dart:convert';

class JamaahForm extends StatefulWidget {
  // final List<Map<String, dynamic>> listProvinsi;

  const JamaahForm({
    Key key,
    // @required this.listProvinsi,
  }) : super(key: key);

  @override
  State<JamaahForm> createState() => _JamaahFormState();
}

class _JamaahFormState extends State<JamaahForm> {
  String nik;
  String namaJamaah;
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
  String paspor;
  String cekpaspor;
  String noPaspor;
  String dikeluarkanDi;

  List<Map<String, dynamic>> listProvinsi = [];
  List<Map<String, dynamic>> listKota = [];
  List<Map<String, dynamic>> listKec = [];
  List<Map<String, dynamic>> listKel = [];
  List<Map<String, dynamic>> listMenikah = [];
  List<Map<String, dynamic>> listPendidikan = [];
  List<Map<String, dynamic>> listPekerjaan = [];

  TextEditingController dateLahir = TextEditingController();
  TextEditingController dateKeluar = TextEditingController();
  TextEditingController dateExp = TextEditingController();

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
    getProvinsi();
    getMenikah();
    getPendidikan();
    getPekerjaan();
    super.initState();
  }

  Widget inputNIK() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          label: Text('NIK', style: TextStyle(color: Colors.red)),
          hintText: '327xxxxxxxx'),
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
      decoration: const InputDecoration(
          label: Text('Nama Lengkap', style: TextStyle(color: Colors.red))),
      onChanged: (value) {
        namaJamaah = value;
      },
      initialValue: namaJamaah,
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
        dropdownBuilder: (context, selectedItem) => Text(
            jk ?? "Pilih Jenis Kelamin",
            style: TextStyle(color: jk == null ? Colors.red : Colors.black)),
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
      decoration: const InputDecoration(
          label: Text('Tempat Lahir', style: TextStyle(color: Colors.red))),
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
      decoration: const InputDecoration(
          label: Text('Tanggal Lahir', style: TextStyle(color: Colors.red))),
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
      decoration: const InputDecoration(
          label: Text('Alamat', style: TextStyle(color: Colors.red))),
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
          dropdownBuilder: (context, selectedItem) => Text(
              namaProvinsi ?? "Nama Provinsi belum Dipilih",
              style: TextStyle(
                  color: namaProvinsi == null ? Colors.red : Colors.black)),
          validator: (value) {
            if (value == "Nama Provinsi belum Dipilih") {
              return "Provinsi masih kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
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
          dropdownBuilder: (context, selectedItem) => Text(
              namaKota ?? "Nama Kota belum Dipilih",
              style: TextStyle(
                  color: namaKota == null ? Colors.red : Colors.black)),
          validator: (value) {
            if (value == "Nama Kota belum Dipilih") {
              return "Kota masih kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
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
          dropdownBuilder: (context, selectedItem) => Text(
              namaKec ?? "Nama Kecamatan belum Dipilih",
              style: TextStyle(
                  color: namaKec == null ? Colors.red : Colors.black)),
          validator: (value) {
            if (value == "Nama Kecamatan belum Dipilih") {
              return "Kecamatan masih kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
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
          dropdownBuilder: (context, selectedItem) => Text(
              namaKel ?? "Nama Kelurahan belum Dipilih",
              style: TextStyle(
                  color: namaKel == null ? Colors.red : Colors.black)),
          validator: (value) {
            if (value == "Nama Kelurahan belum Dipilih") {
              return "Kelurahan masih kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputKodePos() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          label: Text('Kode Pos', style: TextStyle(color: Colors.red))),
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
            paspor = 'a';
            cekpaspor = 'Ada';
          } else {
            paspor = 'n';
            cekpaspor = 'Belum Ada';
          }
        },
        selectedItem: "Pilih Status Paspor",
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget inputNoPaspor() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Nomor Paspor'),
      onChanged: (value) {
        noPaspor = value;
      },
    );
  }

  Widget inputPasporKeluar() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Dikeluarkan di'),
      onChanged: (value) {
        dikeluarkanDi = value;
      },
    );
  }

  Widget inputTglKeluar() {
    return TextField(
      controller: dateKeluar,
      decoration: const InputDecoration(labelText: 'Tanggal Dikeluarkan'),
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

  Widget inputRouteFile() {
    return TextFormField(
      initialValue: "Upload Foto",
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Upload Foto',
      ),
    );
  }

  Widget inputTglExp() {
    return TextField(
      controller: dateExp,
      decoration: const InputDecoration(labelText: 'Berlaku Hingga'),
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
      ),
    );
  }

  fncSaveData() {
    // print(nik);
    // print(namaJamaah);
    // print(jenisKelamin);
    // print(tempatLahir);
    // print(fncTanggal(dateLahir.text));
    // print(alamat);
    // print(namaProvinsi);
    // print(namaKota);
    // print(namaKec);
    // print(namaKel);
    // print(kodePos);
    // print(namaAyah);
    // print(noTelp);
    // print(namaMenikah);
    // print(namaPendidikan);
    // print(namaPekerjaan);
    // print(fotoJamaah);
    // print(fotoKtpAgencyBase);
    // print(noPaspor);
    // print(dikeluarkanDi);
    // print(dateKeluar.text != '' ? fncTanggal(dateKeluar.text) : null);
    // print(dateExp.text != '' ? fncTanggal(dateExp.text) : null);

    // showDialog(
    //     context: context, builder: (context) => const ModalSaveSuccess());

    // menuController.changeActiveitemTo('Data Jamaah');
    // navigationController.navigateTo('/jamaah/master');

    HttpJamaah.saveJamaah(
      nik,
      namaJamaah,
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
      fotoJamaahBase != '' ? fotoJamaahBase : 'TIDAK',
      fotoKtpJamaahBase != '' ? fotoKtpJamaahBase : 'TIDAK',
      noPaspor,
      dikeluarkanDi,
      dateKeluar.text != '' ? fncTanggal(dateKeluar.text) : null,
      dateExp.text != '' ? fncTanggal(dateExp.text) : null,
    ).then(
      (value) {
        if (value.status == true) {
          showDialog(
              context: context, builder: (context) => const ModalSaveSuccess());

          menuController.changeActiveitemTo('Data Jamaah');
          navigationController.navigateTo('/jamaah/master');

          setState(() {
            fotoJamaah = '';
            fotoJamaahBase = '';
            fotoJamaahByte = null;

            fotoKtpJamaah = '';
            fotoKtpJamaahBase = '';
            fotoKtpJamaahByte = null;
          });
        } else {
          showDialog(
              context: context, builder: (context) => const ModalSaveFail());

          setState(() {
            fotoJamaah = '';
            fotoJamaahBase = '';
            fotoJamaahByte = null;

            fotoKtpJamaah = '';
            fotoKtpJamaahBase = '';
            fotoKtpJamaahByte = null;
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
                    fotoJamaah = '';
                    fotoJamaahBase = '';
                    fotoJamaahByte = null;

                    fotoKtpJamaah = '';
                    fotoKtpJamaahBase = '';
                    fotoKtpJamaahByte = null;
                  });

                  menuController.changeActiveitemTo('Data Jamaah');
                  navigationController.navigateTo('/jamaah/master');
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                                const ModalUploadFotoJamaah());
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
                                                const ModalUploadKtpJamaah());
                                      },
                                      icon: const Icon(Icons.save),
                                      label: const Text(
                                        'Upload Ktp',
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
