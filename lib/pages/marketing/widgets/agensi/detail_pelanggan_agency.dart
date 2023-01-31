import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/constants/dummy_pelanggan.dart';

class DetailPelangganAgency extends StatelessWidget {
  String idAgency;
  DetailPelangganAgency({Key key, @required this.idAgency}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listPelangganDummy = dummyPelangganTable
        .where(
            (element) => element['id_marketing'].toString().contains(idAgency))
        .toList();
    int x = 1;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
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
                      label: Text('Cek',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy',
                              fontSize: 16))),
                  DataColumn(
                      label: Text('ID Pelanggan',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy',
                              fontSize: 16))),
                  DataColumn(
                      label: Text('Nama',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy',
                              fontSize: 16))),
                  DataColumn(
                      label: Text('Berangkat',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy',
                              fontSize: 16))),
                  DataColumn(
                      label: Text('Level',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy',
                              fontSize: 16))),
                  DataColumn(
                      label: Text('Daftar Via',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy',
                              fontSize: 16))),
                  DataColumn(
                      label: Text('Jamaah Ke',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy',
                              fontSize: 16))),
                  DataColumn(
                      label: Text('Biaya',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy',
                              fontSize: 16))),
                ],
                rows: listPelangganDummy.map((data) {
                  return DataRow(cells: [
                    DataCell(Text((x++).toString())),
                    DataCell(Icon(
                      data['status_selesai'] == 'a' ? Icons.check : Icons.clear,
                      color: data['status_selesai'] == 'a'
                          ? Colors.green
                          : Colors.red,
                    )),
                    DataCell(Text(data['id_pelanggan'])),
                    DataCell(Text(data['nama_lengkap'])),
                    DataCell(Text(data['tg_berangkat'])),
                    const DataCell(Text('Raudhah')),
                    DataCell(Text(data['sebutan'])),
                    DataCell(Text(x.toString())),
                    DataCell(Text(data['dpe_status'])),
                  ]);
                }).toList()),
          ],
        ),
      ),
    );
  }
}
