// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print

import 'dart:convert';

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

class ModalCdMaskapai extends StatefulWidget {
  final String idMaskapai;
  final bool tambah;

  const ModalCdMaskapai(
      {Key key, @required this.idMaskapai, @required this.tambah})
      : super(key: key);

  @override
  State<ModalCdMaskapai> createState() => _ModalCdMaskapaiState();
}

class _ModalCdMaskapaiState extends State<ModalCdMaskapai> {
  String idMaskapai;
  String namaMaskapai;

  void getDetailSatuan() async {
    var id = widget.idMaskapai;
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/maskapai/getDetailMaskapai/$id"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      idMaskapai = data[0]['IDXX_PSWT'];
      namaMaskapai = data[0]['NAMA_PSWT'];
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.tambah != true) {
      getDetailSatuan();
    }
  }

  Widget inputSatuan() {
    return TextFormField(
      initialValue: namaMaskapai ?? "",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      onChanged: ((value) {
        namaMaskapai = value;
      }),
      decoration: const InputDecoration(
        labelText: 'Maskapai',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
    );
  }

  fncSaveData() {
    // print("ID SATUAN : $idSatuan");
    // print("NAMA SATUAN : $namaSatuan");

    if (widget.tambah == true) {
      HttpMaskapai.saveMaskapai(namaMaskapai).then((value) {
        if (value.status == true) {
          showDialog(
              context: context, builder: (context) => const ModalSaveSuccess());

          menuController.changeActiveitemTo('Master Maskapai');
          navigationController.navigateTo('/mrkt/maskapai');
        } else {
          showDialog(
              context: context, builder: (context) => const ModalSaveFail());
        }
      });
    } else {
      HttpMaskapai.updateMaskapai(idMaskapai, namaMaskapai).then((value) {
        if (value.status == true) {
          showDialog(
              context: context, builder: (context) => const ModalSaveSuccess());

          menuController.changeActiveitemTo('Master Maskapai');
          navigationController.navigateTo('/mrkt/maskapai');
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
            height: 200,
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
                              ? "Tambah Data Maskapai"
                              : "Ubah Data Maskapai",
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
                      inputSatuan(),
                      const SizedBox(
                        height: 8,
                      ),
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
