import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/constants/dummy.dart';

class DetailJadwalPelanggan extends StatelessWidget {
  const DetailJadwalPelanggan({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            DataTable(
              columns: [
                DataColumn(
                    label: Text('No.',
                        style: TextStyle(
                            color: myGrey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            fontSize: 16))),
                DataColumn(
                    label: Text('Nama Pelanggan',
                        style: TextStyle(
                            color: myGrey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            fontSize: 16))),
                DataColumn(
                    label: Text('Jenis Kelamin',
                        style: TextStyle(
                            color: myGrey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            fontSize: 16))),
                DataColumn(
                    label: Text('Alamat',
                        style: TextStyle(
                            color: myGrey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            fontSize: 16))),
              ],
              rows: const [
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('Sanusi')),
                  DataCell(Text('L')),
                  DataCell(Text('Kp Kedung Raya, Bandung')),
                ]),
                DataRow(cells: [
                  DataCell(Text('2')),
                  DataCell(Text('Warsinah')),
                  DataCell(Text('P')),
                  DataCell(Text('Perumnas 2 Garut, Garut')),
                ]),
                DataRow(cells: [
                  DataCell(Text('3')),
                  DataCell(Text('Muhammad Andi')),
                  DataCell(Text('L')),
                  DataCell(Text('Jl Palem Raya No 3')),
                ]),
                DataRow(cells: [
                  DataCell(Text('4')),
                  DataCell(Text('Kurniawan')),
                  DataCell(Text('L')),
                  DataCell(Text('Harapan Jaya 2, Kab Bandung Barat')),
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}
