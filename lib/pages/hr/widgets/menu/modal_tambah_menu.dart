// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/models/http_maskapai.dart';
import 'package:flutter_web_course/models/http_pengguna.dart';
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

class ModalTambahMenu extends StatefulWidget {
  // final String idMaskapai;
  // final bool tambah;

  const ModalTambahMenu({Key key}) : super(key: key);

  @override
  State<ModalTambahMenu> createState() => _ModalTambahMenuState();
}

class _ModalTambahMenuState extends State<ModalTambahMenu> {
  String modulecode;
  String modulenama;
  String path;

  @override
  void initState() {
    super.initState();
  }

  Widget inputModuleCode() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      onChanged: ((value) {
        modulecode = value;
      }),
      decoration: const InputDecoration(
        labelText: 'Module Menu',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
    );
  }

  Widget inputModulName() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      onChanged: ((value) {
        modulenama = value;
      }),
      decoration: const InputDecoration(
        labelText: 'Nama Menu',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
    );
  }

  Widget inputPath() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      onChanged: ((value) {
        path = value;
      }),
      decoration: const InputDecoration(
          labelText: 'URL Menu',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white,
          hintText: "/module/namaModule"),
    );
  }

  fncSaveData() {
    // print("MODULE NAME : $modulecode");
    // print("Nama Module : $modulenama");
    // print("PATH : $path");
    HttpPengguna.saveMenu(modulecode, modulenama, path).then((value) {
      if (value.status == true) {
        showDialog(
            context: context, builder: (context) => const ModalSaveSuccess());
        menuController.changeActiveitemTo('Daftar Menu');
        navigationController.navigateTo('/setting/daftar-menu');
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
                      Text("Tambah Menu",
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
                                        inputModuleCode(),
                                        const SizedBox(height: 20),
                                        inputModulName(),
                                        // const SizedBox(height: 20),
                                      ])),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  SizedBox(
                                      width: 500,
                                      child: Column(children: [
                                        inputPath(),
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
