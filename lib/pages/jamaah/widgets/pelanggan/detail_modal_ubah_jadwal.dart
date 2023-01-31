// ignore_for_file: deprecated_member_use, missing_return

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:intl/intl.dart';

class DetailModalUbahJadwal extends StatefulWidget {
  const DetailModalUbahJadwal({
    Key key,
  }) : super(key: key);

  @override
  State<DetailModalUbahJadwal> createState() => _DetailModalUbahJadwalState();
}

class _DetailModalUbahJadwalState extends State<DetailModalUbahJadwal> {
  String paket;
  String tarif;
  String berangkat;
  String sisa;
  String hari;

  String tglKeluar;
  String tglExp;
  TextEditingController dateKeluar = TextEditingController();
  TextEditingController dateExp = TextEditingController();

  Widget inputNamaJadwal() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Jadwal",
        items: listJadwalProduk,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              paket = value["paket"] + ' ' + value['jenis'];
              tarif = value['uang'] + '.' + value["tarif"];
              berangkat = value["berangkat"];
              sisa = value["sisa"];
              hari = value["hari"];
            });
            // fncTotal();
          } else {
            setState(() {
              paket = '';
              tarif = '';
              berangkat = '';
              sisa = '';
              hari = '';
            });
            // fncTotal();
          }
        },
        showClearButton: true,
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(
            item['paket'] + ' - ' + item['jenis'] + ' - ' + item['keterangan'],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
              item['uang'] +
                  ' ' +
                  item['tarif'] +
                  ' - ' +
                  'Sisa Seat : ' +
                  item['sisa'],
              style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: Text(item['berangkat'] + ' - ' + item['pulang'],
              textAlign: TextAlign.center),
        ),
        dropdownBuilder: (context, selectedItem) => Text(selectedItem != null
            ? selectedItem['keterangan']
            : "Produk belum Dipilih"),
        validator: (value) {
          if (value == null) {
            return "Jadwal Produk masih kosong !";
          }
        },
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
      ),
    );
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
            height: 500,
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
                        child: Text('Perubahan Jadwal Nanim Sumartini',
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
                        children: [
                          inputNamaJadwal(),
                          const SizedBox(height: 8),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: DataTable(columns: const [
                                  DataColumn(label: Text('Lama')),
                                  DataColumn(label: Text(':')),
                                  DataColumn(label: Text('Umroh Reguler B3')),
                                ], rows: const [
                                  DataRow(cells: [
                                    DataCell(Text('Berangkat')),
                                    DataCell(Text(':')),
                                    DataCell(Text('15 April 2023')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('Masa')),
                                    DataCell(Text(':')),
                                    DataCell(Text('9 Hari')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('Sisa Seat')),
                                    DataCell(Text(':')),
                                    DataCell(Text('15')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('Biaya')),
                                    DataCell(Text(':')),
                                    DataCell(Text('IDR.23,900,000')),
                                  ]),
                                ]),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: DataTable(columns: [
                                  const DataColumn(label: Text('Baru')),
                                  const DataColumn(label: Text(':')),
                                  DataColumn(label: Text(paket ?? '')),
                                ], rows: [
                                  DataRow(cells: [
                                    const DataCell(Text('Berangkat')),
                                    const DataCell(Text(':')),
                                    DataCell(Text(berangkat ?? '')),
                                  ]),
                                  DataRow(cells: [
                                    const DataCell(Text('Masa')),
                                    const DataCell(Text(':')),
                                    DataCell(Text(hari ?? '')),
                                  ]),
                                  DataRow(cells: [
                                    const DataCell(Text('Sisa Seat')),
                                    const DataCell(Text(':')),
                                    DataCell(Text(sisa ?? '')),
                                  ]),
                                  DataRow(cells: [
                                    const DataCell(Text('Biaya')),
                                    const DataCell(Text(':')),
                                    DataCell(Text(tarif ?? '')),
                                  ]),
                                ]),
                              ),
                            ]),
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
