// ignore_for_file: deprecated_member_use, missing_return, must_be_immutable, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_brace_in_string_interps
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/models/http_barang.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:pattern_formatter/pattern_formatter.dart';
import "package:http/http.dart" as http;

import '../../../../comp/modal_save_fail.dart';

class ModalStokBarang extends StatefulWidget {
  String idBarang;

  ModalStokBarang({Key key, @required this.idBarang}) : super(key: key);

  @override
  State<ModalStokBarang> createState() => _ModalStokBarangState();
}

class _ModalStokBarangState extends State<ModalStokBarang> {
  String kodeBarang;
  String stokBarang;
  String stokAwal;
  String namaBarang;

  void getDetailBarang() async {
    var id = widget.idBarang;
    var response =
        await http.get(Uri.parse("$urlAddress/inventory/barang/getdetail/$id"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      kodeBarang = data[0]['KDXX_BRGX'];
      namaBarang = data[0]['NAMA_BRGX'].toString();
      stokAwal = data[0]['STOK_BRGX'].toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getDetailBarang();
  }

  Widget inputStokBarang() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Stok Baru Barang'),
      onChanged: (value) {
        stokBarang = value;
      },
    );
  }

  fncSaveData() {
    HttpBarang.updateStokBarang(kodeBarang, stokBarang, stokAwal).then((value) {
      if (value.status == true) {
        showDialog(
            context: context, builder: (context) => const ModalSaveSuccess());

        menuController.changeActiveitemTo('Barang');
        navigationController.navigateTo('/inventory/barang');
      } else {
        showDialog(
            context: context, builder: (context) => const ModalSaveFail());
      }
    });
    // print("STOK BARANG : $stokBarang");
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
            height: 220,
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
                      Text("Stok Baru",
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
                      Text("${namaBarang}",
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 10),
                      inputStokBarang(),
                      const SizedBox(height: 8),
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
