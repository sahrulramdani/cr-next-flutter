// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print, must_be_immutable

import 'package:flutter_web_course/models/http_estimasi.dart';
import 'package:flutter_web_course/pages/finance/widgets/estimasi-paket/modal_detail_estimasi.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:intl/intl.dart';

// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';

class ModalSimulasiPaket extends StatefulWidget {
  final String idJadwal;
  final String keberangkatan;
  final String seat;
  final String harga;

  List<Map<String, dynamic>> listDetailJadwal = [];

  ModalSimulasiPaket(
      {Key key,
      @required this.idJadwal,
      this.keberangkatan,
      this.seat,
      this.harga,
      @required this.listDetailJadwal})
      : super(key: key);

  @override
  State<ModalSimulasiPaket> createState() => _ModalSimulasiPaketState();
}

class _ModalSimulasiPaketState extends State<ModalSimulasiPaket> {
  List<Map<String, dynamic>> listDetail = [];
  List<Map<String, dynamic>> listBiaya = [];
  List<Map<String, dynamic>> listDaftarBiaya = [];
  List<Map<String, dynamic>> listSumberDana = [];
  String kodeSumberDana;
  String namaSumberDana;
  String nominal = '0';
  int urut = 0;
  String namaKota;
  String seat = '1';

  String kodeBiaya;
  String namaBiaya;
  String nominalBiaya;

  int totalSumberDana = 0;
  int totalListBiaya = 0;
  int margin = 0;
  int totalMargin = 0;

  void getSumberDana() async {
    var id = widget.idJadwal;
    var response = await http.get(
        Uri.parse("$urlAddress/finance/simulasi/pendapatan/$id"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listSumberDana = data;
    });
  }

  void getDetailList() async {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    setState(() {
      listDetail = widget.listDetailJadwal;
      listBiaya = [];
      totalSumberDana = 0;
      totalListBiaya = 0;
      margin = 0;
      totalMargin = 0;
    });

    if (listDetail.isNotEmpty) {
      for (var i = 0; i < listDetail.length; i++) {
        var pushData = {
          "KDXX_ESTX": "${listDetail[i]['KDXX_ESTX']}",
          "KDXX_PKET": "${listDetail[i]['KDXX_PKET']}",
          "SUMB_DANA": "${listDetail[i]['SUMB_DANA']}",
          "NOMX_SUMD": "${listDetail[i]['NOMX_SUMD']}",
          "NOMX_SUMDB": "${listDetail[i]['NOMX_SUMD']}",
          "NAMA_BIAYA": "${listDetail[i]['NAMA_BIAYA']}",
          "NOMINAL": listDetail[i]['NOMINAL'],
          "SEAT": seat,
          "SUBTOTAL": myFormat.format(int.parse(seat) *
              int.parse(
                  listDetail[i]['NOMINAL'].toString().replaceAll(',', ''))),
          "TOTAL": "${listDetail[i]['TOTAL']}"
        };

        listBiaya.add(pushData);
      }
    }

    setState(() {
      listBiaya = listBiaya
          .where(((element) => element['SUMB_DANA'] == kodeSumberDana))
          .toList();
    });

    if (listDetail.isNotEmpty) {
      for (var j = 0; j < listBiaya.length; j++) {
        totalSumberDana =
            int.parse(nominal.replaceAll(',', '')) * int.parse(seat);

        totalListBiaya = totalListBiaya +
            int.parse(listBiaya[j]['SUBTOTAL'].toString().replaceAll(',', ''));
      }
    }

    setState(() {
      margin = totalSumberDana - totalListBiaya;
      totalMargin = margin * int.parse(seat);
    });
  }

  getDetailOnSubmit() {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    List<Map<String, dynamic>> listDet = listBiaya;

    setState(() {
      listBiaya = [];
      totalSumberDana = 0;
      totalListBiaya = 0;
      margin = 0;
      totalMargin = 0;
    });

    if (listDet.isNotEmpty) {
      for (var i = 0; i < listDet.length; i++) {
        var pushData = {
          "KDXX_ESTX": "${listDet[i]['KDXX_ESTX']}",
          "KDXX_PKET": "${listDet[i]['KDXX_PKET']}",
          "SUMB_DANA": "${listDet[i]['SUMB_DANA']}",
          "NOMX_SUMD": "${listDet[i]['NOMX_SUMD']}",
          "NOMX_SUMDB": "${listDet[i]['NOMX_SUMD']}",
          "NAMA_BIAYA": "${listDet[i]['NAMA_BIAYA']}",
          "NOMINAL": listDet[i]['NOMINAL'],
          "SEAT": seat,
          "SUBTOTAL": myFormat.format(int.parse(seat) *
              int.parse(listDet[i]['NOMINAL'].toString().replaceAll(',', ''))),
          "TOTAL": "${listDet[i]['TOTAL']}"
        };

        listBiaya.add(pushData);
      }
    }

    if (listBiaya.isNotEmpty) {
      for (var j = 0; j < listBiaya.length; j++) {
        totalSumberDana =
            int.parse(nominal.replaceAll(',', '')) * int.parse(seat);

        totalListBiaya = totalListBiaya +
            int.parse(listBiaya[j]['SUBTOTAL'].toString().replaceAll(',', ''));
      }
    }

    setState(() {
      margin = totalSumberDana - totalListBiaya;
      totalMargin = margin * int.parse(seat);
    });
  }

  // void getJenisBiaya() async {
  //   var response = await http
  //       .get(Uri.parse("$urlAddress/finance/pendapatan-biaya/8902"), headers: {
  //     'pte-token': kodeToken,
  //   });
  //   List<Map<String, dynamic>> data =
  //       List.from(json.decode(response.body) as List);

  //   setState(() {
  //     listDaftarBiaya = data;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // getDetailList();
    getSumberDana();
    // getJenisBiaya();
  }

  Widget inputNamaKota() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          label: Text('Nama Kota', style: TextStyle(color: Colors.red)),
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: (value) {
        namaKota = value;
      },
      initialValue: namaKota,
      validator: (value) {
        if (value.isEmpty) {
          return "Nama Kota masih kosong !";
        }
      },
    );
  }

  Widget inputJumlahSeat() {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          label: Text('Jumlah Seat', style: TextStyle(color: Colors.red)),
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: (value) {
        seat = value;
      },
      onFieldSubmitted: (value) {
        getDetailOnSubmit();
      },
      initialValue: seat,
      validator: (value) {
        if (value.isEmpty) {
          return "Jumlah Seat masih kosong !";
        }
      },
    );
  }

  Widget inputSumberDana() {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "Sumber Dana",
          mode: Mode.MENU,
          onChanged: (value) {
            setState(() {
              kodeSumberDana = value['KDXX_PBYA'];
              namaSumberDana = value['DESKRIPSI'];
              nominal = myFormat.format(value['NOMX_SUMD']);
            });

            getDetailList();
          },
          items: listSumberDana,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['DESKRIPSI'].toString()),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
              namaSumberDana ?? "Pilih Sumber Dana",
              style: TextStyle(
                  color: namaSumberDana == null ? Colors.red : Colors.black)),
          dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            hoverColor: Colors.white,
          )),
    );
  }

  Widget inputTarif() {
    return TextFormField(
      readOnly: true,
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          label: Text("Nominal"),
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: (value) {
        nominal = value;
      },
      initialValue: nominal ?? '0',
      validator: (value) {
        if (nominal.isEmpty) {
          return "Nominal masih kosong !";
        }
      },
    );
  }

  // Widget inputNamaBiaya() {
  //   return Container(
  //     height: 50,
  //     decoration: const BoxDecoration(
  //         border: Border(
  //             bottom: BorderSide(
  //                 style: BorderStyle.solid, color: Colors.black, width: 0.4))),
  //     child: DropdownSearch(
  //         label: "Nama Biaya",
  //         mode: Mode.MENU,
  //         onChanged: (value) {
  //           setState(() {
  //             kodeBiaya = value['KDXX_PBYA'];
  //             namaBiaya = value['DESKRIPSI'];
  //           });
  //         },
  //         items: listDaftarBiaya,
  //         popupItemBuilder: (context, item, isSelected) => ListTile(
  //               title: Text(item['DESKRIPSI'].toString()),
  //             ),
  //         dropdownBuilder: (context, selectedItem) => Text(
  //             namaBiaya ?? "Pilih Biaya",
  //             style: TextStyle(
  //                 color: namaBiaya == null ? Colors.red : Colors.black)),
  //         dropdownSearchDecoration: const InputDecoration(
  //           border: InputBorder.none,
  //           filled: true,
  //           fillColor: Colors.white,
  //           hoverColor: Colors.white,
  //         )),
  //   );
  // }

  // Widget inputNominal() {
  //   return TextFormField(
  //     textAlign: TextAlign.right,
  //     keyboardType: TextInputType.number,
  //     inputFormatters: [ThousandsFormatter()],
  //     style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
  //     decoration: const InputDecoration(
  //         label: Text("Nominal Biaya"),
  //         filled: true,
  //         fillColor: Colors.white,
  //         hoverColor: Colors.white),
  //     onChanged: (value) {
  //       nominalBiaya = value;
  //     },
  //     validator: (value) {
  //       if (nominalBiaya.isEmpty) {
  //         return "Nominal Biaya masih kosong !";
  //       }
  //     },
  //   );
  // }

  // Widget cmdTambah(context) {
  //   return ElevatedButton.icon(
  //     onPressed: () async {
  //       if (namaBiaya != null && nominalBiaya != null) {
  //         var pushPaket = {
  //           "NOXX_URUT": urut.toString(),
  //           "KDXX_PBYA": kodeBiaya,
  //           "NAMA_BIAYA": namaBiaya,
  //           "NOMINAL": nominalBiaya,
  //         };
  //         listDetail.add(pushPaket);
  //         setState(() {
  //           kodeBiaya = null;
  //           namaBiaya = null;
  //           nominalBiaya = null;
  //           urut = urut + 1;
  //         });
  //       }
  //     },
  //     icon: const Icon(Icons.add),
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: myBlue,
  //       minimumSize: const Size(100, 40),
  //       shadowColor: Colors.grey,
  //       elevation: 5,
  //     ),
  //     label: const Text(
  //       'Tambah List',
  //       style: TextStyle(fontFamily: 'Gilroy'),
  //     ),
  //   );
  // }

  fncSaveData(context) {}

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    final formKey = GlobalKey<FormState>();
    final styleBawah =
        TextStyle(color: myGrey, fontWeight: FontWeight.bold, fontSize: 14);
    int x = 1;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            width: screenWidth * 0.73,
            height: 600,
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
                      Text("Tambah Detail Biaya ${widget.idJadwal}",
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(width: 445, child: inputNamaKota()),
                  const SizedBox(width: 40),
                  SizedBox(width: 445, child: inputJumlahSeat()),
                ]),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(width: 445, child: inputSumberDana()),
                  const SizedBox(width: 40),
                  SizedBox(width: 445, child: inputTarif()),
                ]),
                // const SizedBox(height: 10),
                // Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                //   SizedBox(width: 355, child: inputNamaBiaya()),
                //   const SizedBox(width: 40),
                //   SizedBox(width: 355, child: inputNominal()),
                //   const SizedBox(width: 40),
                //   cmdTambah(context)
                // ]),
                const SizedBox(height: 20),
                SizedBox(
                    height: 280,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                DataTable(
                                    headingRowColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
                                      return Colors.blue;
                                    }),
                                    headingTextStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Gilroy',
                                        fontSize: 16),
                                    columnSpacing: 150,
                                    dataRowHeight: 40,
                                    headingRowHeight: 40,
                                    dataTextStyle:
                                        const TextStyle(fontSize: 13),
                                    columns: const [
                                      DataColumn(label: Text('No.')),
                                      DataColumn(label: Text('Nama Biaya')),
                                      DataColumn(label: Text('Nominal')),
                                      DataColumn(label: Text('Seat')),
                                      DataColumn(label: Text('Subtotal')),
                                    ],
                                    rows: listBiaya.map((e) {
                                      return DataRow(cells: [
                                        DataCell(Text((x++).toString())),
                                        DataCell(Text(
                                            (e['NAMA_BIAYA']).toString() ??
                                                "")),
                                        DataCell(TextFormField(
                                          textAlign: TextAlign.right,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            ThousandsFormatter()
                                          ],
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Gilroy',
                                          ),
                                          decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 19)),
                                          initialValue: e['NOMINAL'] ?? '0',
                                          onFieldSubmitted: (value) {
                                            getDetailOnSubmit();
                                          },
                                          onChanged: (value) {
                                            e['NOMINAL'] = value;
                                          },
                                        )),
                                        DataCell(Text(seat)),
                                        DataCell(Text(e['SUBTOTAL'])),
                                      ]);
                                    }).toList())
                              ],
                            )))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      const Divider(thickness: 2, color: Colors.blue),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text("Total Sumber Dana : ", style: styleBawah),
                          const SizedBox(width: 200),
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
                      const Divider(thickness: 2, color: Colors.blue),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text("Margin : ", style: styleBawah),
                          const SizedBox(width: 250),
                          Text(myFormat.format(margin), style: styleBawah),
                          const SizedBox(width: 95),
                          Text("Jumlah Seat : ", style: styleBawah),
                          Text(seat, style: styleBawah),
                          const SizedBox(width: 70),
                          Text("Total Margin : ", style: styleBawah),
                          const SizedBox(width: 40),
                          Text(myFormat.format(totalMargin), style: styleBawah),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(thickness: 2, color: Colors.blue),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // ElevatedButton.icon(
                      //   onPressed: () {
                      //     fncSaveData(context);
                      //   },
                      //   icon: const Icon(Icons.save),
                      //   label: const Text(
                      //     'Print Data',
                      //     style: TextStyle(fontFamily: 'Gilroy'),
                      //   ),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: myBlue,
                      //     shadowColor: Colors.grey,
                      //     elevation: 5,
                      //   ),
                      // ),
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
