import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';

class DetailTableRiwayat extends StatelessWidget {
  const DetailTableRiwayat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
        border: TableBorder.all(color: Colors.grey),
        columns: [
          DataColumn(
              label: Text('No.',
                  style: TextStyle(
                      color: myGrey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                      fontSize: 16))),
          DataColumn(
              label: Text('Tanggal',
                  style: TextStyle(
                      color: myGrey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                      fontSize: 16))),
          DataColumn(
              label: Text('Faktur',
                  style: TextStyle(
                      color: myGrey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                      fontSize: 16))),
          DataColumn(
              label: Text('Jenis',
                  style: TextStyle(
                      color: myGrey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                      fontSize: 16))),
          DataColumn(
              label: Text('Qty',
                  style: TextStyle(
                      color: myGrey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                      fontSize: 16))),
          DataColumn(
              label: Text('Stok Awal',
                  style: TextStyle(
                      color: myGrey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                      fontSize: 16))),
          DataColumn(
              label: Text('Stok Akhir',
                  style: TextStyle(
                      color: myGrey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                      fontSize: 16))),
          DataColumn(
              label: Text('Harga',
                  style: TextStyle(
                      color: myGrey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                      fontSize: 16))),
          DataColumn(
              label: Text('Total',
                  style: TextStyle(
                      color: myGrey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                      fontSize: 16))),
        ],
        rows: listRiwayatKeluar.map((data) {
          int x = 1;
          return DataRow(cells: [
            DataCell(Text((x++).toString())),
            DataCell(Text(data['tanggal'])),
            DataCell(Text(data['faktur'])),
            DataCell(Text(data['jenis'])),
            DataCell(Text(data['qty'])),
            DataCell(Text(data['stok_awal'])),
            DataCell(Text(
                (int.parse(data['stok_awal']) - int.parse(data['qty']))
                    .toString())),
            DataCell(Text(data['harga'])),
            DataCell(Text(data['total'])),
          ]);
        }).toList());
  }
}
