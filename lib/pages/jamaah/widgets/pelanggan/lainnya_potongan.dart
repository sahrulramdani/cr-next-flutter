// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class LainnyaPotongan extends StatelessWidget {
  const LainnyaPotongan({Key key}) : super(key: key);

  Widget inputTipePotongan() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "Tipe Potongan",
        mode: Mode.MENU,
        items: const [
          "RUPIAH",
          "DOLLAR",
        ],
        onChanged: (value) {},
        selectedItem: "Pilih Refrensi",
      ),
    );
  }

  Widget inputKurs() {
    return TextFormField(
      initialValue: "15,653",
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Kurs Saat Ini',
          hintText: '15,653'),
    );
  }

  Widget inputNominal() {
    return TextFormField(
      textAlign: TextAlign.right,
      onChanged: (value) {},
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Nominal'),
    );
  }

  Widget inputKeterangan() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Keterangan Potongan'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                DataTable(columns: const [
                  DataColumn(label: Text('Biaya Paket')),
                  DataColumn(label: Text(':')),
                  DataColumn(label: Text('28,900,000')),
                ], rows: const [
                  DataRow(cells: [
                    DataCell(Text('Biaya Fasilitas')),
                    DataCell(Text(':')),
                    DataCell(Text('2,000,000')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Biaya Paket Baru')),
                    DataCell(Text(':')),
                    DataCell(Text('0')),
                  ]),
                ]),
                DataTable(columns: const [
                  DataColumn(label: Text('Uang Masuk')),
                  DataColumn(label: Text(':')),
                  DataColumn(label: Text('28,900,000')),
                ], rows: const [
                  DataRow(cells: [
                    DataCell(Text('Estimasi Total')),
                    DataCell(Text(':')),
                    DataCell(Text('28,900,000')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Kurang Bayar')),
                    DataCell(Text(':')),
                    DataCell(Text('0')),
                  ]),
                ]),
              ]),
            ),
            const SizedBox(height: 20),
            inputTipePotongan(),
            const SizedBox(height: 8),
            inputKurs(),
            const SizedBox(height: 8),
            inputNominal(),
            const SizedBox(height: 8),
            inputKeterangan(),
            const SizedBox(height: 8)
          ],
        ),
      ),
    );
  }
}
