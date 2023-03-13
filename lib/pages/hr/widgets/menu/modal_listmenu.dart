// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print, prefer_const_literals_to_create_immutables, prefer_const_constructors, unrelated_type_equality_checks

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/models/http_maskapai.dart';
import 'package:flutter_web_course/pages/hr/widgets/menu/header_table_listmenu.dart';
import 'package:flutter_web_course/pages/hr/widgets/menu/header_table_submenu.dart';
import 'package:flutter_web_course/pages/hr/widgets/menu/modal_tambah_submenu.dart';
import 'package:flutter_web_course/pages/hr/widgets/menu/model_tambah_listmenu.dart';
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

class ButtonEdit extends StatelessWidget {
  String idSubmenu;
  ButtonEdit({Key key, @required this.idSubmenu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.edit_outlined,
        color: myBlue,
      ),
      onPressed: () {
        // showDialog(
        //     context: context,
        //     builder: (context) =>
        //         ModalDetailSubmenu(idMenu: idMenu)
        //         );
      },
    );
  }
}

class ModalListMenu extends StatefulWidget {
  final String idlistMenu;
  final String namalistMenu;
  // final bool tambah;

  const ModalListMenu(
      {Key key, @required this.idlistMenu, @required this.namalistMenu})
      : super(key: key);

  @override
  State<ModalListMenu> createState() => _ModalListMenuState();
}

class _ModalListMenuState extends State<ModalListMenu> {
  String idSubMenu;
  String namaSubMenu;
  String idmenu;
  List<Map<String, dynamic>> listSubmenu = [];

  void getListMenu() async {
    // print(widget.idMenu);
    var response = await http.get(Uri.parse(
        "$urlAddress/menu/daftar-listmenu/listmenuBySubMenu/${widget.idlistMenu}"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      if (data.isNotEmpty) {
        listSubmenu = data;
        idmenu = data[0]['MDUL_CODE'].toString();
        idSubMenu = data[0]['SUBMENU_CODE'].toString();
        namaSubMenu = widget.namalistMenu.toString();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getListMenu();
  }

  Widget cmdTambah(context) {
    return ElevatedButton.icon(
      onPressed: () async {
        showDialog(
            context: context,
            builder: (context) =>
                ModalTambahListMenu(idSubmenu: idSubMenu, idMenu: idmenu));
      },
      icon: const Icon(Icons.add),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
      label: const Text(
        'Tambah Data',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
    );
  }

  Widget inputKodeMenu() {
    return TextFormField(
      initialValue: "$idSubMenu" ?? " ",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      // onChanged: ((value) {
      //   namaMaskapai = value;
      // }),
      decoration: const InputDecoration(
        labelText: 'ID Submenu',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      readOnly: true,
    );
  }

  Widget inputModulMenu() {
    return TextFormField(
      initialValue: "$namaSubMenu" ?? " ",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      // onChanged: ((value) {
      //   namaMaskapai = value;
      // }),
      decoration: const InputDecoration(
        labelText: 'Nama SubMenu',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      readOnly: true,
    );
  }

  fncSaveData() {}

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();
    int x = 1;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.82,
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
                      Text("Detail ListMenu",
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
                  width: screenWidth,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 510,
                            child: Column(
                              children: [
                                inputKodeMenu(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          SizedBox(
                            width: 510,
                            child: Column(
                              children: [
                                inputModulMenu(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: screenWidth * 0.83,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 5),
                            cmdTambah(context),
                            // const SizedBox(width: 10),
                            // cmdUncekAll(),
                            // Expanded(child: Container()),
                            // menuButton()
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: screenWidth * 0.75,
                        child: HeaderListMenu(
                          listSubmenu: listSubmenu,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: screenWidth * 0.75,
                          height: 0.40 * screenHeight,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                                border: TableBorder.all(color: Colors.grey),
                                headingRowHeight: 0,
                                dataRowHeight: 45,
                                headingTextStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16),
                                columnSpacing: 70,
                                columns: const [
                                  DataColumn(label: Text('No')),
                                  DataColumn(label: Text('ID List Menu')),
                                  DataColumn(label: Text('Nama List Menu')),
                                  DataColumn(label: Text('Type Modul')),
                                  DataColumn(label: Text('Action')),
                                ],
                                rows: listSubmenu != 0
                                    ? listSubmenu.map((e) {
                                        return DataRow(cells: [
                                          DataCell(
                                              Text((x++).toString() ?? " ")),
                                          DataCell(Text(e['LIST_CODE'] ?? " ")),
                                          DataCell(Text(e['LIST_NAME'] ?? " ")),
                                          DataCell(Text(e['TYPE_MDUL'] ?? " ")),
                                          DataCell(Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ButtonEdit(
                                                  idSubmenu:
                                                      e['SUBMENU_CODE'] ?? " ",
                                                ),
                                                // const SizedBox(width: 10),
                                                // ButtonUser(
                                                //     idPengguna: listMenu[index]['USER_IDXX'],
                                                //     namaPengguna: listMenu[index]['USER_IDXX']),
                                              ],
                                            ),
                                          )),
                                        ]);
                                      }).toList()
                                    : DataRow(cells: [
                                        DataCell(Text("")),
                                        DataCell(Text("")),
                                        DataCell(Text("")),
                                        DataCell(Text("")),
                                        DataCell(Text("")),
                                      ])),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                // Expanded(
                //     child: SingleChildScrollView(
                //         scrollDirection: Axis.vertical,
                //         child: SingleChildScrollView(
                //             scrollDirection: Axis.horizontal,
                //             child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 children: [
                //                   SizedBox(
                //                       width: 500,
                //                       child: Column(children: [
                //                         inputKodeMenu(),
                //                         const SizedBox(height: 20),
                //                         inputModulMenu(),
                //                         const SizedBox(height: 20),
                //                       ])),
                //                   const SizedBox(
                //                     width: 40,
                //                   ),
                //                   // SizedBox(
                //                   //     width: 500,
                //                   //     child: Column(children: [
                //                   //       inputPath(),
                //                   //       const SizedBox(height: 20),
                //                   //       inputTypeModul(),
                //                   //       const SizedBox(height: 20),
                //                   //     ])),
                //                 ])))),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // ElevatedButton.icon(
                      //   onPressed: () {
                      //     fncSaveData();
                      //   },
                      //   icon: const Icon(Icons.save),
                      //   label: const Text(
                      //     'Simpan Data',
                      //     style: TextStyle(fontFamily: 'Gilroy'),
                      //   ),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: myBlue,
                      //     shadowColor: Colors.grey,
                      //     elevation: 5,
                      //   ),
                      // ),
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
