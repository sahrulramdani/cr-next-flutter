import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/dummy_ujrah.dart';
import 'package:flutter_web_course/constants/style.dart';

class DetailTransaksiUjrah extends StatelessWidget {
  const DetailTransaksiUjrah({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int x = 1;

    return SizedBox(
      width: screenWidth,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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
                        label: Text('#',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                    DataColumn(
                        label: Text('ID Jamaah',
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
                        label: Text('Nama Jamaah',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                    DataColumn(
                        label: Text('Nama Marketing',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                    DataColumn(
                        label: Text('Tgl Berangkat',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                    DataColumn(
                        label: Text('Fee',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                  ],
                  rows: dummyListUjrahTr.map((data) {
                    return DataRow(cells: [
                      DataCell(Text((x++).toString())),
                      DataCell(Icon(
                        data['status'] == '1'
                            ? Icons.check
                            : Icons.punch_clock_outlined,
                        color:
                            data['status'] == '1' ? Colors.green : Colors.red,
                      )),
                      DataCell(Text(data['id_pelanggan'])),
                      DataCell(Text(data['jenisna'])),
                      DataCell(Text(data['nama_pelanggan'])),
                      DataCell(Text(data['nama_marketing'])),
                      DataCell(Text(data['tanggal_berangkat'])),
                      DataCell(Text(data['ujroh'])),
                    ]);
                  }).toList()),
            ],
          ),
        ),
      ),
    );
  }
}
