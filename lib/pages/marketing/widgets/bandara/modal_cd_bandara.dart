// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print, must_be_immutable, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter_web_course/models/http_bandara.dart';
import 'package:flutter_web_course/models/http_hotel.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';

class ModalCdBandara extends StatefulWidget {
  final String idBandara;
  final bool tambah;

  const ModalCdBandara(
      {Key key, @required this.idBandara, @required this.tambah})
      : super(key: key);

  @override
  State<ModalCdBandara> createState() => _ModalCdBandaraState();
}

class _ModalCdBandaraState extends State<ModalCdBandara> {
  String idBandara;
  String kodeBandara;
  String namaBandara;
  String idJenis;
  String namaJenis;
  String idNegara;
  String namaNegara;
  String idProvinsi;
  String namaProvinsi;
  String idKota;
  String namaKota;
  String keterangan;

  List<Map<String, dynamic>> listJenisBandara = [];
  List<Map<String, dynamic>> listNegara = [];
  List<Map<String, dynamic>> listProvinsi = [];
  List<Map<String, dynamic>> listKota = [];

  void getDetailBandara() async {
    var id = widget.idBandara;
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/bandara/get-detail/$id"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      idBandara = data[0]['IDXX_BAND'];
      kodeBandara = data[0]['KDXX_BAND'];
      namaBandara = data[0]['NAMA_BAND'];
      idJenis = data[0]['JENS_BAND'];
      namaJenis = data[0]['JENIS'];
      idNegara = data[0]['NEGR_BAND'];
      namaNegara = data[0]['NEGARA'];
      idProvinsi = data[0]['PROV_BAND'];
      namaProvinsi = data[0]['PROVINSI'];
      idKota = data[0]['KOTA_BAND'];
      namaKota = data[0]['KOTA'];
      keterangan = data[0]['KETERANGAN'];
    });

    getProvinsiAll(idNegara);
    getKotaAll(idProvinsi);
  }

  void getJenisBandara() async {
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/bandara/jenis-bandara"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listJenisBandara = data;
    });
  }

  void getNegaraAll() async {
    var response =
        await http.get(Uri.parse("$urlAddress/setup/get-country"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listNegara = data;
    });
  }

  void getProvinsiAll(id) async {
    var response =
        await http.get(Uri.parse("$urlAddress/setup/get-states/$id"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listProvinsi = data;
    });
  }

  void getKotaAll(id) async {
    var response =
        await http.get(Uri.parse("$urlAddress/setup/get-cities/$id"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listKota = data;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.tambah != true) {
      getDetailBandara();
    }

    getJenisBandara();
    getNegaraAll();
  }

  Widget inputKodeBandara() {
    return TextFormField(
      initialValue: kodeBandara ?? "",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      onChanged: ((value) {
        kodeBandara = value;
      }),
      decoration: const InputDecoration(
        label: Text('Kode Bandara', style: TextStyle(color: Colors.red)),
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Kode masih kosong !";
        }
      },
    );
  }

  Widget inputNamaBandara() {
    return TextFormField(
      initialValue: namaBandara ?? "",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      onChanged: ((value) {
        namaBandara = value;
      }),
      decoration: const InputDecoration(
        label: Text('Nama Bandara', style: TextStyle(color: Colors.red)),
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Nama masih kosong !";
        }
      },
    );
  }

  Widget inputJenisBandara() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Jenis Bandara",
        mode: Mode.MENU,
        items: listJenisBandara,
        onChanged: (value) {
          namaJenis = value["CODD_DESC"];
          idJenis = value["CODD_VALU"];
        },
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
            namaJenis ?? "Pilih Jenis",
            style: TextStyle(
                color: namaJenis == null ? Colors.red : Colors.black)),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, fillColor: Colors.white, filled: true),
        validator: (value) {
          if (value == "Pilih Jenis") {
            return "Jenis Bandara kosong !";
          }
        },
      ),
    );
  }

  Widget inputNegara() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Negara",
        mode: Mode.MENU,
        items: listNegara,
        showSearchBox: true,
        onChanged: (value) {
          idNegara = value["id"].toString();
          namaNegara = value["name"].toString();

          getProvinsiAll(idNegara);
        },
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['name'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
            namaNegara ?? "Pilih Negara",
            style: TextStyle(
                color: namaNegara == null ? Colors.red : Colors.black)),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, fillColor: Colors.white, filled: true),
        validator: (value) {
          if (value == "Pilih Negara") {
            return "Nama Negara kosong !";
          }
        },
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
        label: "Provinsi",
        mode: Mode.MENU,
        items: listProvinsi,
        showSearchBox: true,
        onChanged: (value) {
          idProvinsi = value["id"].toString();
          namaProvinsi = value["name"].toString();

          getKotaAll(idProvinsi);
        },
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['name'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
            namaProvinsi ?? "Pilih Provinsi",
            style: TextStyle(
                color: namaProvinsi == null ? Colors.red : Colors.black)),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, fillColor: Colors.white, filled: true),
        validator: (value) {
          if (value == "Pilih Provinsi") {
            return "Nama Provinsi kosong !";
          }
        },
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
        label: "Kota / Kab",
        mode: Mode.MENU,
        items: listKota,
        showSearchBox: true,
        onChanged: (value) {
          idKota = value["id"].toString();
          namaKota = value["name"].toString();
        },
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['name'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
            namaKota ?? "Pilih Kota/Kab",
            style:
                TextStyle(color: namaKota == null ? Colors.red : Colors.black)),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, fillColor: Colors.white, filled: true),
        validator: (value) {
          if (value == "Pilih Kota/Kab") {
            return "Nama Kota/Kab kosong !";
          }
        },
      ),
    );
  }

  Widget inputKeterangan() {
    return TextFormField(
      initialValue: keterangan ?? "",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      onChanged: ((value) {
        keterangan = value;
      }),
      decoration: const InputDecoration(
        labelText: 'Keterangan',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
    );
  }

  fncSaveData(context) {
    if (widget.tambah == true) {
      HttpBandara.saveBandara(
        kodeBandara,
        namaBandara,
        idJenis,
        idNegara ?? '',
        idProvinsi ?? '',
        idKota ?? '',
        keterangan ?? '',
      ).then((value) {
        if (value.status == true) {
          Navigator.pop(context);

          showDialog(
              context: context, builder: (context) => const ModalSaveSuccess());

          menuController.changeActiveitemTo('Master Bandara');
          navigationController.navigateTo('/mrkt/bandara');
        } else {
          showDialog(
              context: context, builder: (context) => const ModalSaveFail());
        }
      });
    } else {
      HttpBandara.updateBandara(
        idBandara,
        kodeBandara,
        namaBandara,
        idJenis,
        idNegara ?? '',
        idProvinsi ?? '',
        idKota ?? '',
        keterangan ?? '',
      ).then((value) {
        if (value.status == true) {
          showDialog(
              context: context, builder: (context) => const ModalSaveSuccess());

          menuController.changeActiveitemTo('Master Bandara');
          navigationController.navigateTo('/mrkt/bandara');
        } else {
          showDialog(
              context: context, builder: (context) => const ModalSaveFail());
        }
      });
    }
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
            width: screenWidth * 0.5,
            height: 600,
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
                      Text(
                          widget.tambah == true
                              ? "Tambah Data Bandara"
                              : "Ubah Data Bandara",
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    children: [
                      inputKodeBandara(),
                      const SizedBox(height: 8),
                      inputNamaBandara(),
                      const SizedBox(height: 8),
                      inputJenisBandara(),
                      const SizedBox(height: 8),
                      inputNegara(),
                      const SizedBox(height: 8),
                      inputProvinsi(),
                      const SizedBox(height: 8),
                      inputKota(),
                      const SizedBox(height: 8),
                      inputKeterangan(),
                      const SizedBox(height: 8),
                    ],
                  ),
                )),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            fncSaveData(context);
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
