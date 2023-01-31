// ignore_for_file: deprecated_member_use, missing_return, prefer_interpolation_to_compose_strings

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

class DetailModalUbahHandling extends StatefulWidget {
  const DetailModalUbahHandling({
    Key key,
  }) : super(key: key);

  @override
  State<DetailModalUbahHandling> createState() =>
      _DetailModalUbahHandlingState();
}

class _DetailModalUbahHandlingState extends State<DetailModalUbahHandling> {
  List<Map> objBarang = [];

  int nomor = 0;
  int urut = 1;
  String kodeBarang;
  String namaBarang;
  String jumlah;
  String kantor;

  Widget inputKantor() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      height: 50,
      child: DropdownSearch(
        label: "Dari Kantor",
        mode: Mode.BOTTOM_SHEET,
        items: const [
          "Pusat",
          "Turangga",
          "Tasikmalaya",
          "KPRK Garut",
          "KPRK Tasikmalaya",
          "KPRK Karawang",
          "KPRK Purwakarta",
          "KPRK Cirebon",
        ],
        showSearchBox: true,
        onChanged: (value) {
          setState(() {
            kantor = value;
          });
        },
        selectedItem: kantor ?? "Pilih Kantor",
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
      ),
    );
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
            kodeBarang = value['id'];
            namaBarang = value['nama'];
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
              'Harga Beli : ' +
                  item['harga_beli'] +
                  ' - ' +
                  'Harga Jual : ' +
                  item['harga_jual'],
              style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: Text('Stok : ' + item['stok'] + ' - ' + item['satuan'],
              textAlign: TextAlign.center),
        ),
        dropdownBuilder: (context, selectedItem) => Text(selectedItem != null
            ? selectedItem['nama']
            : "Produk belum Dipilih"),
        validator: (value) {
          if (value == null) {
            return "Produk masih kosong !";
          }
        },
        dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
      ),
    );
  }

  Widget inputJumlah() {
    return TextFormField(
      initialValue: "0",
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Jumlah',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: (value) {
        setState(() {
          jumlah = value;
        });
      },
    );
  }

  fncAddItem() {
    if (namaBarang != null) {
      if (jumlah != null) {
        var obj = [
          {
            "no": nomor,
            "urut": urut,
            "kode_barang": kodeBarang,
            "nama_barang": namaBarang,
            "jumlah": jumlah
          }
        ];

        setState(() {
          objBarang.addAll(obj);
          nomor = nomor + 1;
          urut = urut + 1;
        });
      }
    }
  }

  fncClearAll() {
    setState(() {
      objBarang = [];
      nomor = 0;
      urut = urut + 1;
    });
  }

  // fncSaveData() {
  //   showDialog(
  //       context: context, builder: (context) => const ModalSaveSuccess());

  //   menuController.changeActiveitemTo('Jadwal');
  //   navigationController.navigateTo('/jamaah/jadwal');
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth > 600 ? 800 : 400,
            height: 700,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.corporate_fare_rounded,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      FittedBox(
                        child: Text('Tambah Handling Nanim Sumartini',
                            style: TextStyle(
                                color: myGrey, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          inputKantor(),
                          const SizedBox(height: 8),
                          inputBarang(),
                          const SizedBox(height: 8),
                          inputJumlah(),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  fncClearAll();
                                },
                                icon: const Icon(Icons.clear),
                                label: const Text(
                                  'Clear All',
                                  style: TextStyle(fontFamily: 'Gilroy'),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: myBlue,
                                  shadowColor: Colors.grey,
                                  elevation: 5,
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton.icon(
                                onPressed: () {
                                  fncAddItem();
                                },
                                icon: const Icon(Icons.playlist_add_outlined),
                                label: const Text(
                                  'Tambahkan',
                                  style: TextStyle(fontFamily: 'Gilroy'),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: myBlue,
                                  shadowColor: Colors.grey,
                                  elevation: 5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            child: DataTable(
                              border: TableBorder.all(color: Colors.grey),
                              columns: const [
                                DataColumn(label: Text('No.')),
                                DataColumn(label: Text('Kode Barang')),
                                DataColumn(label: Text('Nama Barang')),
                                DataColumn(label: Text('Jumlah')),
                              ],
                              rows: objBarang.map((e) {
                                return DataRow(cells: [
                                  DataCell(Text(e['urut'].toString())),
                                  DataCell(Text(e['kode_barang'].toString())),
                                  DataCell(Text(e['nama_barang'].toString())),
                                  DataCell(Text(e['jumlah'].toString())),
                                ]);
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) => const ModalSaveSuccess());
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
