// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter_web_course/constants/style.dart';

class DetailCompAgency extends StatefulWidget {
  final String idAgency;

  const DetailCompAgency({Key key, @required this.idAgency}) : super(key: key);

  @override
  State<DetailCompAgency> createState() => _DetailCompAgencyState();
}

class _DetailCompAgencyState extends State<DetailCompAgency> {
  List<Map<String, dynamic>> detailAgency = [];

  void getDetail() async {
    String id = widget.idAgency;
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/agency/detail/$id"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataAgen =
        List.from(json.decode(response.body) as List);
    setState(() {
      detailAgency = dataAgen;
    });
  }

  @override
  void initState() {
    getDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> detailAgency = dummyMarketingTable
    //     .where(((element) => element['id_marketing']
    //         .toString()
    //         .toUpperCase()
    //         .contains(widget.idAgency.toUpperCase())))
    //     .toList();

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: detailAgency.map((data) {
          return Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: data['FOTO_AGEN'] != ''
                                ? NetworkImage('$urlAddress/uploads/foto/' +
                                    data['FOTO_AGEN'])
                                : const AssetImage(
                                    'assets/images/NO_IMAGE.jpg'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DataTable(columns: const [
                      DataColumn(label: Text('')),
                      DataColumn(label: Text('')),
                      DataColumn(label: Text('')),
                    ], rows: [
                      DataRow(cells: [
                        const DataCell(Text('ID User')),
                        const DataCell(Text(':')),
                        DataCell(Text(widget.idAgency)),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Nama Lengkap')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['NAMA_LGKP'] ?? '')),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Nomor Identitas')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['NOXX_IDNT'].toString())),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Jenis Kelamin')),
                        const DataCell(Text(':')),
                        DataCell(
                            Text(data['JENS_KLMN'] == 'P' ? 'Pria' : 'Wanita')),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Alamat')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['ALAMAT'])),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Tempat, Tanggal Lahir')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['TMPT_LHIR'] +
                            ', ' +
                            fncGetTanggal(DateFormat("dd-MM-yyyy")
                                .format(DateTime.parse(data['TGLX_LHIR']))))),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Periode Jamaah')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['PERD_JMAH'].toString())),
                      ]),
                    ])
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    DataTable(columns: const [
                      DataColumn(label: Text('')),
                      DataColumn(label: Text('')),
                      DataColumn(label: Text('')),
                    ], rows: [
                      DataRow(cells: [
                        const DataCell(Text('Kelurahan')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['KDXX_KELX'])),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Kecamatan')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['KDXX_KECX'])),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Kab / Kota')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['KDXX_KOTA'])),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Provinsi')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['KDXX_PROV'])),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('First Level')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['FIRST_LVL'])),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Leader')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['UPLINE'] ?? '-')),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Total Jamaah')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['TOTL_JMAH'].toString())),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Tanggal Bergabung')),
                        const DataCell(Text(':')),
                        DataCell(Text(DateFormat("dd-MM-yyyy")
                            .format(DateTime.parse(data['TGLX_GBNG'])))),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Status')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['STATUS_AGEN'])),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Kantor')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['NAMA_KNTR'])),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Fee Level')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['FEE'])),
                      ]),
                    ])
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
