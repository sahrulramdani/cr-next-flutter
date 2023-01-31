// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
// import 'package:flutter_web_course/models/http_controller.dart';

class DetailModalBatalKembali extends StatefulWidget {
  const DetailModalBatalKembali({
    Key key,
  }) : super(key: key);

  @override
  State<DetailModalBatalKembali> createState() =>
      _DetailModalBatalKembaliState();
}

class _DetailModalBatalKembaliState extends State<DetailModalBatalKembali> {
  String jenis;

  TextEditingController sejumlah = TextEditingController();
  TextEditingController biayaAdmin = TextEditingController();
  TextEditingController dendaBatal = TextEditingController();

  Widget inputPilihJenis() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "Pilih",
        mode: Mode.BOTTOM_SHEET,
        items: const [
          "Perubahan Jadwal",
          "Pembatalan",
        ],
        showSearchBox: true,
        onChanged: (value) {
          if (value == 'Perubahan Jadwal') {
            setState(() {
              sejumlah.text = '32,900,000';
              biayaAdmin.text = '12,000';
              dendaBatal.text = '0';
              jenis = value;
            });
          } else {
            setState(() {
              sejumlah.text = '32,900,000';
              biayaAdmin.text = '12,000';
              dendaBatal.text = '45,000';
              jenis = value;
            });
          }
        },
        selectedItem: jenis ?? "Pilih",
      ),
    );
  }

  // Widget inputStatusPiutang() {
  //   return SizedBox(
  //     height: 50,
  //     child: DropdownSearch(
  //       enabled: false,
  //       label: "Status Piutang",
  //       mode: Mode.BOTTOM_SHEET,
  //       items: const [
  //         "Perpindahan Piutang",
  //         "Pengembalian",
  //       ],
  //       showSearchBox: true,
  //       onChanged: print,
  //       selectedItem: "Pilih Status Piutang",
  //     ),
  //   );
  // }

  Widget inputSejumlah() {
    return TextFormField(
      readOnly: true,
      textAlign: TextAlign.right,
      controller: sejumlah,
      // onChanged: (value) {},
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Sejumlah'),
    );
  }

  Widget inputBiayaAdmin() {
    return TextFormField(
      readOnly: true,
      textAlign: TextAlign.right,
      controller: biayaAdmin,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Biaya Admin'),
    );
  }

  Widget inputDendaPembatalan() {
    return TextFormField(
      readOnly: true,
      textAlign: TextAlign.right,
      controller: dendaBatal,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Denda Pembatalan'),
    );
  }

  // fncSaveData() {
  //   showDialog(
  //       context: context, builder: (context) => const ModalSaveSuccess());

  //   menuController.changeActiveitemTo('Jadwal');
  //   navigationController.navigateTo('/jamaah/jadwal');
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth > 600 ? 800 : 400,
            height: 700,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.corporate_fare_rounded,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      FittedBox(
                        child: Text(
                            'Pembatalan dan Pengembalian Nanim Sumartini',
                            style: TextStyle(
                                color: myGrey, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DataTable(
                          columns: const [
                            DataColumn(label: Text('Biaya')),
                            DataColumn(label: Text(':')),
                            DataColumn(label: Text('28,900,000')),
                          ],
                          rows: const [
                            DataRow(cells: [
                              DataCell(Text('Kurs')),
                              DataCell(Text(':')),
                              DataCell(Text('15,600')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Biaya Fasilitas')),
                              DataCell(Text(':')),
                              DataCell(Text('3,000,000')),
                            ]),
                          ],
                        ),
                        const SizedBox(width: 20),
                        DataTable(
                          columns: const [
                            DataColumn(label: Text('Uang Masuk')),
                            DataColumn(label: Text(':')),
                            DataColumn(label: Text('32,900,000')),
                          ],
                          rows: const [
                            DataRow(cells: [
                              DataCell(Text('Estimasi Total')),
                              DataCell(Text(':')),
                              DataCell(Text('32,900,000')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Estimasi Sisa')),
                              DataCell(Text(':')),
                              DataCell(Text('0')),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Column(
                    children: [
                      inputPilihJenis(),
                      const SizedBox(height: 8),
                      inputSejumlah(),
                      const SizedBox(height: 8),
                      inputBiayaAdmin(),
                      const SizedBox(height: 8),
                      inputDendaPembatalan(),
                      // const SizedBox(height: 8),
                      // inputStatusPiutang(),
                      const SizedBox(height: 20),
                    ],
                  ),
                )),
                const SizedBox(height: 10),
                SizedBox(
                  height: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) => const ModalSaveSuccess());
                        },
                        icon: const Icon(Icons.save),
                        label: const Text(
                          'Simpan Data',
                          style: TextStyle(fontFamily: 'Gilroy'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myBlue,
                          shadowColor: Colors.grey,
                          elevation: 5,
                        ),
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
          ),
        )
      ]),
    );
  }
}
