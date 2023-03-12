// ignore_for_file: missing_return, deprecated_member_use, avoid_print
import 'dart:convert';

import 'package:flutter_web_course/models/http_barang.dart';
import 'package:flutter_web_course/models/http_biaya.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:intl/intl.dart';

class BiayaForm extends StatefulWidget {
  const BiayaForm({Key key}) : super(key: key);

  @override
  State<BiayaForm> createState() => _BiayaFormState();
}

class _BiayaFormState extends State<BiayaForm> {
  String namaBiaya;
  String idJenisBiaya;
  String jenisBiaya;
  String nominal;

  List<Map<String, dynamic>> listBiaya = [];

  void getJenisBiaya() async {
    var response = await http.get(Uri.parse("$urlAddress/setup/jenis-biaya"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listBiaya = data;
    });
  }

  @override
  void initState() {
    getJenisBiaya();
    super.initState();
  }

  Widget inputIdBiaya() {
    return TextFormField(
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'ID Biaya',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      initialValue: "Auto Generate",
    );
  }

  Widget inputNamaBiaya() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        label: Text('Nama Biaya', style: TextStyle(color: Colors.red)),
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      initialValue: namaBiaya ?? '',
      onChanged: ((value) {
        namaBiaya = value;
      }),
      validator: (value) {
        if (value.isEmpty) {
          return "Nama Biaya masih kosong !";
        }
      },
    );
  }

  Widget inputJenisBiaya() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        label: "Jenis Biaya",
        mode: Mode.MENU,
        items: listBiaya,
        onChanged: (value) {
          idJenisBiaya = value['CODD_VALU'];
          jenisBiaya = value['CODD_DESC'];
        },
        selectedItem: "Pilih Jenis Biaya",
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['CODD_DESC'].toString()),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
            jenisBiaya ?? "Pilih Jenis Biaya",
            style: TextStyle(
                color: jenisBiaya == null ? Colors.red : Colors.black)),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
        validator: (value) {
          if (value == "Pilih Jenis Biaya") {
            return "Jenis Biaya masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputNominalBiaya() {
    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        label: Text('Nominal Biaya', style: TextStyle(color: Colors.red)),
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      onChanged: (value) {
        nominal = value;
      },
      initialValue: nominal ?? '0',
      validator: (value) {
        if (value.isEmpty) {
          return "Nominal Biaya masih kosong !";
        }
      },
    );
  }

  fncSaveData() async {
    var response1 = await http
        .get(Uri.parse("$urlAddress/finance/biaya/biaya/get-id"), headers: {
      'pte-token': kodeToken,
    });
    dynamic body1 = json.decode(response1.body);
    String noBiaya = body1['idBiaya'];

    HttpBiaya.saveBiaya(
      noBiaya,
      namaBiaya,
      idJenisBiaya,
      nominal == null
          ? (nominal == '0' ? nominal : '0')
          : nominal.replaceAll(',', ''),
    ).then((value) {
      if (value.status == true) {
        showDialog(
            context: context, builder: (context) => const ModalSaveSuccess());

        menuController.changeActiveitemTo('Master Biaya');
        navigationController.navigateTo('/setting/master-biaya');
      } else {
        showDialog(
            context: context, builder: (context) => const ModalSaveFail());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

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
                      'Tambah Data Baru',
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
                  if (formKey.currentState.validate()) {
                    fncSaveData();
                  } else {
                    return null;
                  }
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
                  menuController.changeActiveitemTo('Master Biaya');
                  navigationController.navigateTo('/setting/master-biaya');
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 520,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            inputIdBiaya(),
                            const SizedBox(height: 8),
                            inputNamaBiaya(),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      SizedBox(
                        width: 520,
                        child: Column(
                          children: [
                            inputJenisBiaya(),
                            const SizedBox(height: 8),
                            inputNominalBiaya(),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
