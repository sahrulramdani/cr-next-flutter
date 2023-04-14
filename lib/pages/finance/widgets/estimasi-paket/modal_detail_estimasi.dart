// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print, prefer_const_literals_to_create_immutables, prefer_const_constructors, unrelated_type_equality_checks

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/models/http_maskapai.dart';
import 'package:flutter_web_course/pages/finance/widgets/estimasi-paket/modal_edit_estimasi.dart';
import 'package:flutter_web_course/pages/finance/widgets/estimasi-paket/modal_simulasi.dart';
import 'package:flutter_web_course/pages/finance/widgets/estimasi-paket/modal_tambah_estimasi.dart';
import 'package:flutter_web_course/pages/hr/widgets/menu/header_table_listmenu.dart';
import 'package:flutter_web_course/pages/hr/widgets/menu/header_table_submenu.dart';
import 'package:flutter_web_course/pages/hr/widgets/menu/modal_tambah_submenu.dart';
import 'package:flutter_web_course/pages/hr/widgets/menu/model_tambah_listmenu.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';

class ModalDetailEstimasi extends StatefulWidget {
  final String idJadwal;
  final String keberangkatan;
  final String seat;
  final String harga;

  const ModalDetailEstimasi({
    Key key,
    @required this.idJadwal,
    @required this.keberangkatan,
    @required this.seat,
    @required this.harga,
  }) : super(key: key);

  @override
  State<ModalDetailEstimasi> createState() => _ModalDetailEstimasiState();
}

class _ModalDetailEstimasiState extends State<ModalDetailEstimasi> {
  String idJadwal;
  String keterangan;
  int totalSumberDana = 0;
  int totalListBiaya = 0;
  int margin = 0;
  int totalMargin = 0;
  List<Map<String, dynamic>> listDetailJadwal = [];

  void getListBiaya() async {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    var responePaket = await http.get(
        Uri.parse(
            "$urlAddress/finance/estimasi-paket/detail/${widget.idJadwal}"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(responePaket.body) as List);

    if (data.isNotEmpty) {
      for (var i = 0; i < data.length; i++) {
        var pushData = {
          "KDXX_ESTX": "${data[i]['KDXX_ESTX']}",
          "KDXX_PKET": "${data[i]['KDXX_PKET']}",
          "SUMB_DANA": "${data[i]['SUMB_DANA']}",
          "SUMBER_DANA":
              "${data[i]['NAMA_SUMB'] != data[i == 0 ? 0 : i - 1]['NAMA_SUMB'] ? data[i]['NAMA_SUMB'] : (i == 0 ? data[i]['NAMA_SUMB'] : '')}",
          "NOMX_SUMD":
              "${data[i]['NOMX_SUMD'] != data[i == 0 ? 0 : i - 1]['NOMX_SUMD'] ? data[i]['NOMX_SUMD'] : (i == 0 ? data[i]['NOMX_SUMD'] : '')}",
          "NOMX_SUMDB":
              "${data[i]['NOMX_SUMD'] != data[i == 0 ? 0 : i - 1]['NOMX_SUMD'] ? data[i]['NOMX_SUMD'] : (i == 0 ? data[i]['NOMX_SUMD'] : '0')}",
          "NAMA_BIAYA": "${data[i]['DESC_BIAYA']}",
          "NOMINAL": myFormat.format(data[i]['NOMINAL']),
          "TOTAL":
              "${data[i]['TOTAL'] != data[i == 0 ? 0 : i - 1]['TOTAL'] ? data[i]['TOTAL'] : (i == 0 ? data[i]['TOTAL'] : '0')}"
        };

        listDetailJadwal.add(pushData);
      }
    }

    for (var j = 0; j < listDetailJadwal.length; j++) {
      totalSumberDana =
          totalSumberDana + int.parse(listDetailJadwal[j]["NOMX_SUMDB"]);
      totalListBiaya = totalListBiaya + int.parse(listDetailJadwal[j]["TOTAL"]);
    }

    setState(() {
      margin = totalSumberDana - totalListBiaya;
      totalMargin = margin * int.parse(widget.seat);
    });
  }

  @override
  void initState() {
    super.initState();
    getListBiaya();
  }

  // Widget cmdEdit(context) {
  //   return ElevatedButton.icon(
  //     onPressed: () async {
  //       showDialog(
  //           context: context,
  //           builder: (context) => ModalTambahEstimasi(
  //                 idJadwal: widget.idJadwal,
  //                 listDetailJadwal: listDetailJadwal,
  //               ));
  //     },
  //     icon: const Icon(Icons.add),
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: myBlue,
  //       minimumSize: const Size(100, 40),
  //       shadowColor: Colors.grey,
  //       elevation: 5,
  //     ),
  //     label: const Text(
  //       'Edit Data',
  //       style: TextStyle(fontFamily: 'Gilroy'),
  //     ),
  //   );
  // }

  Widget cmdTambah(context) {
    return ElevatedButton.icon(
      onPressed: () async {
        showDialog(
            context: context,
            builder: (context) => ModalTambahEstimasi(
                  idJadwal: widget.idJadwal,
                  keberangkatan: widget.keberangkatan,
                  seat: widget.seat,
                  harga: widget.harga,
                  listDetailJadwal: listDetailJadwal,
                ));
      },
      icon: const Icon(Icons.add),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
      label: const Text(
        'Tambah Data',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
    );
  }

  Widget cmdSimulasi(context) {
    return ElevatedButton.icon(
      onPressed: () async {
        showDialog(
            context: context,
            builder: (context) => ModalSimulasiPaket(
                  idJadwal: widget.idJadwal,
                  keberangkatan: widget.keberangkatan,
                  seat: widget.seat,
                  harga: widget.harga,
                  listDetailJadwal: listDetailJadwal,
                ));
      },
      icon: const Icon(Icons.sim_card_outlined),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
      label: const Text(
        'Simulasi',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
    );
  }

  Widget inputKodeJadwal() {
    return TextFormField(
      initialValue: widget.idJadwal ?? "",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'ID Jadwal Paket',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      readOnly: true,
    );
  }

  Widget inputKeterangan() {
    return TextFormField(
      initialValue: widget.keberangkatan ?? "",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Keberangkatan',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      readOnly: true,
    );
  }

  fncSaveData() {}

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    final styleBawah =
        TextStyle(color: myGrey, fontWeight: FontWeight.bold, fontSize: 14);
    int x = 1;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.82,
            height: 800,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      Text(
                          "Detail Estimasi Biaya Keberangkatan ${widget.keberangkatan}",
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: screenWidth,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 500,
                                  child: Column(
                                    children: [
                                      inputKodeJadwal(),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                SizedBox(
                                  width: 500,
                                  child: Column(
                                    children: [
                                      inputKeterangan(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: screenWidth * 0.83,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 5),
                                  cmdTambah(context),
                                  const SizedBox(width: 5),
                                  cmdSimulasi(context)
                                ],
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: screenWidth * 0.75,
                            height: 0.42 * screenHeight,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                headingRowColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  return Colors.blue;
                                }),
                                dataRowHeight: 30,
                                headingTextStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy',
                                    fontSize: 16),
                                columnSpacing: 70,
                                columns: const [
                                  DataColumn(label: Text('No')),
                                  DataColumn(label: Text('Sumber Dana')),
                                  DataColumn(label: Text('Nominal')),
                                  DataColumn(label: Text('Nama Biaya')),
                                  DataColumn(label: Text('Nominal')),
                                ],
                                rows: listDetailJadwal != 0
                                    ? listDetailJadwal.map((e) {
                                        return DataRow(cells: [
                                          DataCell(
                                              Text((x++).toString() ?? " ")),
                                          DataCell(
                                              Text(e['SUMBER_DANA'] ?? " ")),
                                          DataCell(Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(e['NOMX_SUMD'] != ''
                                                  ? myFormat.format(
                                                      int.parse(e['NOMX_SUMD']))
                                                  : " "),
                                            ],
                                          )),
                                          DataCell(
                                              Text(e['NAMA_BIAYA'] ?? " ")),
                                          DataCell(Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(e['NOMINAL'] ?? " "),
                                            ],
                                          )),
                                        ]);
                                      }).toList()
                                    : DataRow(cells: [
                                        DataCell(Text("")),
                                        DataCell(Text("")),
                                        DataCell(Text("")),
                                        DataCell(Text("")),
                                        DataCell(Text("")),
                                      ]),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const SizedBox(height: 5),
                              Divider(thickness: 2, color: Colors.blue),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text("Total Sumber Dana : ",
                                      style: styleBawah),
                                  const SizedBox(width: 350),
                                  Text(myFormat.format(totalSumberDana),
                                      style: styleBawah),
                                  const SizedBox(width: 65),
                                  Text("Total Biaya : ", style: styleBawah),
                                  const SizedBox(width: 220),
                                  Text(myFormat.format(totalListBiaya),
                                      style: styleBawah),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Divider(thickness: 2, color: Colors.blue),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text("Margin : ", style: styleBawah),
                                  const SizedBox(width: 250),
                                  Text(myFormat.format(margin),
                                      style: styleBawah),
                                  const SizedBox(width: 95),
                                  Text("Jumlah Seat : ", style: styleBawah),
                                  Text(widget.seat, style: styleBawah),
                                  const SizedBox(width: 95),
                                  Text("Total Margin : ", style: styleBawah),
                                  const SizedBox(width: 160),
                                  Text(myFormat.format(totalMargin),
                                      style: styleBawah),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Divider(thickness: 2, color: Colors.blue),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
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
