// ignore_for_file: missing_return, deprecated_member_use

import 'package:flutter_web_course/comp/header_title_menu.dart';
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

class FinanceKasBankHarian extends StatefulWidget {
  const FinanceKasBankHarian({Key key}) : super(key: key);

  @override
  State<FinanceKasBankHarian> createState() => _FinanceKasBankHarianState();
}

class _FinanceKasBankHarianState extends State<FinanceKasBankHarian> {
  String jenisKas = '00';
  String descJenisKas = 'Semua';
  String totalPembayaran = '0';
  TextEditingController dateAwal = TextEditingController();
  TextEditingController dateAkhir = TextEditingController();

  List<Map<String, dynamic>> listDataPembayaran = [];
  List<Map<String, dynamic>> listKasBank = [];

  void getHariIni() async {
    setState(() {
      dateAwal.text =
          DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
      dateAkhir.text =
          DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    });
  }

  void getDataPembayaran() async {
    // var tglAwal = fncTanggal(dateAwal.text);
    // var tglAkhir = fncTanggal(dateAkhir.text);

    // var response = await http.get(
    //     Uri.parse(
    //         "$urlAddress/finance/pembayaran/get-laporan/$tglAwal/$tglAkhir/$jenisTagihan"),
    //     headers: {
    //       'pte-token': kodeToken,
    //     });
    // List<Map<String, dynamic>> dataStatus =
    //     List.from(json.decode(response.body) as List);

    // int ttl = 0;
    // for (var i = 0; i < dataStatus.length; i++) {
    //   ttl += dataStatus[i]['DIBAYARKAN'];
    // }

    // NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    // setState(() {
    //   totalPembayaran = myFormat.format(ttl);
    //   listDataPembayaran = dataStatus;
    // });
  }

  void getKasBank() async {
    var response =
        await http.get(Uri.parse("$urlAddress/finance/all-kasbank"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    var semua = [
      {
        "KODE_FLNM": "KASX_BANK",
        "KODE_BANK": "00",
        "NAMA_BANK": "Semua",
        "CHKX_BANK": 0,
        "ACCT_CODE": "",
        "CURR_MNYX": "IDR",
        "NOXX_REKX": "",
        "ALMT_BANK": "",
        "NOXX_TELP": "",
        "NOXX_FAXX": "",
        "CRTX_BYXX": "superadmin",
        "CRTX_DATE": "2023-03-31T09:59:57.000Z",
        "UPDT_BYXX": "superadmin",
        "UPDT_DATE": "2023-04-03T03:07:52.000Z",
        "DESKRIPSI": "All Kas Bank",
        "CODD_DESC": "Rupiah"
      },
    ];

    setState(() {
      listKasBank = data;
    });

    listKasBank.addAll(semua);
  }

  @override
  void initState() {
    getHariIni();
    getKasBank();
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

  Widget selectJenis() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.BOTTOM_SHEET,
        label: "Sumber Kas/Bank",
        items: listKasBank,
        onChanged: (value) {
          jenisKas = value['KODE_BANK'];
          descJenisKas = value['NAMA_BANK'] + " - " + value['ACCT_CODE'];
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['NAMA_BANK'] ?? '-'),
        ),
        dropdownBuilder: (context, selectedItem) =>
            Text(descJenisKas ?? "Pilih Kas/Bank"),
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
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
    final screenHeight = MediaQuery.of(context).size.height;
    final styleJudul = TextStyle(
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.bold,
        fontSize: ResponsiveWidget.isSmallScreen(context) ? 12 : 16,
        color: myBlue);

    return Column(
      children: [
        Obx(() => HeaderTitleMenu(menu: menuController.activeItem.value)),
        const SizedBox(height: 10),
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
                  SizedBox(width: 220, child: selectJenis()),
                  const SizedBox(width: 5),
                  cmdCari(),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: screenWidth,
            height: screenHeight * 0.68,
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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DataTable(
                    columnSpacing: 132,
                    dataRowHeight: 30,
                    dataTextStyle: const TextStyle(
                        fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                    headingTextStyle: const TextStyle(
                        fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                    columns: const [
                      DataColumn(label: Text('No.')),
                      DataColumn(label: Text('Kode Akun')),
                      DataColumn(label: Text('Keterangan')),
                      DataColumn(label: Text('Debet')),
                      DataColumn(label: Text('Kredit')),
                    ],
                    rows: const [
                      DataRow(cells: [
                        DataCell(Text('-')),
                        DataCell(Text('PENERIMAAN')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('1.')),
                        DataCell(Text('11103')),
                        DataCell(Text('Kas Operasional - CR')),
                        DataCell(Text('0,00')),
                        DataCell(Text('10,000,000,00')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('2.')),
                        DataCell(Text('11104')),
                        DataCell(Text('Bank BSI 0088319 - CR')),
                        DataCell(Text('0,00')),
                        DataCell(Text('10,000,000,00')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('3.')),
                        DataCell(Text('11105')),
                        DataCell(Text('Bank Permata 38819310 - CR')),
                        DataCell(Text('0,00')),
                        DataCell(Text('10,000,000,00')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('Jumlah Penerimaan Rp. :')),
                        DataCell(Text('')),
                        DataCell(Text('30,000,000,00')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('-')),
                        DataCell(Text('PENGELUARAN')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('1.')),
                        DataCell(Text('11103')),
                        DataCell(Text('Kas Operasional - CR')),
                        DataCell(Text('10,000,000,00')),
                        DataCell(Text('0,00')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('2.')),
                        DataCell(Text('11104')),
                        DataCell(Text('Bank BSI 0088319 - CR')),
                        DataCell(Text('10,000,000,00')),
                        DataCell(Text('0,00')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('3.')),
                        DataCell(Text('11105')),
                        DataCell(Text('Bank Permata 38819310 - CR')),
                        DataCell(Text('10,000,000,00')),
                        DataCell(Text('0,00')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('')),
                        DataCell(Text('')),
                        DataCell(Text('Jumlah Penerimaan Rp. :')),
                        DataCell(Text('30,000,000,00')),
                        DataCell(Text('')),
                      ]),
                    ],
                  ),

                  // Row(
                  //   children: [
                  //     Container(
                  //       height: 60,
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 15, vertical: 15),
                  //       decoration:
                  //           BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             'Kas Bank Harian',
                  //             style: TextStyle(
                  //                 fontFamily: 'Gilroy',
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 20,
                  //                 color: myBlue),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // // TableLaporanPembayaran(dataLaporan: listDataPembayaran)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
