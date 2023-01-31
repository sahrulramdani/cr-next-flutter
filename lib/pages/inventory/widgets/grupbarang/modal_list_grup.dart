// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/pages/inventory/widgets/detail_table_riwayat.dart';
import 'package:flutter_web_course/pages/inventory/widgets/grupbarang/list_grup_barang_table.dart';
import 'package:flutter_web_course/pages/inventory/widgets/grupbarang/modal_tambah_barang_grup.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
// import 'package:pattern_formatter/pattern_formatter.dart';
// import 'package:intl/intl.dart';

class ModalListGrup extends StatefulWidget {
  final String namaGrup;
  const ModalListGrup({Key key, @required this.namaGrup}) : super(key: key);

  @override
  State<ModalListGrup> createState() => _ModalListGrupState();
}

class _ModalListGrupState extends State<ModalListGrup> {
  List<Map<String, dynamic>> listBarangPadaGrup = listBarangGrup;

  getList() {
    setState(() {
      listBarangPadaGrup = listBarangGrup;
    });
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  Widget spacePemisah() {
    return const SizedBox(
      height: 10,
      width: 10,
    );
  }

  Widget cmdTambah() {
    return ElevatedButton.icon(
      onPressed: () async {
        showDialog(
            context: context,
            builder: (context) => ModalTambahBarangGrup(
                  namaGrup: widget.namaGrup,
                ));
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

  Widget cmdSearch() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 38,
      width: screenWidth > 400 ? 200 : 100,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        style: const TextStyle(fontFamily: 'Gilroy', fontSize: 14),
        decoration: const InputDecoration(hintText: 'Cari Barang'),
        onChanged: (value) {
          if (value == '') {
            listBarangPadaGrup = listBarangGrup;
          } else {
            setState(() {
              listBarangPadaGrup = listBarangGrup
                  .where((element) => element['grup'].contains(value))
                  .toList();
            });
          }
        },
      ),
    );
  }

  Widget menuButton() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: 40,
        child: Row(
          children: [
            cmdTambah(),
            spacePemisah(),
            cmdSearch(),
          ],
        ),
      );

  fncSaveData() {
    showDialog(
        context: context, builder: (context) => const ModalSaveSuccess());

    menuController.changeActiveitemTo('Grup Barang');
    navigationController.navigateTo('/inventory/grup-barang');
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
            width: screenWidth * 0.81,
            height: 700,
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
                      FittedBox(
                        child: Text('Kelola Item Grup ${widget.namaGrup}',
                            style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                menuButton(),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            ListGrupBarangTable(
                              namaGrup: widget.namaGrup,
                              listBarangGrupTable: listBarangPadaGrup,
                            ),
                          ],
                        )),
                  ),
                ),
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
