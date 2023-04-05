// ignore_for_file: missing_return

import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/finance/widgets/lapor-bayar/table_laporan_pembayaran.dart';
import 'package:flutter_web_course/pages/finance/widgets/penerbangan.dart/penerbangan_table.dart';
import 'package:flutter_web_course/pages/inventory/widgets/kirim/table_kirim_barang.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class FinancePembayaranHarian extends StatefulWidget {
  const FinancePembayaranHarian({Key key}) : super(key: key);

  @override
  State<FinancePembayaranHarian> createState() =>
      _FinancePembayaranHarianState();
}

class _FinancePembayaranHarianState extends State<FinancePembayaranHarian> {
  String jenisTagihan = 'Semua';
  String totalPembayaran = '0';
  TextEditingController dateAwal = TextEditingController();
  TextEditingController dateAkhir = TextEditingController();

  List<Map<String, dynamic>> listDataPembayaran = [];

  void getHariIni() async {
    setState(() {
      dateAwal.text =
          DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
      dateAkhir.text =
          DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    });
  }

  void getDataPembayaran() async {
    var tglAwal = fncTanggal(dateAwal.text);
    var tglAkhir = fncTanggal(dateAkhir.text);

    var response = await http.get(
        Uri.parse(
            "$urlAddress/finance/pembayaran/get-laporan/$tglAwal/$tglAkhir/$jenisTagihan"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    int ttl = 0;
    for (var i = 0; i < dataStatus.length; i++) {
      ttl += dataStatus[i]['DIBAYARKAN'];
    }

    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    setState(() {
      totalPembayaran = myFormat.format(ttl);
      listDataPembayaran = dataStatus;
    });
  }

  @override
  void initState() {
    getHariIni();
    super.initState();
  }

  Widget inputTglAwal() {
    return TextFormField(
      controller: dateAwal,
      decoration: const InputDecoration(
          label: Text('Tanggal Awal'), hintText: 'DD-MM-YYYY'),
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          dateAwal.text = formattedDate;
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Tgl Awal masih kosong !";
        }
      },
    );
  }

  Widget inputTglAkhir() {
    return TextFormField(
      controller: dateAkhir,
      decoration: const InputDecoration(
          label: Text('Tanggal Akhir'), hintText: 'DD-MM-YYYY'),
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          dateAkhir.text = formattedDate;
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Tgl Akhir masih kosong !";
        }
      },
    );
  }

  Widget selectJenis(context) {
    return SizedBox(
      height: 35,
      width: ResponsiveWidget.isSmallScreen(context) ? 150 : 200,
      child: DropdownSearch(
        mode: Mode.MENU,
        items: const [
          "Semua",
          "Biaya Paket",
          "Vaksin",
          "Paspor",
          "Biaya Admin",
          "Biaya Handling",
          "Biaya Kamar",
        ],
        onChanged: (value) {
          setState(() {
            jenisTagihan = value;
          });
        },
        selectedItem: "Semua",
      ),
    );
  }

  Widget cmdCari() {
    return ElevatedButton.icon(
      onPressed: () async {
        getDataPembayaran();
      },
      icon: const Icon(Icons.search_outlined),
      style: fncButtonAuthStyle('1', context),
      label: fncLabelButtonStyle('Cari', context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: 'Finance - ${menuController.activeItem.value}',
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                  )
                ],
              )),
          const SizedBox(height: 20),
          Container(
            width: screenWidth,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 7,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 220, child: inputTglAwal()),
                    const SizedBox(width: 10),
                    SizedBox(width: 220, child: inputTglAkhir()),
                    Expanded(child: Container()),
                    SizedBox(width: 220, child: selectJenis(context)),
                    const SizedBox(width: 5),
                    cmdCari(),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 7,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Pembayaran : $totalPembayaran',
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: myBlue),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 50,
                            width: 250,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: TextFormField(
                              style: const TextStyle(
                                  fontFamily: 'Gilroy', fontSize: 14),
                              decoration: const InputDecoration(
                                  hintText: 'Cari Berdasarkan Nama'),
                              onChanged: (value) {
                                if (value == '') {
                                  getDataPembayaran();
                                } else {
                                  setState(() {
                                    listDataPembayaran = listDataPembayaran
                                        .where(((element) =>
                                            element['NAMA_LGKP']
                                                .toString()
                                                .toUpperCase()
                                                .contains(value.toUpperCase())))
                                        .toList();
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TableLaporanPembayaran(dataLaporan: listDataPembayaran)
              ],
            ),
          )
        ],
      ),
    );
  }
}
