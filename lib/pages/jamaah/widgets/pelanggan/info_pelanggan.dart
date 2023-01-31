import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';

class InfoPelanggan extends StatelessWidget {
  const InfoPelanggan({Key key}) : super(key: key);

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
              DataColumn(label: Text('NIK')),
              DataColumn(label: Text(':')),
              DataColumn(label: Text('3275022011680002')),
            ], rows: const [
              DataRow(cells: [
                DataCell(Text('Nama Lengkap')),
                DataCell(Text(':')),
                DataCell(Text('Nanim Sumartini')),
              ]),
              DataRow(cells: [
                DataCell(Text('Jenis Kelamin')),
                DataCell(Text(':')),
                DataCell(Text('P')),
              ]),
              DataRow(cells: [
                DataCell(Text('Tempat Lahir')),
                DataCell(Text(':')),
                DataCell(Text('Subang')),
              ]),
              DataRow(cells: [
                DataCell(Text('Tanggal Lahir')),
                DataCell(Text(':')),
                DataCell(Text('20 November 1968')),
              ]),
              DataRow(cells: [
                DataCell(Text('Alamat')),
                DataCell(Text(':')),
                DataCell(Text('Dusun Simpang RT02/11')),
              ]),
              DataRow(cells: [
                DataCell(Text('Kelurahan')),
                DataCell(Text(':')),
                DataCell(Text('TAMBAKMEKAR')),
              ]),
              DataRow(cells: [
                DataCell(Text('Kecamatan')),
                DataCell(Text(':')),
                DataCell(Text('JALANCAGAK')),
              ]),
              DataRow(cells: [
                DataCell(Text('Kab/Kota')),
                DataCell(Text(':')),
                DataCell(Text('SUBANG')),
              ]),
            ]),
            const SizedBox(width: 10),
            DataTable(columns: const [
              DataColumn(label: Text('Provinsi')),
              DataColumn(label: Text(':')),
              DataColumn(label: Text('JAWA BARAT')),
            ], rows: const [
              DataRow(cells: [
                DataCell(Text('Kode Pos')),
                DataCell(Text(':')),
                DataCell(Text('41281')),
              ]),
              DataRow(cells: [
                DataCell(Text('Telepon')),
                DataCell(Text(':')),
                DataCell(Text('08886637198')),
              ]),
              DataRow(cells: [
                DataCell(Text('Nama Paspor')),
                DataCell(Text(':')),
                DataCell(Text('Belum Tersedia')),
              ]),
              DataRow(cells: [
                DataCell(Text('Nomor Paspor')),
                DataCell(Text(':')),
                DataCell(Text('-')),
              ]),
              DataRow(cells: [
                DataCell(Text('Issued Paspor')),
                DataCell(Text(':')),
                DataCell(Text('-')),
              ]),
              DataRow(cells: [
                DataCell(Text('Expire Paspor')),
                DataCell(Text(':')),
                DataCell(Text('-')),
              ]),
              DataRow(cells: [
                DataCell(Text('User Input')),
                DataCell(Text(':')),
                DataCell(Text('Sahrul Ramdani')),
              ]),
              DataRow(cells: [
                DataCell(Text('Tanggal Input')),
                DataCell(Text(':')),
                DataCell(Text('06-01-2023 15:34')),
              ]),
            ]),
          ],
        ),
      ),
    );
  }
}
