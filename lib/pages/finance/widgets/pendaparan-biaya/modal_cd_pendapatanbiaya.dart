// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter_web_course/models/http_komp_pendapatan.dart';
import 'package:flutter_web_course/models/http_maskapai.dart';
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

class ModalCdPendapatanBiaya extends StatefulWidget {
  final String idBiaya;
  final bool tambah;

  const ModalCdPendapatanBiaya(
      {Key key, @required this.idBiaya, @required this.tambah})
      : super(key: key);

  @override
  State<ModalCdPendapatanBiaya> createState() => _ModalCdPendapatanBiayaState();
}

class _ModalCdPendapatanBiayaState extends State<ModalCdPendapatanBiaya> {
  List<Map<String, dynamic>> listJenisBiaya = [];

  String idBiaya;
  String deskripsi;
  String kodeJenis;
  String namaJenis;

  void getDetailSatuan() async {
    var id = widget.idBiaya;
    var response = await http.get(
        Uri.parse("$urlAddress/finance/pendapatan-biaya/detail/$id"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      idBiaya = data[0]['KDXX_PBYA'];
      deskripsi = data[0]['DESKRIPSI'];
      kodeJenis = data[0]['TIPE_PBYA'];
      namaJenis = data[0]['CODD_DESC'];
    });
  }

  void getJenisBiaya() async {
    var id = widget.idBiaya;
    var response =
        await http.get(Uri.parse("$urlAddress/setup/get-komp-biaya"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listJenisBiaya = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getJenisBiaya();
    if (widget.tambah != true) {
      getDetailSatuan();
    }
  }

  Widget inputDeskripsi() {
    return TextFormField(
      initialValue: deskripsi ?? "",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      onChanged: ((value) {
        deskripsi = value;
      }),
      decoration: const InputDecoration(
        label: Text('Deskripsi', style: TextStyle(color: Colors.red)),
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

  Widget inputTipeBiaya() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "Tipe Biaya",
          mode: Mode.MENU,
          onChanged: (value) {
            setState(() {
              kodeJenis = value['CODD_VALU'];
              namaJenis = value['CODD_DESC'];
            });
          },
          items: listJenisBiaya,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['CODD_DESC'].toString()),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
              namaJenis ?? "Pilih Tipe",
              style: TextStyle(
                  color: namaJenis == null ? Colors.red : Colors.black)),
          dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            hoverColor: Colors.white,
          )),
    );
  }

  fncSaveData(context) {
    if (widget.tambah == true) {
      HttpKompPendapatan.saveKompPendapatan(
        deskripsi,
        kodeJenis,
      ).then((value) {
        if (value.status == true) {
          Navigator.pop(context);

          showDialog(
              context: context, builder: (context) => const ModalSaveSuccess());

          menuController.changeActiveitemTo('Komponen Pendapatan dan Biaya');
          navigationController.navigateTo('/finance/master-pendapatan-biaya');
        } else {
          showDialog(
              context: context, builder: (context) => const ModalSaveFail());
        }
      });
    } else {
      HttpKompPendapatan.updateKompPendapatan(
        idBiaya,
        deskripsi,
        kodeJenis,
      ).then((value) {
        if (value.status == true) {
          showDialog(
              context: context, builder: (context) => const ModalSaveSuccess());

          menuController.changeActiveitemTo('Komponen Pendapatan dan Biaya');
          navigationController.navigateTo('/finance/master-pendapatan-biaya');
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
            height: 280,
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
                              ? "Tambah Data Biaya"
                              : "Ubah Data Biaya",
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
                      inputDeskripsi(),
                      const SizedBox(height: 8),
                      inputTipeBiaya(),
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
