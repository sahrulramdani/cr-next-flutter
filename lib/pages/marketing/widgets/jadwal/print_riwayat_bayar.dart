// ignore_for_file: division_optimization

import 'dart:io';
import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_data_fail.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PrintRiwayatBayar extends StatefulWidget {
  final String keberangkatan;
  final String jenisPaket;
  final String harga;
  final String tglBgkt;
  final List<Map<String, dynamic>> listPelangganJadwal;

  const PrintRiwayatBayar({
    Key key,
    @required this.listPelangganJadwal,
    @required this.keberangkatan,
    @required this.jenisPaket,
    @required this.harga,
    @required this.tglBgkt,
  }) : super(key: key);
  @override
  State<PrintRiwayatBayar> createState() => _PrintRiwayatBayarState();
}

class _PrintRiwayatBayarState extends State<PrintRiwayatBayar> {
  List<Map<String, dynamic>> listPelanggan = [];

  Future<void> _createPDF() async {
    NumberFormat myformat = NumberFormat.decimalPattern('en_us');
    ByteData byteData =
        await rootBundle.load('assets/images/craudhah_logo_landscape.png');
    Uint8List logoByte = byteData.buffer.asUint8List();
    final netImage = pw.MemoryImage(logoByte);

    final pdf = pw.Document();
    // Nomor Urut
    int urut = 1;
    // Jumlah Halaman
    // angka kedua maksimal data dalam satu halaman
    int pages = (listPelanggan.length / 15).toInt() + 1;
    // index data dimulai
    int arrData = 0;
    // Maksimal index data
    int maxData = listPelanggan.length;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.landscape,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        build: (pw.Context context) {
          return <pw.Widget>[
            for (var a = 1; a <= pages; a++)
              pw.Wrap(
                children: <pw.Widget>[
                  pw.Container(
                      width: PdfPageFormat.a4.height,
                      child: pw.Container(
                          child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.SizedBox(
                            width: 100,
                            child: pw.Image(netImage),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text('RIWAYAT PEMBAYARAN JAMAAH',
                              style: pw.TextStyle(
                                  fontSize: 15,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text(
                              "PEMBERANGKATAN ${widget.keberangkatan} ${widget.jenisPaket} ( ${myformat.format(int.parse(widget.harga))}) )",
                              style: pw.TextStyle(
                                  fontSize: 15,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text('TOURS & TRAVEL - HAJI - UMRAH'),
                          pw.Text('Jl. SUTAATMAJA RT069/009 CIGADUNG SUBANG'),
                          pw.SizedBox(height: 20),
                          pw.Table.fromTextArray(
                              cellPadding: const pw.EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              headers: [
                                'NO.',
                                'NAMA',
                                'PASPOR',
                                'VAKSIN',
                                'HDL',
                                'TELAH BAYAR',
                                'SISA',
                              ],
                              data: <List>[
                                for (var i = (arrData + ((a - 1) * 15));
                                    i < (a != pages ? (a * 15) : maxData);
                                    i++)
                                  [
                                    (urut++).toString(),
                                    listPelanggan[i]['NAMA_LGKP'].toString(),
                                    listPelanggan[i]['PEMB_PSPR'] ==
                                            'Pembuatan Baru / Kol'
                                        ? 'KOL'
                                        : 'LAN',
                                    listPelanggan[i]['PRSS_VKSN'] ==
                                            'Kolektif Kantor'
                                        ? 'KOL'
                                        : 'SEN',
                                    listPelanggan[i]['HANDLING'] ==
                                            'Belum Diterima'
                                        ? 'BLM'
                                        : 'LGK',
                                    myformat.parse(
                                        listPelanggan[i]['MASUK'].toString()),
                                    myformat.parse(
                                        listPelanggan[i]['SISA'].toString()),
                                  ]
                              ]),
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
      ..setAttribute("download", "riwayat_pembayaran_${widget.tglBgkt}.pdf")
      ..click();
  }

  fncGetCek() {
    listPelanggan = [];

    for (var i = 0; i < widget.listPelangganJadwal.length; i++) {
      if (widget.listPelangganJadwal[i]['CEK'] == true) {
        listPelanggan.add(widget.listPelangganJadwal[i]);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        await fncGetCek();

        if (listPelanggan.isNotEmpty) {
          _createPDF();
        } else {
          showDialog(
              context: context, builder: (context) => const ModalDataFail());
        }
      },
      icon: const Icon(Icons.payments_outlined),
      label: const Text(
        'Riwayat Pembayaran',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }
}
