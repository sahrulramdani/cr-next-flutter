// ignore_for_file: deprecated_member_use, missing_return, prefer_interpolation_to_compose_strings, non_constant_identifier_names, avoid_print

import 'package:flutter_web_course/models/http_grup_barang.dart';
import 'package:flutter_web_course/pages/inventory/widgets/grupbarang/modal_list_grup.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../../../../comp/modal_save_fail.dart';
import '../../../../comp/modal_save_success.dart';
import '../../../../constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';

class ModalTambahBarangGrupHeader extends StatefulWidget {
  // final String namaGrup;
  const ModalTambahBarangGrupHeader({Key key}) : super(key: key);

  @override
  State<ModalTambahBarangGrupHeader> createState() =>
      _ModalTambahBarangGrupHeaderState();
}

class _ModalTambahBarangGrupHeaderState
    extends State<ModalTambahBarangGrupHeader> {
  String namaGrupBarang;
  String Keterangan;

  Widget inputId() {
    return TextFormField(
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Kode Grup Barang',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      initialValue: "Auto Generate",
    );
  }

  Widget inputNamaGrupBarang() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Nama Grup Barang',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      onChanged: ((value) {
        namaGrupBarang = value;
      }),
      // onChanged: (value) {

      // },
    );
  }

  Widget inputKeterangan() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Keterangan',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      onChanged: (value) {
        Keterangan = value;
      },
    );
  }

  fncSaveData() {
    // print("NAMA GRUP BARANG : $namaGrupBarang");
    // print("KETERANGAN : $Keterangan");

    HttpGrupBarang.saveGrupBarangHeader(namaGrupBarang, Keterangan)
        .then((value) {
      if (value.status == true) {
        showDialog(
            context: context, builder: (context) => const ModalSaveSuccess());

        menuController.changeActiveitemTo('Grup Barang');
        navigationController.navigateTo('/inventory/grup-barang');
      } else {
        showDialog(
            context: context, builder: (context) => const ModalSaveFail());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.5,
            height: 300,
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
                      Text('Pilih Barang',
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
                      // inputBarang(),
                      const SizedBox(height: 8),
                      inputId(),
                      const SizedBox(height: 8),
                      inputNamaGrupBarang(),
                      const SizedBox(height: 8),
                      inputKeterangan(),
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
