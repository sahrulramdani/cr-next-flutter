// ignore_for_file: must_be_immutable, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import "package:universal_html/html.dart";

class LainnyaKwitansi extends StatefulWidget {
  String idPelanggan;
  LainnyaKwitansi({Key key, @required this.idPelanggan}) : super(key: key);

  @override
  State<LainnyaKwitansi> createState() => _LainnyaKwitansiState();
}

class _LainnyaKwitansiState extends State<LainnyaKwitansi> {
  List<Map<String, dynamic>> detailKwitansi = [];
  List<Map<String, dynamic>> detailEst = [];
  List<Map<String, dynamic>> detailPembayaran = [];

  void getEstimasi() async {
    var id = widget.idPelanggan;
    var response = await http.get(
        Uri.parse("$urlAddress/jamaah/jamaah/detail/info-estimasi/$id"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      detailEst = dataStatus;
    });
  }

  void getKwitansi() async {
    var id = widget.idPelanggan;
    var response = await http.get(
        Uri.parse("$urlAddress/jamaah/jamaah/lainnya/kwitansi/$id"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      detailKwitansi = dataStatus;
    });
  }

  @override
  void initState() {
    getKwitansi();
    getEstimasi();
    super.initState();
  }

  fncPrintKwitansi(noKwitansi, noPelanggan, namaPelanggan, jumlahBayar,
      detBayar, mataUang) async {
    final pdf = pw.Document();
    ByteData byteData =
        await rootBundle.load('assets/images/head-kwitansi.png');
    Uint8List logoByte = byteData.buffer.asUint8List();
    final netImage = pw.MemoryImage(logoByte);
    // final font = await rootBundle.load("assets/fonts/open-sans.ttf");
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    int x = 1;
    // final ttf = pw.Font.ttf(font);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a6,
        orientation: pw.PageOrientation.landscape,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Wrap(
              children: <pw.Widget>[
                pw.Container(
                    width: PdfPageFormat.a6.height,
                    child: pw.Container(
                        child: pw.Column(
                      children: [
                        pw.Row(
                          children: [
                            pw.Container(
                                width: 250,
                                height: 60,
                                // color: PdfColors.blue,
                                child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.SizedBox(
                                      height: 40,
                                      child: pw.Image(netImage),
                                    ),
                                    pw.Text(
                                        'Jl.Sutaatmaja RT.69 RW.09 Kel. Cigadung - Subang Telp. (0260) 4240159',
                                        style: const pw.TextStyle(fontSize: 6)),
                                    pw.Text(
                                        'HP. 081222700300 e-mail : cahayaraudhahsubang@yahoo.com',
                                        style: const pw.TextStyle(fontSize: 6)),
                                  ],
                                )),
                            pw.SizedBox(width: 10),
                            pw.Container(
                                width: 105,
                                height: 60,
                                // color: PdfColors.red,
                                child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                                  children: [
                                    pw.Text('KWITANSI',
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 15,
                                            color: PdfColors.red800)),
                                    pw.SizedBox(height: 15),
                                    pw.Container(
                                      width: 110,
                                      height: 20,
                                      padding: const pw.EdgeInsets.all(4),
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            color: PdfColors.red800),
                                        borderRadius:
                                            const pw.BorderRadius.only(
                                          topRight: pw.Radius.circular(5),
                                          bottomLeft: pw.Radius.circular(5),
                                        ),
                                      ),
                                      child:
                                          pw.Text('No Kwitansi : $noKwitansi',
                                              style: pw.TextStyle(
                                                fontSize: 7,
                                                color: PdfColors.red800,
                                                fontWeight: pw.FontWeight.bold,
                                              )),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        pw.Container(
                            width: 365,
                            height: 16,
                            padding: const pw.EdgeInsets.all(4),
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.red800),
                            ),
                            child: pw.Text('Sudah Terima Dari : $namaPelanggan',
                                style: pw.TextStyle(
                                  fontSize: 7,
                                  color: PdfColors.red800,
                                  fontWeight: pw.FontWeight.bold,
                                ))),
                        pw.SizedBox(height: 5),
                        pw.Container(
                            width: 365,
                            height: 16,
                            padding: const pw.EdgeInsets.all(4),
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.red800),
                            ),
                            child: pw.Text(
                                'Uang Sebesar $mataUang : ${myFormat.format(jumlahBayar)}',
                                style: pw.TextStyle(
                                  fontSize: 7,
                                  color: PdfColors.red800,
                                  fontWeight: pw.FontWeight.bold,
                                ))),
                        pw.SizedBox(height: 5),
                        pw.Container(
                            width: 365,
                            height: 80,
                            padding: const pw.EdgeInsets.all(4),
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.red800),
                            ),
                            child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('Untuk Pembayaran :',
                                      style: pw.TextStyle(
                                        fontSize: 7,
                                        color: PdfColors.red800,
                                        fontWeight: pw.FontWeight.bold,
                                      )),
                                  pw.SizedBox(height: 5),
                                  pw.Table.fromTextArray(
                                    cellHeight: 8,
                                    cellPadding: const pw.EdgeInsets.symmetric(
                                        horizontal: 5),
                                    cellStyle: const pw.TextStyle(fontSize: 5),
                                    border: pw.TableBorder.all(
                                        color: PdfColors.white),
                                    columnWidths: {
                                      0: const pw.FlexColumnWidth(0.5),
                                      1: const pw.FlexColumnWidth(2),
                                      2: const pw.FlexColumnWidth(0.5),
                                      3: const pw.FlexColumnWidth(4),
                                    },
                                    headers: [],
                                    data: <List>[
                                      for (var j = 0; j < detBayar.length; j++)
                                        [
                                          '${x++}.',
                                          detBayar[j]['JENS_TGIH'].toString(),
                                          ':',
                                          myFormat.format(int.parse(detBayar[j]
                                                  ['JMLX_BYAR']
                                              .toString())),
                                        ]
                                    ],
                                  ),
                                ])),
                        pw.SizedBox(height: 7),
                        pw.Row(children: [
                          pw.SizedBox(
                              width: 100,
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Text('PT. Cahaya Raudhah',
                                      style: pw.TextStyle(
                                        fontSize: 7,
                                        color: PdfColors.blue800,
                                        fontWeight: pw.FontWeight.bold,
                                      )),
                                  pw.Text('Penerima',
                                      style: const pw.TextStyle(
                                        fontSize: 7,
                                        color: PdfColors.blue800,
                                      )),
                                  pw.SizedBox(height: 25),
                                  pw.Text('(............................)',
                                      style: const pw.TextStyle(
                                        fontSize: 7,
                                        color: PdfColors.blue800,
                                      )),
                                ],
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.SizedBox(
                              width: 100,
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Text('Checker',
                                      style: pw.TextStyle(
                                        fontSize: 7,
                                        color: PdfColors.blue800,
                                        fontWeight: pw.FontWeight.bold,
                                      )),
                                  pw.SizedBox(height: 32),
                                  pw.Text('(............................)',
                                      style: const pw.TextStyle(
                                        fontSize: 7,
                                        color: PdfColors.blue800,
                                      )),
                                ],
                              )),
                        ])
                      ],
                    ))),
              ],
            ),
          ];
        },
      ),
    );

    Uint8List bytes = await pdf.save();
    //Dispose the document
    // document.dispose();
    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "kwitansi_$noKwitansi.pdf")
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    int x = 1;
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    final styleCustom = TextStyle(color: myGrey, fontWeight: FontWeight.bold);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: DataTable(
                  border: TableBorder.all(color: Colors.grey),
                  columns: [
                    const DataColumn(label: Text('Uang Masuk : ')),
                    DataColumn(
                        label: Text(detailEst.isNotEmpty
                            ? myFormat.format(detailEst[0]['UANG_MASUK'] ?? 0)
                            : '0')),
                    const DataColumn(label: Text('Sisa Bayar : ')),
                    DataColumn(
                        label: Text(detailEst.isNotEmpty
                            ? myFormat.format(detailEst[0]['SISA_TAGIHAN'] ?? 0)
                            : '0')),
                    DataColumn(
                        label: Text(detailEst.isNotEmpty
                            ? detailEst[0]['STS_LUNAS']
                            : '-')),
                  ],
                  rows: const []),
            ),
            const SizedBox(height: 10),
            const Text('List Kwitansi',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DataTable(
              border: TableBorder.all(color: Colors.grey),
              columns: [
                DataColumn(label: Text('No.', style: styleCustom)),
                DataColumn(label: Text('Faktur', style: styleCustom)),
                DataColumn(label: Text('Operasional', style: styleCustom)),
                DataColumn(label: Text('Bayar', style: styleCustom)),
                DataColumn(label: Text('Cara Bayar', style: styleCustom)),
                // DataColumn(label: Text('Bank', style: styleCustom)),
                DataColumn(label: Text('Keterangan', style: styleCustom)),
                DataColumn(label: Text('Print', style: styleCustom))
              ],
              rows: detailKwitansi.map((e) {
                return DataRow(cells: [
                  DataCell(Text((x++).toString())),
                  DataCell(Text(e['NOXX_FAKT'] ?? '-')),
                  DataCell(Text(e['CRTX_DATE'] ?? '-')),
                  DataCell(Text(myFormat.format(e['JMLH_BYAR'] ?? 0))),
                  // DataCell(Text(e['CARA_BYAR'] ?? '-')),
                  DataCell(Text(e['NAMA_BANK'] ?? '-')),
                  DataCell(Text(e['KETERANGAN'] ?? '-')),
                  DataCell(
                    ElevatedButton.icon(
                      onPressed: () async {
                        var id = widget.idPelanggan;
                        var response = await http.get(
                            Uri.parse(
                                "$urlAddress/jamaah/jamaah/lainnya/kwitansi-detail/$id"),
                            headers: {
                              'pte-token': kodeToken,
                            });
                        List<Map<String, dynamic>> dataStatus =
                            List.from(json.decode(response.body) as List);

                        fncPrintKwitansi(
                            e['NOXX_FAKT'],
                            e['KDXX_DFTR'],
                            e['NAMA_LGKP'],
                            e['JMLH_BYAR'],
                            dataStatus,
                            dataStatus[0]['MATA_UANG']);
                      },
                      icon: const Icon(Icons.article_outlined),
                      style: fncButtonAuthStyle(authPrnt, context),
                      label: fncLabelButtonStyle('Print Kwitansi', context),
                    ),
                  ),
                ]);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
