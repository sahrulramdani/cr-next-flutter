// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter_web_course/constants/dummy_akses_menu.dart';
import 'package:flutter_web_course/models/http_grup_menu.dart';
import 'package:flutter_web_course/models/http_pengguna.dart';
import 'package:flutter_web_course/models/http_satuan.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/header_table.dart';
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

class ModalAksesPengguna extends StatefulWidget {
  final String idPengguna;
  final String namaPengguna;
  const ModalAksesPengguna({
    Key key,
    @required this.idPengguna,
    @required this.namaPengguna,
  }) : super(key: key);

  @override
  State<ModalAksesPengguna> createState() => _ModalAksesPenggunaState();
}

class _ModalAksesPenggunaState extends State<ModalAksesPengguna> {
  List<Map<String, dynamic>> listMenuAkses = [];
  List<Map<String, dynamic>> allListMenuAkses = [];
  List<Map<String, dynamic>> listTypeModul = [];
  List<Map<String, dynamic>> detailSaveMenu = [];

  String namaGrup;
  String keterangan;
  String codeModul = "";
  String namaModul = "Semua";
  bool enableSwitch = false;

  void getHeaderDetail() async {
    var id = widget.idPengguna;
    var response = await http
        .get(Uri.parse("$urlAddress/menu/daftar-pengguna/detail/grup/$id"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      namaGrup = data[0]['NAMA_GRUP'];
      keterangan = data[0]['KETERANGAN'];
    });
  }

  void getMenuAll() async {
    var id = widget.idPengguna;
    var response = await http
        .get(Uri.parse("$urlAddress/menu/daftar-pengguna/detail/menu/$id"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    for (var i = 0; i < data.length; i++) {
      var access = {
        "PROC_CODE": data[i]["PROG_CODE"],
        "MDUL_CODE": data[i]["LIST_CODE"],
        "MENU_NAME": data[i]["LIST_NAME"],
        "PATH": data[i]["PATH"],
        "TYPE_MDUL": data[i]["TYPE_MDUL"],
        "RIGHT_AUTH": data[i]["RIGHT_AUTH"],
        "AUTH_ADDX": data[i]["AUTH_ADDX"],
        "AUTH_EDIT": data[i]["AUTH_EDIT"],
        "AUTH_DELT": data[i]["AUTH_DELT"],
        "AUTH_INQU": data[i]["AUTH_INQU"],
        "AUTH_PRNT": data[i]["AUTH_PRNT"],
        "AUTH_EXPT": data[i]["AUTH_EXPT"],
        "ACCU_ADDX": data[i]["ACCU_ADDX"] == '1' ? true : false,
        "ACCU_EDIT": data[i]["ACCU_EDIT"] == '1' ? true : false,
        "ACCU_DELT": data[i]["ACCU_DELT"] == '1' ? true : false,
        "ACCU_INQU": data[i]["ACCU_INQU"] == '1' ? true : false,
        "ACCU_PRNT": data[i]["ACCU_PRNT"] == '1' ? true : false,
        "ACCU_EXPT": data[i]["ACCU_EXPT"] == '1' ? true : false,
        "CEKX_ROWS": false,
      };
      listMenuAkses.add(access);
      allListMenuAkses.add(access);
    }

    setState(() {});
  }

  void getTypeModul() async {
    var response = await http.get(Uri.parse("$urlAddress/menu/type-menu/all"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listTypeModul = data;
    });

    var semua = {
      "MDUL_CODE": "",
      "MENU_NAME": "Semua",
    };

    listTypeModul.add(semua);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getHeaderDetail();
    getMenuAll();
    getTypeModul();
  }

  Widget inputNamaGrup() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Nama Grup',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: ((value) {
        namaGrup = value;
      }),
      readOnly: true,
      initialValue: namaGrup ?? '',
      validator: (value) {
        if (value.isEmpty) {
          return "Nama Grup masih kosong !";
        }
      },
    );
  }

  Widget inputKeterangan() {
    return TextFormField(
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Keterangan',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: ((value) {
        keterangan = value;
      }),
      initialValue: keterangan ?? '',
    );
  }

  Widget cmdCekAll() {
    return ElevatedButton.icon(
      onPressed: () {
        fncCheckAll();
      },
      icon: const Icon(Icons.checklist_outlined),
      label: const Text(
        'Check All',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.green[700],
        elevation: 5,
      ),
    );
  }

  Widget cmdUncekAll() {
    return ElevatedButton.icon(
      onPressed: () {
        fncUncheckAll();
      },
      icon: const Icon(Icons.not_interested_rounded),
      label: const Text(
        'Uncheck All',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.red[800],
        elevation: 5,
      ),
    );
  }

  fncCheckAll() {
    for (var i = 0; i < listMenuAkses.length; i++) {
      setState(() {
        if (listMenuAkses[i]['AUTH_ADDX'] == '1') {
          listMenuAkses[i]['ACCU_ADDX'] = true;
        }
        if (listMenuAkses[i]['AUTH_EDIT'] == '1') {
          listMenuAkses[i]['ACCU_EDIT'] = true;
        }
        if (listMenuAkses[i]['AUTH_DELT'] == '1') {
          listMenuAkses[i]['ACCU_DELT'] = true;
        }
        if (listMenuAkses[i]['AUTH_INQU'] == '1') {
          listMenuAkses[i]['ACCU_INQU'] = true;
        }
        if (listMenuAkses[i]['AUTH_PRNT'] == '1') {
          listMenuAkses[i]['ACCU_PRNT'] = true;
        }
        if (listMenuAkses[i]['AUTH_PRNT'] == '1') {
          listMenuAkses[i]['ACCU_EXPT'] = true;
        }
        listMenuAkses[i]['CEKX_ROWS'] = true;
      });
    }
  }

  fncUncheckAll() {
    for (var i = 0; i < listMenuAkses.length; i++) {
      setState(() {
        if (listMenuAkses[i]['AUTH_ADDX'] == '1') {
          listMenuAkses[i]['ACCU_ADDX'] = false;
        }
        if (listMenuAkses[i]['AUTH_EDIT'] == '1') {
          listMenuAkses[i]['ACCU_EDIT'] = false;
        }
        if (listMenuAkses[i]['AUTH_DELT'] == '1') {
          listMenuAkses[i]['ACCU_DELT'] = false;
        }
        if (listMenuAkses[i]['AUTH_INQU'] == '1') {
          listMenuAkses[i]['ACCU_INQU'] = false;
        }
        if (listMenuAkses[i]['AUTH_PRNT'] == '1') {
          listMenuAkses[i]['ACCU_PRNT'] = false;
        }
        if (listMenuAkses[i]['AUTH_PRNT'] == '1') {
          listMenuAkses[i]['ACCU_EXPT'] = false;
        }
        listMenuAkses[i]['CEKX_ROWS'] = false;
      });
    }
  }

  fncCheckRow(id) {
    for (var i = 0; i < listMenuAkses.length; i++) {
      if (id == listMenuAkses[i]['PROC_CODE'] &&
          listMenuAkses[i]['CEKX_ROWS'] == false) {
        setState(() {
          if (listMenuAkses[i]['AUTH_ADDX'] == '1') {
            listMenuAkses[i]['ACCU_ADDX'] = true;
          }
          if (listMenuAkses[i]['AUTH_EDIT'] == '1') {
            listMenuAkses[i]['ACCU_EDIT'] = true;
          }
          if (listMenuAkses[i]['AUTH_DELT'] == '1') {
            listMenuAkses[i]['ACCU_DELT'] = true;
          }
          if (listMenuAkses[i]['AUTH_INQU'] == '1') {
            listMenuAkses[i]['ACCU_INQU'] = true;
          }
          if (listMenuAkses[i]['AUTH_PRNT'] == '1') {
            listMenuAkses[i]['ACCU_PRNT'] = true;
          }
          if (listMenuAkses[i]['AUTH_PRNT'] == '1') {
            listMenuAkses[i]['ACCU_EXPT'] = true;
          }
          listMenuAkses[i]['CEKX_ROWS'] = true;
        });
      } else if (id == listMenuAkses[i]['PROC_CODE'] &&
          listMenuAkses[i]['CEKX_ROWS'] == true) {
        setState(() {
          if (listMenuAkses[i]['AUTH_ADDX'] == '1') {
            listMenuAkses[i]['ACCU_ADDX'] = false;
          }
          if (listMenuAkses[i]['AUTH_EDIT'] == '1') {
            listMenuAkses[i]['ACCU_EDIT'] = false;
          }
          if (listMenuAkses[i]['AUTH_DELT'] == '1') {
            listMenuAkses[i]['ACCU_DELT'] = false;
          }
          if (listMenuAkses[i]['AUTH_INQU'] == '1') {
            listMenuAkses[i]['ACCU_INQU'] = false;
          }
          if (listMenuAkses[i]['AUTH_PRNT'] == '1') {
            listMenuAkses[i]['ACCU_PRNT'] = false;
          }
          if (listMenuAkses[i]['AUTH_PRNT'] == '1') {
            listMenuAkses[i]['ACCU_EXPT'] = false;
          }
          listMenuAkses[i]['CEKX_ROWS'] = false;
        });
      }
    }
  }

  Widget spacePemisah() {
    return const SizedBox(
      height: 10,
      width: 10,
    );
  }

  Widget selectInput() {
    return SizedBox(
      height: 40,
      width: 200,
      child: DropdownSearch(
        mode: Mode.MENU,
        items: listTypeModul,
        onChanged: (value) {
          codeModul = value['MDUL_CODE'];
          namaModul = value['MENU_NAME'];
        },
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['MENU_NAME']),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaModul ?? "Pilih Modul"),
        selectedItem: namaModul,
      ),
    );
  }

  Widget cmdCari() {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          listMenuAkses = allListMenuAkses
              .where((element) => element['MDUL_CODE'].contains(codeModul))
              .toList();
        });
      },
      icon: const Icon(Icons.manage_search_outlined),
      label: const Text('Cari'),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdCekSpek() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.fact_check_outlined),
      label: const Text('Check Modul'),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget menuButton() => Container(
        height: 32,
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            selectInput(),
            spacePemisah(),
            cmdCari(),
            // spacePemisah(),
            // cmdCekSpek()
          ],
        ),
      );

  fncSaveData() {
    detailSaveMenu = [];

    for (var i = 0; i < listMenuAkses.length; i++) {
      if (listMenuAkses[i]['ACCU_ADDX'] == true ||
          listMenuAkses[i]['ACCU_EDIT'] == true ||
          listMenuAkses[i]['ACCU_DELT'] == true ||
          listMenuAkses[i]['ACCU_INQU'] == true ||
          listMenuAkses[i]['ACCU_PRNT'] == true ||
          listMenuAkses[i]['ACCU_EXPT'] == true) {
        var tagihan = {
          '"USER_IDXX"': '"${widget.idPengguna}"',
          '"PROC_CODE"': '"${listMenuAkses[i]['PROC_CODE']}"',
          '"ACCU_ADDX"': '"${listMenuAkses[i]['ACCU_ADDX']}"',
          '"ACCU_EDIT"': '"${listMenuAkses[i]['ACCU_EDIT']}"',
          '"ACCU_DELT"': '"${listMenuAkses[i]['ACCU_DELT']}"',
          '"ACCU_INQU"': '"${listMenuAkses[i]['ACCU_INQU']}"',
          '"ACCU_PRNT"': '"${listMenuAkses[i]['ACCU_PRNT']}"',
          '"ACCU_EXPT"': '"${listMenuAkses[i]['ACCU_EXPT']}"',
        };
        detailSaveMenu.add(tagihan);
      }
    }

    HttpPengguna.updateAksesPengguna(
      widget.idPengguna,
      '$detailSaveMenu',
    ).then((value) {
      if (value.status == true) {
        showDialog(
            context: context, builder: (context) => const ModalSaveSuccess());

        menuController.changeActiveitemTo('Daftar Pengguna');
        navigationController.navigateTo('/setting/daftar-pengguna');
      } else {
        showDialog(
            context: context, builder: (context) => const ModalSaveFail());
      }
    });
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
                      Text('Edit Akses Pengguna ${widget.namaPengguna}',
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
                                inputNamaGrup(),
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
                                inputKeterangan(),
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
                            cmdCekAll(),
                            const SizedBox(width: 10),
                            cmdUncekAll(),
                            Expanded(child: Container()),
                            menuButton()
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      const SizedBox(height: 10),
                      HeaderTableGrupUser(listMenuAkses: listMenuAkses),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          height: 0.48 * screenHeight,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                              border: TableBorder.all(color: Colors.grey),
                              headingRowHeight: 0,
                              dataRowHeight: 30,
                              headingTextStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gilroy',
                                  fontSize: 16),
                              columnSpacing: 40,
                              columns: const [
                                DataColumn(label: Text('All')),
                                DataColumn(label: Text('Program')),
                                DataColumn(label: Text('Module')),
                                DataColumn(label: Text('Type')),
                                DataColumn(label: Text('ADD')),
                                DataColumn(label: Text('EDIT')),
                                DataColumn(label: Text('DELETE')),
                                DataColumn(label: Text('SELECT')),
                                DataColumn(label: Text('PRINT')),
                                DataColumn(label: Text('EXPORT')),
                              ],
                              rows: listMenuAkses.map((e) {
                                return DataRow(cells: [
                                  DataCell(Checkbox(
                                    value: e['CEKX_ROWS'],
                                    onChanged: (bool value) {
                                      fncCheckRow(e['PROC_CODE']);
                                    },
                                  )),
                                  DataCell(Text(e['MENU_NAME'])),
                                  DataCell(Text(e['MDUL_CODE'])),
                                  DataCell(Text(e['TYPE_MDUL'])),
                                  DataCell(
                                    e['AUTH_ADDX'] == '1'
                                        ? Switch(
                                            value: e['ACCU_ADDX'],
                                            activeColor: Colors.green,
                                            onChanged: (bool value) {
                                              setState(() {
                                                e['ACCU_ADDX'] =
                                                    !e['ACCU_ADDX'];
                                              });
                                            },
                                          )
                                        : const Text(''),
                                  ),
                                  DataCell(
                                    e['AUTH_EDIT'] == '1'
                                        ? Switch(
                                            value: e['ACCU_EDIT'],
                                            activeColor: Colors.green,
                                            onChanged: (bool value) {
                                              setState(() {
                                                e['ACCU_EDIT'] =
                                                    !e['ACCU_EDIT'];
                                              });
                                            },
                                          )
                                        : const Text(''),
                                  ),
                                  DataCell(
                                    e['AUTH_DELT'] == '1'
                                        ? Switch(
                                            value: e['ACCU_DELT'],
                                            activeColor: Colors.green,
                                            onChanged: (bool value) {
                                              setState(() {
                                                e['ACCU_DELT'] =
                                                    !e['ACCU_DELT'];
                                              });
                                            },
                                          )
                                        : const Text(''),
                                  ),
                                  DataCell(
                                    e['AUTH_INQU'] == '1'
                                        ? Switch(
                                            value: e['ACCU_INQU'],
                                            activeColor: Colors.green,
                                            onChanged: (bool value) {
                                              setState(() {
                                                e['ACCU_INQU'] =
                                                    !e['ACCU_INQU'];
                                              });
                                            },
                                          )
                                        : const Text(''),
                                  ),
                                  DataCell(
                                    e['AUTH_PRNT'] == '1'
                                        ? Switch(
                                            value: e['ACCU_PRNT'],
                                            activeColor: Colors.green,
                                            onChanged: (bool value) {
                                              setState(() {
                                                e['ACCU_PRNT'] =
                                                    !e['ACCU_PRNT'];
                                              });
                                            },
                                          )
                                        : const Text(''),
                                  ),
                                  DataCell(
                                    e['AUTH_PRNT'] == '1'
                                        ? Switch(
                                            value: e['ACCU_EXPT'],
                                            activeColor: Colors.green,
                                            onChanged: (bool value) {
                                              setState(() {
                                                e['ACCU_EXPT'] =
                                                    !e['ACCU_EXPT'];
                                              });
                                            },
                                          )
                                        : const Text(''),
                                  ),
                                ]);
                              }).toList(),
                            ),
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
