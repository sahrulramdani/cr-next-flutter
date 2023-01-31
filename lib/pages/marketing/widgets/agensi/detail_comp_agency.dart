import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy_marketing.dart';

class DetailCompAgency extends StatefulWidget {
  final String idAgency;

  const DetailCompAgency({Key key, @required this.idAgency}) : super(key: key);

  @override
  State<DetailCompAgency> createState() => _DetailCompAgencyState();
}

class _DetailCompAgencyState extends State<DetailCompAgency> {
  // void getDetail() async {
  //   String id = widget.idAgency;
  //   var response = await http
  //       .get(Uri.parse("$urlAddress/marketing/agency/detail/$id"), headers: {
  //     'pte-token': kodeToken,
  //   });
  //   List<Map<String, dynamic>> dataAgen =
  //       List.from(json.decode(response.body) as List);
  //   setState(() {
  //     detailAgency = dataAgen;
  //   });
  // }

  @override
  void initState() {
    // getDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> detailAgency = dummyMarketingTable
        .where(((element) => element['id_marketing']
            .toString()
            .toUpperCase()
            .contains(widget.idAgency.toUpperCase())))
        .toList();

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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/profile.jpg'),
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
                        DataCell(Text(data['id_marketing'])),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Nama Lengkap')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['nama_lengkap'])),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Nomor Identitas')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['identitas'].toString())),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Jenis Kelamin')),
                        const DataCell(Text(':')),
                        DataCell(Text(
                            data['jenis_kelamin'] == 'P' ? 'Pria' : 'Wanita')),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Alamat')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['mr_alamat'])),
                      ]),
                      const DataRow(cells: [
                        DataCell(Text('Tempat, Tanggal Lahir')),
                        DataCell(Text(':')),
                        DataCell(Text('SUBANG, 20 Januari 1972')),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Periode Jamaah')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['periode_pelanggan'].toString())),
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
                        DataCell(Text(data['kelurahan'])),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Kecamatan')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['kecamatan'])),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Kab / Kota')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['kabupaten'])),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Provinsi')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['provinsi'])),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('First Level')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['level'])),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Leader')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['nama_leader'] ?? '-')),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Nama Lengkap')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['nama_lengkap'])),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Tanggal Bergabung')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['tanggal_gabung'].toString())),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Status')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['status_aktif'] == 'a'
                            ? 'Aktif'
                            : 'Tidak Aktif')),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Kantor')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['nama_kantor'])),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Fee Level')),
                        const DataCell(Text(':')),
                        DataCell(Text(data['mk'])),
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
