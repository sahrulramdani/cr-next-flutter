// ignore_for_file: deprecated_member_use, missing_return, prefer_interpolation_to_compose_strings, must_be_immutable

import 'dart:convert';

import 'package:flutter_web_course/models/http_grup_barang.dart';
import 'package:flutter_web_course/models/http_grup_handling.dart';
import 'package:flutter_web_course/pages/inventory/widgets/grupbarang/modal_list_grup.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../../../../comp/modal_save_fail.dart';
import '../../../../comp/modal_save_success.dart';
import '../../../../constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';

class ModalTambahBarangHandling extends StatefulWidget {
  String idGrup;
  ModalTambahBarangHandling({Key key, @required this.idGrup}) : super(key: key);

  @override
  State<ModalTambahBarangHandling> createState() =>
      _ModalTambahBarangHandlingState();
}

class _ModalTambahBarangHandlingState extends State<ModalTambahBarangHandling> {
  NumberFormat myformat = NumberFormat.decimalPattern('en_us');
  String kodeBarang;
  String namaBarang;
  String satuan;
  String keterangan;
  String quantity;
  // TextEditingController qty = TextEditingController();
  List<Map<String, dynamic>> listBarang = [];

  void getBarang() async {
    var response = await http
        .get(Uri.parse("$urlAddress/inventory/barang/getAllBarang"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listBarang = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getBarang();
  }

  Widget inputBarang() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      height: 50,
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Pilih Barang",
        items: listBarang,
        onChanged: (value) {
          setState(() {
            kodeBarang = value['KDXX_BRGX'];
            namaBarang = value['NAMA_BRGX'];
            satuan = value['NAMA_STAN'];
            keterangan = value['KETERANGAN'];
          });
        },
        // showClearButton: true,
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(
            item['NAMA_BRGX'],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
              '${'Harga Beli : ' + myformat.format(item['HRGX_BELI'])} - Harga Jual : ' +
                  myformat.format(item['HRGX_JUAL']),
              style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: Text(
              '${'Stok : ' + item['STOK_BRGX'].toString()} - ' +
                  item['NAMA_STAN'],
              textAlign: TextAlign.center),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(namaBarang ?? "Produk belum Dipilih"),
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
        validator: (value) {
          if (kodeBarang == null) {
            return "Produk masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputBanyak() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Banyak Barang Dalam Handling',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: (value) {
        quantity = value;
      },
      initialValue: quantity,
      validator: (value) {
        if (value.isEmpty) {
          return "Jumlah Barang masih kosong !";
        }
      },
    );
  }

  fncSaveData(context) {
    HttpGrupHandling.saveGrupHandlingDetail(
      widget.idGrup,
      kodeBarang,
      quantity,
    ).then((value) {
      if (value.status == true) {
        Navigator.pop(context);

        showDialog(
            context: context, builder: (context) => const ModalSaveSuccess());

        menuController.changeActiveitemTo('Master Handling');
        navigationController.navigateTo('/inventory/master-handling');
      } else {
        showDialog(
            context: context, builder: (context) => const ModalSaveFail());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.5,
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
                      Text('Pilih Barang',
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
                      inputBarang(),
                      const SizedBox(height: 8),
                      inputBanyak(),
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
                          if (formKey.currentState.validate()) {
                            fncSaveData(context);
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
