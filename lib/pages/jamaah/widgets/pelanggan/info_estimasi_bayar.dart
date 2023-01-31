import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';

class InfoEstimasiBayar extends StatelessWidget {
  const InfoEstimasiBayar({Key key}) : super(key: key);

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
              DataColumn(label: Text('Biaya Paket')),
              DataColumn(label: Text(':')),
              DataColumn(label: Text('28,900,000')),
            ], rows: const [
              DataRow(cells: [
                DataCell(Text('Paspor')),
                DataCell(Text(':')),
                DataCell(Text('Pending Paspor')),
              ]),
              DataRow(cells: [
                DataCell(Text('Keterangan')),
                DataCell(Text(':')),
                DataCell(Text('-')),
              ]),
              DataRow(cells: [
                DataCell(Text('Biaya Fasilitas')),
                DataCell(Text(':')),
                DataCell(Text('2,000,000')),
              ]),
              DataRow(cells: [
                DataCell(Text('Status Handling')),
                DataCell(Text(':')),
                DataCell(Text('Belum')),
              ]),
            ]),
            const SizedBox(width: 10),
            DataTable(columns: const [
              DataColumn(label: Text('Handling')),
              DataColumn(label: Text(':')),
              DataColumn(label: Text('-')),
            ], rows: const [
              DataRow(cells: [
                DataCell(Text('Estimasi Total')),
                DataCell(Text(':')),
                DataCell(Text('30,900,000')),
              ]),
              DataRow(cells: [
                DataCell(Text('Uang Masuk')),
                DataCell(Text(':')),
                DataCell(Text('30,900,000')),
              ]),
              DataRow(cells: [
                DataCell(Text('Status')),
                DataCell(Text(':')),
                DataCell(Text('Lunas')),
              ]),
            ]),
          ],
        ),
      ),
    );
  }
}
