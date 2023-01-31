import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';

class InfoPaket extends StatelessWidget {
  const InfoPaket({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DataTable(columns: const [
              DataColumn(label: Text('ID Jadwal')),
              DataColumn(label: Text(':')),
              DataColumn(label: Text('JU01101122001')),
            ], rows: const [
              DataRow(cells: [
                DataCell(Text('Berangkat')),
                DataCell(Text(':')),
                DataCell(Text('20 April 2023')),
              ]),
              DataRow(cells: [
                DataCell(Text('Pulang')),
                DataCell(Text(':')),
                DataCell(Text('31 April 2023')),
              ]),
              DataRow(cells: [
                DataCell(Text('Paket')),
                DataCell(Text(':')),
                DataCell(Text('Umroh Reguler B3')),
              ]),
              DataRow(cells: [
                DataCell(Text('Biaya')),
                DataCell(Text(':')),
                DataCell(Text('27,900,000')),
              ]),
            ]),
            const SizedBox(width: 10),
            DataTable(columns: const [
              DataColumn(label: Text('Mata Uang')),
              DataColumn(label: Text(':')),
              DataColumn(label: Text('IDR')),
            ], rows: const [
              DataRow(cells: [
                DataCell(Text('Keterangan')),
                DataCell(Text(':')),
                DataCell(Text('Reguler * 5, 11 Hari')),
              ]),
              DataRow(cells: [
                DataCell(Text('User Input')),
                DataCell(Text(':')),
                DataCell(Text('Sahrul Ramdani')),
              ]),
              DataRow(cells: [
                DataCell(Text('Tanggal Input')),
                DataCell(Text(':')),
                DataCell(Text('05-01-2023 17:35')),
              ]),
            ]),
          ],
        ),
      ),
    );
  }
}
