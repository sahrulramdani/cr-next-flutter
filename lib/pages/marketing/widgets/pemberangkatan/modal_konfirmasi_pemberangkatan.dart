import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ModalKonfirmasiBerangkat extends StatefulWidget {
  String idDaftar;
  ModalKonfirmasiBerangkat({Key key, @required this.idDaftar})
      : super(key: key);

  @override
  State<ModalKonfirmasiBerangkat> createState() =>
      _ModalKonfirmasiBerangkatState();
}

class _ModalKonfirmasiBerangkatState extends State<ModalKonfirmasiBerangkat> {
  List<Map<String, dynamic>> detPel = [];

  void getJamaahPemberangkatan() async {
    var id = widget.idDaftar;
    var response = await http.get(Uri.parse(
        "$urlAddress/marketing/pemberangkatan/detail-jamaah-berangkat/$id"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      detPel = data;
    });
  }

  @override
  void initState() {
    getJamaahPemberangkatan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.8,
            height: 350,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.people_alt_outlined,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      Text('Konfirmasi Pemberangkatan Pelanggan',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ],
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          DataTable(columns: [
                            const DataColumn(label: Text('ID Pelanggan')),
                            const DataColumn(label: Text(':')),
                            DataColumn(
                                label: Text(detPel.isNotEmpty
                                    ? detPel[0]['KDXX_DFTR']
                                    : '')),
                          ], rows: [
                            DataRow(cells: [
                              const DataCell(Text('Nama Pelanggan')),
                              const DataCell(Text(':')),
                              DataCell(Text(detPel.isNotEmpty
                                  ? detPel[0]['NAMA_JMAH']
                                  : '')),
                            ]),
                            DataRow(cells: [
                              const DataCell(Text('Pendaftaran Via')),
                              const DataCell(Text(':')),
                              DataCell(Text(detPel.isNotEmpty
                                  ? detPel[0]['DAFTAR_VIA']
                                  : '')),
                            ]),
                            DataRow(cells: [
                              const DataCell(Text('Berangkat')),
                              const DataCell(Text(':')),
                              DataCell(Text(detPel.isNotEmpty
                                  ? fncGetTanggal(detPel[0]['TGLX_BGKT'])
                                  : '')),
                            ]),
                            DataRow(cells: [
                              const DataCell(Text('Telp Pelanggan')),
                              const DataCell(Text(':')),
                              DataCell(Text(detPel.isNotEmpty
                                  ? detPel[0]['TELP_JMAH']
                                  : '')),
                            ]),
                          ])
                        ],
                      ),
                      Column(
                        children: [
                          DataTable(columns: [
                            const DataColumn(label: Text('ID Marketing')),
                            const DataColumn(label: Text(':')),
                            DataColumn(
                                label: Text(detPel.isNotEmpty
                                    ? (detPel[0]['KDXX_MRKT'] ?? '-')
                                    : '')),
                          ], rows: [
                            DataRow(cells: [
                              const DataCell(Text('Nama Marketing')),
                              const DataCell(Text(':')),
                              DataCell(Text(detPel.isNotEmpty
                                  ? (detPel[0]['NAMA_MRKT'] ?? '-')
                                  : '')),
                            ]),
                            DataRow(cells: [
                              const DataCell(Text('Level Agency')),
                              const DataCell(Text(':')),
                              DataCell(Text(detPel.isNotEmpty
                                  ? (detPel[0]['FIRST_LEVEL'] ?? '-')
                                  : '')),
                            ]),
                            DataRow(cells: [
                              const DataCell(Text('Jenis')),
                              const DataCell(Text(':')),
                              DataCell(Text(detPel.isNotEmpty
                                  ? detPel[0]['JENIS_PAKET']
                                  : '-')),
                            ]),
                            DataRow(cells: [
                              const DataCell(Text('Telp Marketing')),
                              const DataCell(Text(':')),
                              DataCell(Text(detPel.isNotEmpty
                                  ? (detPel[0]['TELP_MRKT'] ?? '-')
                                  : '')),
                            ]),
                          ])
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('No')),
                                DataColumn(label: Text('Upline')),
                                DataColumn(label: Text('SVB')),
                              ],
                              rows: [
                                if (detPel.isNotEmpty &&
                                    detPel[0]['LEAD_FIRST'] != null)
                                  DataRow(cells: [
                                    const DataCell(Text('1')),
                                    DataCell(Text(detPel[0]['LEAD_FIRST'])),
                                    DataCell(Icon(
                                        detPel[0]['SVB_FIRST'] != null
                                            ? Icons.check
                                            : Icons.add_alert_outlined,
                                        color: detPel[0]['SVB_FIRST'] != null
                                            ? Colors.green
                                            : Colors.red)),
                                  ]),
                                if (detPel.isNotEmpty &&
                                    detPel[0]['LEAD_SECOND'] != null)
                                  DataRow(cells: [
                                    const DataCell(Text('2')),
                                    DataCell(Text(detPel[0]['LEAD_SECOND'])),
                                    DataCell(Icon(
                                        detPel[0]['SVB_SECOND'] != null
                                            ? Icons.check
                                            : Icons.add_alert_outlined,
                                        color: detPel[0]['SVB_SECOND'] != null
                                            ? Colors.green
                                            : Colors.red)),
                                  ]),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.check),
                        label: const Text('Pendaftaran USmart'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.check),
                        label: const Text('Konfirmasi Pemberangkatan'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.chat_outlined),
                        label: const Text('WA'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.star_border_outlined),
                        label: const Text('VB'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Kembali'))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
