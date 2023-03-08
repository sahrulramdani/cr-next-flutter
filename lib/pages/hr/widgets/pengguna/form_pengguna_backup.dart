// ignore_for_file: missing_return, deprecated_member_use
import 'package:flutter_web_course/constants/dummy_akses_menu.dart';
import 'package:flutter_web_course/models/http_satuan.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/header_table.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:intl/intl.dart';

class GrupUserForm extends StatefulWidget {
  const GrupUserForm({Key key}) : super(key: key);

  @override
  State<GrupUserForm> createState() => _GrupUserFormState();
}

class _GrupUserFormState extends State<GrupUserForm> {
  List<Map<String, dynamic>> listMenuAkses = dummyAksesMenuMarketing;
  String namaGrup;
  String keterangan;
  String codeModul = "Semua";
  String namaModul = "Semua";
  bool enableSwitch = false;

  Widget inputNamaGrup() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Nama Grup',
      ),
      onChanged: ((value) {
        namaGrup = value;
      }),
      validator: (value) {
        if (value.isEmpty) {
          return "Satuan masih kosong !";
        }
      },
    );
  }

  Widget inputKeterangan() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Keterangan',
      ),
      onChanged: ((value) {
        keterangan = value;
      }),
      validator: (value) {
        if (value.isEmpty) {
          return "Satuan masih kosong !";
        }
      },
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
        listMenuAkses[i]['auth_add'] = true;
        listMenuAkses[i]['auth_edit'] = true;
        listMenuAkses[i]['auth_delete'] = true;
        listMenuAkses[i]['auth_print'] = true;
        listMenuAkses[i]['auth_export'] = true;
        listMenuAkses[i]['cek_row'] = true;
      });
    }
  }

  fncUncheckAll() {
    for (var i = 0; i < listMenuAkses.length; i++) {
      setState(() {
        listMenuAkses[i]['auth_add'] = false;
        listMenuAkses[i]['auth_edit'] = false;
        listMenuAkses[i]['auth_delete'] = false;
        listMenuAkses[i]['auth_print'] = false;
        listMenuAkses[i]['auth_export'] = false;
        listMenuAkses[i]['cek_row'] = false;
      });
    }
  }

  fncCheckRow(id) {
    for (var i = 0; i < listMenuAkses.length; i++) {
      if (id == listMenuAkses[i]['id_akses'] &&
          listMenuAkses[i]['cek_row'] == false) {
        setState(() {
          listMenuAkses[i]['auth_add'] = true;
          listMenuAkses[i]['auth_edit'] = true;
          listMenuAkses[i]['auth_delete'] = true;
          listMenuAkses[i]['auth_print'] = true;
          listMenuAkses[i]['auth_export'] = true;
          listMenuAkses[i]['cek_row'] = true;
        });
      } else if (id == listMenuAkses[i]['id_akses'] &&
          listMenuAkses[i]['cek_row'] == true) {
        setState(() {
          listMenuAkses[i]['auth_add'] = false;
          listMenuAkses[i]['auth_edit'] = false;
          listMenuAkses[i]['auth_delete'] = false;
          listMenuAkses[i]['auth_print'] = false;
          listMenuAkses[i]['auth_export'] = false;
          listMenuAkses[i]['cek_row'] = false;
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
        items: const ["Semua", "Marketing", "Jamaah"],
        onChanged: (value) {
          if (value == "Semua") {
            codeModul = '';
          } else if (value == "Marketing") {
            codeModul = 'MRKT';
          } else if (value == "Jamaah") {
            codeModul = 'JMAH';
          }
          namaModul = value;
        },
        selectedItem: namaModul,
      ),
    );
  }

  Widget cmdCari() {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          listMenuAkses = dummyAksesMenuMarketing
              .where((element) => element['module'].contains(codeModul))
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
    // HttpSatuan.saveSatuan(namaSatuan).then((value) {
    //   if (value.status == true) {
    //     showDialog(
    //         context: context, builder: (context) => const ModalSaveSuccess());

    //     menuController.changeActiveitemTo('Grup User');
    //     navigationController.navigateTo('/setting/grup-user');
    //   } else {
    //     showDialog(
    //         context: context, builder: (context) => const ModalSaveFail());
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final screenHeight = MediaQuery.of(context).size.height;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tambah Grup User Baru',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: myBlue),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox(width: 20)),
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
                  minimumSize: const Size(100, 40),
                  shadowColor: Colors.grey,
                  elevation: 5,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  menuController.changeActiveitemTo('Grup User');
                  navigationController.navigateTo('/setting/grup-user');
                },
                icon: const Icon(Icons.cancel),
                label: const Text(
                  'Batal',
                  style: TextStyle(fontFamily: 'Gilroy'),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: myBlue,
                  minimumSize: const Size(100, 40),
                  shadowColor: Colors.grey,
                  elevation: 5,
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: 0.7 * screenHeight,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 525,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                      width: 1080,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 10),
                          cmdCekAll(),
                          const SizedBox(width: 10),
                          cmdUncekAll(),
                          const SizedBox(width: 495),
                          menuButton()
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Akses Menu Permission",
                      style: TextStyle(
                        color: myBlue,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
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
                            columnSpacing: 58,
                            columns: const [
                              DataColumn(label: Text('All')),
                              DataColumn(label: Text('Program')),
                              DataColumn(label: Text('Module')),
                              DataColumn(label: Text('Type')),
                              DataColumn(label: Text('ADD')),
                              DataColumn(label: Text('EDIT')),
                              DataColumn(label: Text('DELETE')),
                              DataColumn(label: Text('PRINT')),
                              DataColumn(label: Text('EXPORT')),
                            ],
                            rows: listMenuAkses.map((e) {
                              return DataRow(cells: [
                                DataCell(Checkbox(
                                  value: e['cek_row'],
                                  onChanged: (bool value) {
                                    fncCheckRow(e['id_akses']);
                                  },
                                )),
                                DataCell(Text(e['nama_menu'])),
                                DataCell(Text(e['module'])),
                                DataCell(Text(e['type'])),
                                DataCell(
                                  Switch(
                                    value: e['auth_add'],
                                    activeColor: Colors.green,
                                    onChanged: (bool value) {
                                      setState(() {
                                        e['auth_add'] = !e['auth_add'];
                                      });
                                    },
                                  ),
                                ),
                                DataCell(
                                  Switch(
                                    value: e['auth_edit'],
                                    activeColor: Colors.green,
                                    onChanged: (bool value) {
                                      setState(() {
                                        e['auth_edit'] = !e['auth_edit'];
                                      });
                                    },
                                  ),
                                ),
                                DataCell(
                                  Switch(
                                    value: e['auth_delete'],
                                    activeColor: Colors.green,
                                    onChanged: (bool value) {
                                      setState(() {
                                        e['auth_delete'] = !e['auth_delete'];
                                      });
                                    },
                                  ),
                                ),
                                DataCell(
                                  Switch(
                                    value: e['auth_print'],
                                    activeColor: Colors.green,
                                    onChanged: (bool value) {
                                      setState(() {
                                        e['auth_print'] = !e['auth_print'];
                                      });
                                    },
                                  ),
                                ),
                                DataCell(
                                  Switch(
                                    value: e['auth_export'],
                                    activeColor: Colors.green,
                                    onChanged: (bool value) {
                                      setState(() {
                                        e['auth_export'] = !e['auth_export'];
                                      });
                                    },
                                  ),
                                ),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
