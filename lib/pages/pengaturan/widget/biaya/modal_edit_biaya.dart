// ignore_for_file: deprecated_member_use, missing_return, must_be_immutable, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/models/http_barang.dart';
import 'package:flutter_web_course/models/http_biaya.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';

import '../../../../comp/modal_save_fail.dart';

class ModalEditBiaya extends StatefulWidget {
  String idBiaya;
  ModalEditBiaya({Key key, @required this.idBiaya}) : super(key: key);

  @override
  State<ModalEditBiaya> createState() => _ModalEditBiayaState();
}

class _ModalEditBiayaState extends State<ModalEditBiaya> {
  NumberFormat myformat = NumberFormat.decimalPattern('en_us');
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

  void getDetailBiaya() async {
    var id = widget.idBiaya;
    var response =
        await http.get(Uri.parse("$urlAddress/finance/biaya/biaya/detail/$id"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      namaBiaya = data[0]['NAMA_BYAX'];
      jenisBiaya = data[0]['JENIS_BIAYA'];
      idJenisBiaya = data[0]['JENS_BYAX'].toString();
      nominal = myformat.format(data[0]['JMLH_BYAX']);
    });

    print(data);
  }

  @override
  void initState() {
    getDetailBiaya();
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
      initialValue: widget.idBiaya ?? "Auto Generate",
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
          if (jenisBiaya == null) {
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
      initialValue: nominal ?? '0',
      onChanged: (value) {
        nominal = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Nominal Biaya masih kosong !";
        }
      },
    );
  }

  fncSaveData() {
    HttpBiaya.updateBiaya(
      widget.idBiaya,
      namaBiaya,
      idJenisBiaya,
      nominal == '0' ? nominal : nominal.replaceAll(',', ''),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.81,
            height: 400,
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
                      Text('Ubah Biaya',
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
                            width: 525,
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
                            width: 525,
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
                    ),
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
