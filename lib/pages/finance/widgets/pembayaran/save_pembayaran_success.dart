import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_data_fail.dart';
import 'package:intl/intl.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ModalSavePembayaranSuccess extends StatefulWidget {
  String noKwitansi;
  String noPelanggan;
  String namaPelanggan;
  String jumlahBayar;
  String mataUang;
  List<Map<String, dynamic>> detailPembayaran = [];

  ModalSavePembayaranSuccess({
    Key key,
    @required this.noKwitansi,
    @required this.noPelanggan,
    @required this.namaPelanggan,
    @required this.jumlahBayar,
    @required this.mataUang,
    @required this.detailPembayaran,
  }) : super(key: key);

  @override
  State<ModalSavePembayaranSuccess> createState() =>
      _ModalSavePembayaranSuccessState();
}

class _ModalSavePembayaranSuccessState
    extends State<ModalSavePembayaranSuccess> {
  fncPrintKwitansi() async {
    List<Map<String, dynamic>> listTagihanBayar = widget.detailPembayaran;

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
                                      child: pw.Text(
                                          'No Kwitansi : ${widget.noKwitansi}',
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
                            child: pw.Text(
                                'Sudah Terima Dari : ${widget.namaPelanggan}',
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
                              'Uang Sebesar ${widget.mataUang} : ${myFormat.format(int.parse(widget.jumlahBayar))}',
                              style: pw.TextStyle(
                                fontSize: 7,
                                color: PdfColors.red800,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            )),
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
                                      for (var j = 0;
                                          j < listTagihanBayar.length;
                                          j++)
                                        [
                                          '${x++}.',
                                          listTagihanBayar[j]['"JENS_TGIH"']
                                              .toString()
                                              .replaceAll('"', ''),
                                          ':',
                                          myFormat.format(int.parse(
                                              listTagihanBayar[j]['"JMLX_BYAR"']
                                                  .toString()
                                                  .replaceAll('"', ''))),
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
      ..setAttribute("download", "kwitansi_${widget.noKwitansi}.pdf")
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: 330,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_box_rounded,
                color: Colors.green,
                size: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              const FittedBox(
                child: Text('Data Berhasil Disimpan',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              const SizedBox(
                height: 5,
              ),
              const FittedBox(
                child: Text('Silahkan Print Kwitansi dan kembali ke halaman',
                    style: TextStyle(fontSize: 10)),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      fncPrintKwitansi();
                    },
                    icon: const Icon(Icons.article_outlined),
                    style: fncButtonAuthStyle(authPrnt, context),
                    label: fncLabelButtonStyle('Print Kwitansi', context),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: fncButtonRegulerStyle(context),
                      child: const Text('Kembali')),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
