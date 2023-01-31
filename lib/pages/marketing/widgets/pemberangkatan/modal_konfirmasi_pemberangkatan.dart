import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';

class ModalKonfirmasiBerangkat extends StatelessWidget {
  const ModalKonfirmasiBerangkat({Key key}) : super(key: key);

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
                          DataTable(columns: const [
                            DataColumn(label: Text('ID Pelanggan')),
                            DataColumn(label: Text(':')),
                            DataColumn(label: Text('P0102201121')),
                          ], rows: const [
                            DataRow(cells: [
                              DataCell(Text('Nama Pelanggan')),
                              DataCell(Text(':')),
                              DataCell(Text('Salwa Masar')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Pendaftaran Via')),
                              DataCell(Text(':')),
                              DataCell(Text('Pusat')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Berangkat')),
                              DataCell(Text(':')),
                              DataCell(Text('2 Januari 2023')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Telp Pelanggan')),
                              DataCell(Text(':')),
                              DataCell(Text('082227381993')),
                            ]),
                          ])
                        ],
                      ),
                      Column(
                        children: [
                          DataTable(columns: const [
                            DataColumn(label: Text('ID Marketing')),
                            DataColumn(label: Text(':')),
                            DataColumn(label: Text('MRQ10220001')),
                          ], rows: const [
                            DataRow(cells: [
                              DataCell(Text('Nama Marketing')),
                              DataCell(Text(':')),
                              DataCell(Text('Hasan Basri')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Level Agency')),
                              DataCell(Text(':')),
                              DataCell(Text('Umroh')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Jenis')),
                              DataCell(Text(':')),
                              DataCell(Text('Reguler B3')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Telp Marketing')),
                              DataCell(Text(':')),
                              DataCell(Text('0896477182392')),
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
                              rows: const [
                                DataRow(cells: [
                                  DataCell(Text('1')),
                                  DataCell(Text('Maulana Ibrahim')),
                                  DataCell(
                                      Icon(Icons.check, color: Colors.green)),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('2')),
                                  DataCell(Text('Prasetyo Gunawan')),
                                  DataCell(
                                      Icon(Icons.check, color: Colors.green)),
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
