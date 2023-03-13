// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print, non_constant_identifier_names

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

class ModalTambahListMenu extends StatefulWidget {
  final String idSubmenu;
  final String idMenu;
  // final bool tambah;

  const ModalTambahListMenu(
      {Key key, @required this.idSubmenu, @required this.idMenu})
      : super(key: key);

  @override
  State<ModalTambahListMenu> createState() => _ModalTambahListMenuState();
}

class _ModalTambahListMenuState extends State<ModalTambahListMenu> {
  List<Map<String, dynamic>> listTypeMdul = [];
  String typemdul;
  String listName;
  String Path;
  String idSubmenu;
  String idmenu;
  void getTypeMdul() async {
    var response = await http.get(Uri.parse("$urlAddress/menu/getTypeMdul"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      idSubmenu = widget.idSubmenu;
      idmenu = widget.idMenu;
      listTypeMdul = data;
    });
  }

  @override
  void initState() {
    getTypeMdul();
    super.initState();
  }

  Widget inputIdSubMenu() {
    return TextFormField(
      initialValue: "${widget.idSubmenu}",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      onChanged: ((value) {
        idSubmenu = widget.idSubmenu;
      }),
      decoration: const InputDecoration(
        labelText: 'ID Submenu',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      readOnly: true,
    );
  }

  Widget inputIdListMenu() {
    return TextFormField(
      initialValue: "Auto Generate",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      // onChanged: ((value) {
      //   namaMaskapai = value;
      // }),
      decoration: const InputDecoration(
        labelText: 'ID List Menu',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
    );
  }

  Widget inputListName() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      onChanged: ((value) {
        listName = value;
      }),
      decoration: const InputDecoration(
        labelText: 'List Menu Name',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
    );
  }

  Widget inputPATH() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      onChanged: ((value) {
        Path = value;
      }),
      decoration: const InputDecoration(
        labelText: 'Path List Menu',
        hintText: '/namaMenu/namalistmenu',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
    );
  }

  Widget inputTypeModul() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Type Modul",
        mode: Mode.MENU,
        items: listTypeMdul,
        onChanged: (value) {
          typemdul = value["KDXX_TYPE"];
        },
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['KDXX_TYPE'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(typemdul ?? "Pilih Type Modul"),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, fillColor: Colors.white, filled: true),
        validator: (value) {
          if (value == "Pilih Type Modul") {
            return "Type Modul kosong !";
          }
        },
      ),
    );
  }

  fncSaveData() {
    HttpPengguna.savelistmenu(idSubmenu, idmenu, listName, Path, typemdul)
        .then((value) {
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
                      Text("Tambah List Menu",
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
                                        inputIdSubMenu(),
                                        const SizedBox(height: 20),
                                        inputIdListMenu(),
                                        const SizedBox(height: 20),
                                        inputListName(),
                                      ])),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  SizedBox(
                                      width: 500,
                                      child: Column(children: [
                                        inputPATH(),
                                        const SizedBox(height: 20),
                                        inputTypeModul(),
                                        const SizedBox(height: 55),
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
