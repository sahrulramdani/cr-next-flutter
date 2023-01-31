// ignore_for_file: deprecated_member_use, missing_return, prefer_interpolation_to_compose_strings

import 'package:flutter_web_course/pages/inventory/widgets/grupbarang/modal_list_grup.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';

class ModalTambahBarangGrup extends StatefulWidget {
  final String namaGrup;
  const ModalTambahBarangGrup({Key key, @required this.namaGrup})
      : super(key: key);

  @override
  State<ModalTambahBarangGrup> createState() => _ModalTambahBarangGrupState();
}

class _ModalTambahBarangGrupState extends State<ModalTambahBarangGrup> {
  String kodeBarang;
  String namaBarang;
  String satuan;
  String keterangan;
  TextEditingController qty = TextEditingController();

  Widget inputBarang() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Pilih Barang",
          items: listBarang,
          onChanged: (value) {
            setState(() {
              kodeBarang = value['id'];
              namaBarang = value['nama'];
              satuan = value['satuan'];
              keterangan = value['keterangan'];
            });
          },
          showClearButton: true,
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(
                  item['nama'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    '${'Harga Beli : ' + item['harga_beli']} - Harga Jual : ' +
                        item['harga_jual'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(
                    '${'Stok : ' + item['stok']} - ' + item['satuan'],
                    textAlign: TextAlign.center),
              ),
          dropdownBuilder: (context, selectedItem) => Text(selectedItem != null
              ? selectedItem['nama']
              : "Produk belum Dipilih"),
          validator: (value) {
            if (value == null) {
              return "Produk masih kosong !";
            }
          }),
    );
  }

  Widget inputBanyak() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: qty,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Banyak Barang Dalam Grup'),
    );
  }

  fncSaveData(grup) {
    if (kodeBarang != null) {
      if (qty.text != '') {
        var obj = [
          {
            "kode_barang": kodeBarang,
            "nama_barang": namaBarang,
            "qty": qty.text,
            "satuan": satuan,
            "keterangan": keterangan
          }
        ];

        listBarangGrup.addAll(obj);

        Navigator.pop(context);
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) => ModalListGrup(namaGrup: grup));
      }
    }
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
                          fncSaveData(widget.namaGrup);
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
