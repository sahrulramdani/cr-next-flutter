// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter_web_course/constants/dummy_akses_menu.dart';
import 'package:flutter_web_course/models/http_grup_menu.dart';
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

class ModalEditGrupUser extends StatefulWidget {
  final String idGrup;
  const ModalEditGrupUser({
    Key key,
    @required this.idGrup,
  }) : super(key: key);

  @override
  State<ModalEditGrupUser> createState() => _ModalEditGrupUserState();
}

class _ModalEditGrupUserState extends State<ModalEditGrupUser> {
  List<Map<String, dynamic>> listMenuAkses = [];
  List<Map<String, dynamic>> allListMenuAkses = [];
  List<Map<String, dynamic>> listTypeModul = [];
  List<Map<String, dynamic>> detailSaveMenu = [];

  String idGrup;
  String namaGrup;
  String statusGrup;
  String keterangan;
  String codeModul = "";
  String namaModul = "Semua";
  bool enableSwitch = false;

  void getHeaderDetail() async {
    var id = widget.idGrup;
    var response =
        await http.get(Uri.parse("$urlAddress/menu/grup-user/detail/$id"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      idGrup = data[0]['KDXX_GRUP'];
      namaGrup = data[0]['NAMA_GRUP'];
      keterangan = data[0]['KETERANGAN'];
      statusGrup = data[0]['STAS_GRUP'] == '1' ? 'Aktif' : 'Tidak Aktif';
    });
  }

  void getMenuAll() async {
    var id = widget.idGrup;
    var response =
        await http.get(Uri.parse("$urlAddress/menu/grup-user/detail/menu/$id"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    for (var i = 0; i < data.length; i++) {
      var access = {
        "PROC_CODE": data[i]["PROG_KODE"],
        "MDUL_CODE": data[i]["MDUL_CODE"],
        "MENU_NAME": data[i]["MENU_NAME"],
        "PATH": data[i]["PATH"],
        "TYPE_MDUL": data[i]["TYPE_MDUL"],
        "RIGHT_AUTH": data[i]["RIGHT_AUTH"],
        "AUTH_ADDX": data[i]["AUTH_ADDX"],
        "AUTH_EDIT": data[i]["AUTH_EDIT"],
        "AUTH_DELT": data[i]["AUTH_DELT"],
        "AUTH_INQU": data[i]["AUTH_INQU"],
        "AUTH_PRNT": data[i]["AUTH_PRNT"],
        "AUTH_EXPT": data[i]["AUTH_EXPT"],
        "ACCS_ADDX": data[i]["ACCS_ADDX"] == '1' ? true : false,
        "ACCS_EDIT": data[i]["ACCS_EDIT"] == '1' ? true : false,
        "ACCS_DELT": data[i]["ACCS_DELT"] == '1' ? true : false,
        "ACCS_INQU": data[i]["ACCS_INQU"] == '1' ? true : false,
        "ACCS_PRNT": data[i]["ACCS_PRNT"] == '1' ? true : false,
        "ACCS_EXPT": data[i]["ACCS_EXPT"] == '1' ? true : false,
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
  }

  @override
  void initState() {
    super.initState();
    getHeaderDetail();
    getMenuAll();
    getTypeModul();
  }

  Widget inputIdGrup() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'ID Grup',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      readOnly: true,
      initialValue: idGrup ?? '',
    );
  }

  Widget inputStatusGrup() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Status Grup",
        mode: Mode.MENU,
        items: const ["Aktif", "Tidak Aktif"],
        onChanged: (value) {
          if (value == "Aktif") {
            statusGrup = 'Aktif';
          } else {
            statusGrup = 'Tidak Aktif';
          }
        },
        selectedItem: statusGrup ?? "Pilih Status Grup",
        dropdownSearchDecoration: const InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == "Pilih Status Grup") {
            return "Status Grup masih kosong !";
          }
        },
      ),
    );
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
          listMenuAkses[i]['ACCS_ADDX'] = true;
        }
        if (listMenuAkses[i]['AUTH_EDIT'] == '1') {
          listMenuAkses[i]['ACCS_EDIT'] = true;
        }
        if (listMenuAkses[i]['AUTH_DELT'] == '1') {
          listMenuAkses[i]['ACCS_DELT'] = true;
        }
        if (listMenuAkses[i]['AUTH_INQU'] == '1') {
          listMenuAkses[i]['ACCS_INQU'] = true;
        }
        if (listMenuAkses[i]['AUTH_PRNT'] == '1') {
          listMenuAkses[i]['ACCS_PRNT'] = true;
        }
        if (listMenuAkses[i]['AUTH_PRNT'] == '1') {
          listMenuAkses[i]['ACCS_EXPT'] = true;
        }
        listMenuAkses[i]['CEKX_ROWS'] = true;
      });
    }
  }

  fncUncheckAll() {
    for (var i = 0; i < listMenuAkses.length; i++) {
      setState(() {
        if (listMenuAkses[i]['AUTH_ADDX'] == '1') {
          listMenuAkses[i]['ACCS_ADDX'] = false;
        }
        if (listMenuAkses[i]['AUTH_EDIT'] == '1') {
          listMenuAkses[i]['ACCS_EDIT'] = false;
        }
        if (listMenuAkses[i]['AUTH_DELT'] == '1') {
          listMenuAkses[i]['ACCS_DELT'] = false;
        }
        if (listMenuAkses[i]['AUTH_INQU'] == '1') {
          listMenuAkses[i]['ACCS_INQU'] = false;
        }
        if (listMenuAkses[i]['AUTH_PRNT'] == '1') {
          listMenuAkses[i]['ACCS_PRNT'] = false;
        }
        if (listMenuAkses[i]['AUTH_PRNT'] == '1') {
          listMenuAkses[i]['ACCS_EXPT'] = false;
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
            listMenuAkses[i]['ACCS_ADDX'] = true;
          }
          if (listMenuAkses[i]['AUTH_EDIT'] == '1') {
            listMenuAkses[i]['ACCS_EDIT'] = true;
          }
          if (listMenuAkses[i]['AUTH_DELT'] == '1') {
            listMenuAkses[i]['ACCS_DELT'] = true;
          }
          if (listMenuAkses[i]['AUTH_INQU'] == '1') {
            listMenuAkses[i]['ACCS_INQU'] = true;
          }
          if (listMenuAkses[i]['AUTH_PRNT'] == '1') {
            listMenuAkses[i]['ACCS_PRNT'] = true;
          }
          if (listMenuAkses[i]['AUTH_PRNT'] == '1') {
            listMenuAkses[i]['ACCS_EXPT'] = true;
          }
          listMenuAkses[i]['CEKX_ROWS'] = true;
        });
      } else if (id == listMenuAkses[i]['PROC_CODE'] &&
          listMenuAkses[i]['CEKX_ROWS'] == true) {
        setState(() {
          if (listMenuAkses[i]['AUTH_ADDX'] == '1') {
            listMenuAkses[i]['ACCS_ADDX'] = false;
          }
          if (listMenuAkses[i]['AUTH_EDIT'] == '1') {
            listMenuAkses[i]['ACCS_EDIT'] = false;
          }
          if (listMenuAkses[i]['AUTH_DELT'] == '1') {
            listMenuAkses[i]['ACCS_DELT'] = false;
          }
          if (listMenuAkses[i]['AUTH_INQU'] == '1') {
            listMenuAkses[i]['ACCS_INQU'] = false;
          }
          if (listMenuAkses[i]['AUTH_PRNT'] == '1') {
            listMenuAkses[i]['ACCS_PRNT'] = false;
          }
          if (listMenuAkses[i]['AUTH_PRNT'] == '1') {
            listMenuAkses[i]['ACCS_EXPT'] = false;
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
          codeModul = value['CODD_VALU'];
          namaModul = value['CODD_DESC'];
        },
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC']),
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
      if (listMenuAkses[i]['ACCS_ADDX'] == true ||
          listMenuAkses[i]['ACCS_EDIT'] == true ||
          listMenuAkses[i]['ACCS_DELT'] == true ||
          listMenuAkses[i]['ACCS_INQU'] == true ||
          listMenuAkses[i]['ACCS_PRNT'] == true ||
          listMenuAkses[i]['ACCS_EXPT'] == true) {
        var tagihan = {
          '"KDXX_GRUP"': '"$idGrup"',
          '"PROC_CODE"': '"${listMenuAkses[i]['PROC_CODE']}"',
          '"ACCS_ADDX"': '"${listMenuAkses[i]['ACCS_ADDX']}"',
          '"ACCS_EDIT"': '"${listMenuAkses[i]['ACCS_EDIT']}"',
          '"ACCS_DELT"': '"${listMenuAkses[i]['ACCS_DELT']}"',
          '"ACCS_INQU"': '"${listMenuAkses[i]['ACCS_INQU']}"',
          '"ACCS_PRNT"': '"${listMenuAkses[i]['ACCS_PRNT']}"',
          '"ACCS_EXPT"': '"${listMenuAkses[i]['ACCS_EXPT']}"',
        };
        detailSaveMenu.add(tagihan);
      }
    }

    if (detailSaveMenu.isEmpty) {
      showDialog(
          context: context,
          builder: (context) =>
              const ModalInfo(deskripsi: "Tidak ada program yang dipilih"));
      return null;
    }

    HttpGrupMenu.updateGrupMenu(
      idGrup,
      namaGrup,
      keterangan ?? '-',
      statusGrup == 'Aktif' ? '1' : '0',
      '$detailSaveMenu',
    ).then((value) {
      if (value.status == true) {
        showDialog(
            context: context, builder: (context) => const ModalSaveSuccess());

        menuController.changeActiveitemTo('Grup User');
        navigationController.navigateTo('/setting/grup-user');
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
                      Text('Edit Grup User Marketing',
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
                                inputIdGrup(),
                                const SizedBox(height: 8),
                                inputKeterangan()
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
                                inputNamaGrup(),
                                const SizedBox(height: 8),
                                inputStatusGrup()
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
                          height: 0.4 * screenHeight,
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
                                            value: e['ACCS_ADDX'],
                                            activeColor: Colors.green,
                                            onChanged: (bool value) {
                                              setState(() {
                                                e['ACCS_ADDX'] =
                                                    !e['ACCS_ADDX'];
                                              });
                                            },
                                          )
                                        : const Text(''),
                                  ),
                                  DataCell(
                                    e['AUTH_EDIT'] == '1'
                                        ? Switch(
                                            value: e['ACCS_EDIT'],
                                            activeColor: Colors.green,
                                            onChanged: (bool value) {
                                              setState(() {
                                                e['ACCS_EDIT'] =
                                                    !e['ACCS_EDIT'];
                                              });
                                            },
                                          )
                                        : const Text(''),
                                  ),
                                  DataCell(
                                    e['AUTH_DELT'] == '1'
                                        ? Switch(
                                            value: e['ACCS_DELT'],
                                            activeColor: Colors.green,
                                            onChanged: (bool value) {
                                              setState(() {
                                                e['ACCS_DELT'] =
                                                    !e['ACCS_DELT'];
                                              });
                                            },
                                          )
                                        : const Text(''),
                                  ),
                                  DataCell(
                                    e['AUTH_INQU'] == '1'
                                        ? Switch(
                                            value: e['ACCS_INQU'],
                                            activeColor: Colors.green,
                                            onChanged: (bool value) {
                                              setState(() {
                                                e['ACCS_INQU'] =
                                                    !e['ACCS_INQU'];
                                              });
                                            },
                                          )
                                        : const Text(''),
                                  ),
                                  DataCell(
                                    e['AUTH_PRNT'] == '1'
                                        ? Switch(
                                            value: e['ACCS_PRNT'],
                                            activeColor: Colors.green,
                                            onChanged: (bool value) {
                                              setState(() {
                                                e['ACCS_PRNT'] =
                                                    !e['ACCS_PRNT'];
                                              });
                                            },
                                          )
                                        : const Text(''),
                                  ),
                                  DataCell(
                                    e['AUTH_PRNT'] == '1'
                                        ? Switch(
                                            value: e['ACCS_EXPT'],
                                            activeColor: Colors.green,
                                            onChanged: (bool value) {
                                              setState(() {
                                                e['ACCS_EXPT'] =
                                                    !e['ACCS_EXPT'];
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
