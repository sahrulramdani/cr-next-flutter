// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter_web_course/models/http_cost_structure.dart';
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

class ModalCdCostStructure extends StatefulWidget {
  const ModalCdCostStructure({Key key}) : super(key: key);

  @override
  State<ModalCdCostStructure> createState() => _ModalCdCostStructureState();
}

class _ModalCdCostStructureState extends State<ModalCdCostStructure> {
  List<Map<String, dynamic>> listPendapatan = [];
  List<Map<String, dynamic>> listBiaya = [];

  String idSumbDana;
  String namaSumbDana;
  String idBiaya;
  String namaBiaya;

  void getPendapatan() async {
    var response = await http
        .get(Uri.parse("$urlAddress/finance/pendapatan-biaya/8901"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listPendapatan = data;
    });
  }

  void getBiaya() async {
    var response = await http
        .get(Uri.parse("$urlAddress/finance/pendapatan-biaya/8902"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listBiaya = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getPendapatan();
    getBiaya();
  }

  Widget inputSumberDana() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "Sumber Dana",
          mode: Mode.MENU,
          onChanged: (value) {
            setState(() {
              idSumbDana = value['KDXX_PBYA'];
              namaSumbDana = value['DESKRIPSI'];
            });
          },
          items: listPendapatan,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['DESKRIPSI'].toString()),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
              namaSumbDana ?? "Pilih Sumber Dana",
              style: TextStyle(
                  color: namaSumbDana == null ? Colors.red : Colors.black)),
          dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            hoverColor: Colors.white,
          )),
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
              idBiaya = value['KDXX_PBYA'];
              namaBiaya = value['DESKRIPSI'];
            });
          },
          items: listBiaya,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['DESKRIPSI'].toString()),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
              namaBiaya ?? "Pilih Tipe",
              style: TextStyle(
                  color: namaBiaya == null ? Colors.red : Colors.black)),
          dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            hoverColor: Colors.white,
          )),
    );
  }

  fncSaveData(context) {
    HttpCostStructure.saveCostSructure(
      idSumbDana,
      idBiaya,
    ).then((value) {
      if (value.status == true) {
        Navigator.pop(context);

        showDialog(
            context: context, builder: (context) => const ModalSaveSuccess());

        menuController.changeActiveitemTo('Cost Structure');
        navigationController.navigateTo('/finance/cost-structure');
      } else {
        showDialog(
            context: context, builder: (context) => const ModalSaveFail());
      }
    });
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
                      Text("Tambah Cost Structure",
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
                      inputSumberDana(),
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
