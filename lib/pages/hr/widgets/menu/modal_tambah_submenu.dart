// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/models/http_pengguna.dart';
import 'package:flutter_web_course/pages/hr/widgets/menu/modul_detail_submenu.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';

class ModalTambahSubmenu extends StatefulWidget {
  final String idMenu;
  // final bool tambah;

  const ModalTambahSubmenu({Key key, @required this.idMenu}) : super(key: key);

  @override
  State<ModalTambahSubmenu> createState() => _ModalTambahSubmenuState();
}

class _ModalTambahSubmenuState extends State<ModalTambahSubmenu> {
  String idMenu;
  String namaSubmenu;

  @override
  void initState() {
    setState(() {
      idMenu = widget.idMenu;
    });
    super.initState();
  }

  Widget inputIDMenu() {
    return TextFormField(
      initialValue: "${idMenu}",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'ID Menu',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      readOnly: true,
    );
  }

  Widget inputIDSubMenu() {
    return TextFormField(
      initialValue: 'Auto Generate',
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'ID SubMenu',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      readOnly: true,
    );
  }

  Widget inputNameSubmenu() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      onChanged: ((value) {
        namaSubmenu = value;
      }),
      decoration: const InputDecoration(
        labelText: 'Nama Submenu',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
    );
  }

  // Widget inputTypeModul() {
  //   return Container(
  //     height: 50,
  //     decoration: const BoxDecoration(
  //         border: Border(
  //             bottom: BorderSide(
  //                 style: BorderStyle.solid, color: Colors.black, width: 0.4))),
  //     child: DropdownSearch(
  //       label: "Type Modul",
  //       mode: Mode.MENU,
  //       items: ["ENT", "INQ", "PRO"],
  //       // onChanged: (value) {
  //       //   mataUang = value["CODD_DESC"];
  //       //   idMataUang = value["CODD_VALU"];
  //       // },
  //       // popupItemBuilder: (context, item, isSelected) => ListTile(
  //       //   title: Text(""),
  //       // ),
  //       dropdownBuilder: (context, selectedItem) => Text("Pilih Type Modul"),
  //       dropdownSearchDecoration: const InputDecoration(
  //           border: InputBorder.none, filled: true, fillColor: Colors.white),
  //       validator: (value) {
  //         if (value == "Pilih Type Modul") {
  //           return "Type Modul masih kosong !";
  //         }
  //       },
  //     ),
  //   );
  // }

  fncSaveData() {
    HttpPengguna.saveSubmenu(idMenu, namaSubmenu).then((value) {
      if (value.status == true) {
        showDialog(
            context: context, builder: (context) => const ModalSaveSuccess());
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
            width: screenWidth * 0.73,
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
                      Text("Tambah SubMenu",
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
                                      width: 500,
                                      child: Column(children: [
                                        inputIDMenu(),
                                        const SizedBox(height: 20),
                                        inputIDSubMenu(),
                                      ])),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  SizedBox(
                                      width: 500,
                                      child: Column(children: [
                                        inputNameSubmenu(),
                                        const SizedBox(height: 70),
                                        // inputTypeModul(),
                                        // const SizedBox(height: 20),
                                      ])),
                                ])))),
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
