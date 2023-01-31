// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy_marketing.dart';

class DetailUplineAgency extends StatefulWidget {
  String idAgency;
  DetailUplineAgency({Key key, @required this.idAgency}) : super(key: key);

  @override
  State<DetailUplineAgency> createState() => _DetailUplineAgencyState();
}

class _DetailUplineAgencyState extends State<DetailUplineAgency> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listDownline = dummyMarketingTable
        .where((element) =>
            element['id_leader'].toString().contains(widget.idAgency))
        .toList();
    int x = 1;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
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
                    label: Text('ID Agency',
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
                    label: Text('Level',
                        style: TextStyle(
                            color: myGrey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            fontSize: 16))),
                DataColumn(
                    label: Text('Periode',
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
                DataColumn(
                    label: Text('Poin',
                        style: TextStyle(
                            color: myGrey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            fontSize: 16))),
                DataColumn(
                    label: Text('Status',
                        style: TextStyle(
                            color: myGrey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            fontSize: 16))),
                DataColumn(
                    label: Text('HP',
                        style: TextStyle(
                            color: myGrey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            fontSize: 16))),
                DataColumn(
                    label: Text('Kantor',
                        style: TextStyle(
                            color: myGrey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            fontSize: 16))),
              ],
              rows: listDownline.map((data) {
                return DataRow(cells: [
                  DataCell(Text((x++).toString())),
                  DataCell(Text(data['id_marketing'])),
                  DataCell(Text(data['nama_lengkap'])),
                  DataCell(Text(data['level'])),
                  DataCell(Text(data['periode_pelanggan'].toString())),
                  DataCell(Text(data['total_pelanggan'].toString())),
                  DataCell(Text(data['poin'].toString())),
                  DataCell(Text(
                      data['status_aktif'] == 'a' ? 'Aktif' : 'Non Aktif')),
                  DataCell(Text(data['telepon'])),
                  DataCell(Text(data['nama_kantor'])),
                ]);
              }).toList()),
          // rows: const [
          //   DataRow(cells: [
          //     DataCell(Text('1')),
          //     DataCell(Text('AGMR00001')),
          //     DataCell(Text('Muhammad Ibrahim')),
          //     DataCell(Text('Raudhah')),
          //     DataCell(Text('2')),
          //     DataCell(Text('8')),
          //     DataCell(Text('0')),
          //     DataCell(Text('Aktif')),
          //     DataCell(Text('086637288392')),
          //     DataCell(Text('Pusat')),
          //   ]),
          //   DataRow(cells: [
          //     DataCell(Text('2')),
          //     DataCell(Text('AGMR00005')),
          //     DataCell(Text('Soleh Hidayat')),
          //     DataCell(Text('Raudhah')),
          //     DataCell(Text('1')),
          //     DataCell(Text('3')),
          //     DataCell(Text('0')),
          //     DataCell(Text('Aktif')),
          //     DataCell(Text('087736471923')),
          //     DataCell(Text('Pusat')),
          //   ])
          // ],
          // )
        ]),
      ),
    );
  }
}
