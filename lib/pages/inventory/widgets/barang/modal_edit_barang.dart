// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:intl/intl.dart';

class ModalEditBarang extends StatefulWidget {
  final String idBarang;
  const ModalEditBarang({Key key, @required this.idBarang}) : super(key: key);

  @override
  State<ModalEditBarang> createState() => _ModalEditBarangState();
}

class _ModalEditBarangState extends State<ModalEditBarang> {
  Widget inputKodeBarang() {
    return TextFormField(
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Kode Barang'),
      onChanged: (value) {},
      initialValue: listBarang[int.parse(widget.idBarang)]['id'],
    );
  }

  Widget inputNamaBarang() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Nama Barang'),
      onChanged: (value) {},
      initialValue: listBarang[int.parse(widget.idBarang)]['nama'],
    );
  }

  Widget inputSatuan() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "Satuan",
        mode: Mode.MENU,
        items: const ["BOX", "BUAH", "LUSIN", "METER", "PAX", "PCS"],
        onChanged: print,
        selectedItem: listBarang[int.parse(widget.idBarang)]['satuan'],
      ),
    );
  }

  Widget inputStokBarang() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Stok Awal Barang'),
      initialValue: listBarang[int.parse(widget.idBarang)]['stok'],
    );
  }

  Widget inputStatusBarang() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "Status Barang",
        mode: Mode.MENU,
        items: const ["Aktif", "Nonaktif"],
        onChanged: print,
        selectedItem: "Aktif",
      ),
    );
  }

  Widget inputHargaBeli() {
    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Harga Beli'),
      initialValue: listBarang[int.parse(widget.idBarang)]['harga_beli'],
    );
  }

  Widget inputHargaJual() {
    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Harga Jual'),
      initialValue: listBarang[int.parse(widget.idBarang)]['harga_jual'],
    );
  }

  Widget inputKeterangan() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Keterangan'),
      initialValue: listBarang[int.parse(widget.idBarang)]['keterangan'],
    );
  }

  fncSaveData() {
    showDialog(
        context: context, builder: (context) => const ModalSaveSuccess());

    menuController.changeActiveitemTo('Barang');
    navigationController.navigateTo('/inventory/barang');
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
                      Text(
                          'Ubah Barang ${listBarang[int.parse(widget.idBarang)]['nama']}',
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
                                inputKodeBarang(),
                                const SizedBox(height: 8),
                                inputNamaBarang(),
                                const SizedBox(height: 8),
                                inputSatuan(),
                                const SizedBox(height: 8),
                                inputStokBarang(),
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
                                inputStatusBarang(),
                                const SizedBox(height: 8),
                                inputHargaBeli(),
                                const SizedBox(height: 8),
                                inputHargaJual(),
                                const SizedBox(height: 8),
                                inputKeterangan(),
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
