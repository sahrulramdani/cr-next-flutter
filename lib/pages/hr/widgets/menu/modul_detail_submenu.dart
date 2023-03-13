// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print, must_be_immutable, unrelated_type_equality_checks, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter_web_course/models/http_pengguna.dart';
import 'package:flutter_web_course/pages/hr/widgets/menu/header_table_submenu.dart';
import 'package:flutter_web_course/pages/hr/widgets/menu/modal_listmenu.dart';
import 'package:flutter_web_course/pages/hr/widgets/menu/modal_tambah_submenu.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';

class ButtonEdit extends StatelessWidget {
  String idSubmenu;
  String namaSubmenu;
  ButtonEdit({Key key, @required this.idSubmenu, @required this.namaSubmenu})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.edit_outlined,
        color: myBlue,
      ),
      onPressed: () {
        // Navigator.pop();
        showDialog(
          context: context,
          builder: (context) => ModalListMenu(
            idlistMenu: idSubmenu,
            namalistMenu: namaSubmenu,
          ),
        );
      },
    );
  }
}

class ModalDetailSubmenu extends StatefulWidget {
  final String idMenu;
  final String namaMenu;
  // final bool tambah;

  const ModalDetailSubmenu(
      {Key key, @required this.idMenu, @required this.namaMenu})
      : super(key: key);

  @override
  State<ModalDetailSubmenu> createState() => _ModalDetailSubmenuState();
}

class _ModalDetailSubmenuState extends State<ModalDetailSubmenu> {
  String idMenu;
  String namaModul;
  List<Map<String, dynamic>> listSubmenu = [];

  void getModuleAll() async {
    // print(widget.idMenu);
    var response = await http.get(Uri.parse(
        "$urlAddress/menu/daftar-submenu/submenuByMenu/${widget.idMenu}"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      if (data.isNotEmpty) {
        listSubmenu = data;
        idMenu = data[0]['MDUL_CODE'].toString();
        namaModul = widget.namaMenu.toString();
      }
    });
  }

  @override
  void initState() {
    getModuleAll();
    super.initState();
  }

  Widget cmdTambah(context) {
    return ElevatedButton.icon(
      onPressed: () async {
        showDialog(
            context: context,
            builder: (context) => ModalTambahSubmenu(idMenu: idMenu));
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
      initialValue: "$idMenu" ?? " ",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      // onChanged: ((value) {
      //   namaMaskapai = value;
      // }),
      decoration: const InputDecoration(
        labelText: 'Kode Menu',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      readOnly: true,
    );
  }

  Widget inputModulMenu() {
    return TextFormField(
      initialValue: "$namaModul" ?? " ",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      // onChanged: ((value) {
      //   namaMaskapai = value;
      // }),
      decoration: const InputDecoration(
        labelText: 'Nama Modul',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      readOnly: true,
    );
  }

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
                      Text("Detail Submenu",
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
                        child: HeaderTableSubmenu(
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
                                  DataColumn(label: Text('ID Submenu')),
                                  DataColumn(label: Text('Nama Submenu')),
                                  DataColumn(label: Text('Action')),
                                ],
                                rows: listSubmenu != 0
                                    ? listSubmenu.map((e) {
                                        return DataRow(cells: [
                                          DataCell(
                                              Text((x++).toString() ?? " ")),
                                          DataCell(
                                              Text(e['SUBMENU_CODE'] ?? " ")),
                                          DataCell(
                                              Text(e['SUBMENU_NAME'] ?? " ")),
                                          DataCell(Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ButtonEdit(
                                                  idSubmenu:
                                                      e['SUBMENU_CODE'] ?? " ",
                                                  namaSubmenu:
                                                      e['SUBMENU_NAME'] ?? " ",
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
                                      ])),
                          ),
                        ),
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
