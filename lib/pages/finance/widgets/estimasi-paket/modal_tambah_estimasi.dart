// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print, must_be_immutable

import 'package:flutter_web_course/models/http_estimasi.dart';
import 'package:flutter_web_course/pages/finance/widgets/estimasi-paket/modal_detail_estimasi.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';

class ModalTambahEstimasi extends StatefulWidget {
  final String idJadwal;
  final String keberangkatan;
  final String seat;
  final String harga;

  List<Map<String, dynamic>> listDetailJadwal = [];

  ModalTambahEstimasi(
      {Key key,
      @required this.idJadwal,
      this.keberangkatan,
      this.seat,
      this.harga,
      @required this.listDetailJadwal})
      : super(key: key);

  @override
  State<ModalTambahEstimasi> createState() => _ModalTambahEstimasiState();
}

class _ModalTambahEstimasiState extends State<ModalTambahEstimasi> {
  List<Map<String, dynamic>> listDetail = [];
  List<Map<String, dynamic>> listDaftarBiaya = [];
  List<Map<String, dynamic>> listSumberDana = [];
  String kodeSumberDana;
  String namaSumberDana;
  String nominal;
  int urut = 0;

  String kodeBiaya;
  String namaBiaya;
  String nominalBiaya;

  void getSumberDana() async {
    var response = await http
        .get(Uri.parse("$urlAddress/finance/pendapatan-biaya/8901"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listSumberDana = data;
    });
  }

  void getJenisBiaya() async {
    var response = await http
        .get(Uri.parse("$urlAddress/finance/pendapatan-biaya/8902"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listDaftarBiaya = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getSumberDana();
    getJenisBiaya();
  }

  Widget inputSumberDana() {
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
              if (value['DESKRIPSI'] == 'Biaya Paket') {
                nominal = widget.harga;
              } else {
                nominal = '0';
              }
            });
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

  Widget inputNamaBiaya() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "Nama Biaya",
          mode: Mode.MENU,
          onChanged: (value) {
            setState(() {
              kodeBiaya = value['KDXX_PBYA'];
              namaBiaya = value['DESKRIPSI'];
            });
          },
          items: listDaftarBiaya,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['DESKRIPSI'].toString()),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
              namaBiaya ?? "Pilih Biaya",
              style: TextStyle(
                  color: namaBiaya == null ? Colors.red : Colors.black)),
          dropdownSearchDecoration: const InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            hoverColor: Colors.white,
          )),
    );
  }

  Widget inputNominal() {
    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          label: Text("Nominal Biaya"),
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: (value) {
        nominalBiaya = value;
      },
      validator: (value) {
        if (nominalBiaya.isEmpty) {
          return "Nominal Biaya masih kosong !";
        }
      },
    );
  }

  Widget cmdTambah(context) {
    return ElevatedButton.icon(
      onPressed: () async {
        if (namaBiaya != null && nominalBiaya != null) {
          var pushPaket = {
            "NOXX_URUT": urut.toString(),
            "KDXX_PBYA": kodeBiaya,
            "NAMA_BIAYA": namaBiaya,
            "NOMINAL": nominalBiaya,
          };
          listDetail.add(pushPaket);
          setState(() {
            kodeBiaya = null;
            namaBiaya = null;
            nominalBiaya = null;
            urut = urut + 1;
          });
        }
      },
      icon: const Icon(Icons.add),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
      label: const Text(
        'Tambah List',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
    );
  }

  fncSaveData(context) {
    List<Map<String, dynamic>> listBiayaPaket = [];

    for (var i = 0; i < listDetail.length; i++) {
      var list = {
        '"NOXX_URUT"': '"${listDetail[i]['NOXX_URUT'].toString()}"',
        '"KDXX_BIAYA"': '"${listDetail[i]['KDXX_PBYA'].toString()}"',
        '"NAMA_BIAYA"': '"${listDetail[i]['NAMA_BIAYA'].toString()}"',
        '"NOMINAL"':
            '"${listDetail[i]['NOMINAL'].toString().replaceAll(',', '')}"',
      };
      listBiayaPaket.add(list);
    }

    HttpEstimasi.saveEstimasi(
      widget.idJadwal,
      kodeSumberDana,
      nominal.replaceAll(',', ''),
      '$listBiayaPaket',
    ).then((value) {
      if (value.status == true) {
        Navigator.pop(context);
        Navigator.pop(context);

        showDialog(
            context: context,
            builder: (context) => ModalDetailEstimasi(
                  idJadwal: widget.idJadwal,
                  keberangkatan: widget.keberangkatan,
                  seat: widget.seat,
                  harga: widget.harga,
                ));

        showDialog(
            context: context, builder: (context) => const ModalSaveSuccess());
      } else {
        showDialog(
            context: context, builder: (context) => const ModalSaveFail());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();
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
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(width: 445, child: inputSumberDana()),
                  const SizedBox(width: 40),
                  SizedBox(width: 445, child: inputTarif()),
                ]),
                const SizedBox(height: 20),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  SizedBox(width: 355, child: inputNamaBiaya()),
                  const SizedBox(width: 40),
                  SizedBox(width: 355, child: inputNominal()),
                  const SizedBox(width: 40),
                  cmdTambah(context)
                ]),
                const SizedBox(height: 20),
                Expanded(
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
                                    columnSpacing: 220,
                                    dataRowHeight: 40,
                                    dataTextStyle:
                                        const TextStyle(fontSize: 13),
                                    columns: const [
                                      DataColumn(label: Text('No.')),
                                      DataColumn(label: Text('Nama Biaya')),
                                      DataColumn(label: Text('Nominal')),
                                      DataColumn(label: Text('Aksi')),
                                    ],
                                    rows: listDetail.map((e) {
                                      return DataRow(cells: [
                                        DataCell(Text((x++).toString())),
                                        DataCell(Text(
                                            (e['NAMA_BIAYA']).toString() ??
                                                "")),
                                        DataCell(Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(e['NOMINAL'] ?? ""),
                                          ],
                                        )),
                                        DataCell(IconButton(
                                          icon: Icon(
                                            Icons.delete_outline,
                                            color: myBlue,
                                          ),
                                          onPressed: () {
                                            listDetail.removeWhere((item) =>
                                                item['NOXX_URUT'] ==
                                                e['NOXX_URUT']);

                                            setState(() {});
                                          },
                                        )),
                                      ]);
                                    }).toList())
                              ],
                            )))),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          fncSaveData(context);
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
