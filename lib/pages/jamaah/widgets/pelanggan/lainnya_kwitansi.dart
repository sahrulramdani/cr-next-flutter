import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';

class LainnyaKwitansi extends StatelessWidget {
  const LainnyaKwitansi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: DataTable(
                  border: TableBorder.all(color: Colors.grey),
                  columns: const [
                    DataColumn(label: Text('Uang Masuk : ')),
                    DataColumn(label: Text('28,900,000')),
                    DataColumn(label: Text('Sisa Bayar : ')),
                    DataColumn(label: Text('0')),
                    DataColumn(label: Text('LUNAS')),
                  ],
                  rows: const []),
            ),
            const SizedBox(height: 10),
            const Text('List Kwitansi',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DataTable(border: TableBorder.all(color: Colors.grey), columns: [
              DataColumn(
                  label: Text('No.',
                      style: TextStyle(
                          color: myGrey, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Faktur',
                      style: TextStyle(
                          color: myGrey, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Operasional',
                      style: TextStyle(
                          color: myGrey, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Bayar',
                      style: TextStyle(
                          color: myGrey, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Kas',
                      style: TextStyle(
                          color: myGrey, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Keterangan',
                      style: TextStyle(
                          color: myGrey, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Status Akun',
                      style: TextStyle(
                          color: myGrey, fontWeight: FontWeight.bold)))
            ], rows: const [
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('P1101230001')),
                DataCell(Text('11-01-2023 14:29')),
                DataCell(Text('28,900,000')),
                DataCell(Text('KECIL [Pusat]')),
                DataCell(Text('HANDLING :: PAKET UMROH :: PAKET UMROH')),
                DataCell(Text('Selesai')),
              ])
            ]),
          ],
        ),
      ),
    );
  }
}
