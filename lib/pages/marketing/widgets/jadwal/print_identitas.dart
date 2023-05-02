// ignore_for_file: division_optimization

import 'dart:io';
import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

class PrintIdentitas extends StatefulWidget {
  final String keberangkatan;
  final String jenisPaket;
  final String tglBgkt;
  final List<Map<String, dynamic>> listPelangganJadwal;

  const PrintIdentitas({
    Key key,
    @required this.listPelangganJadwal,
    @required this.keberangkatan,
    @required this.jenisPaket,
    @required this.tglBgkt,
  }) : super(key: key);
  @override
  State<PrintIdentitas> createState() => _PrintIdentitasState();
}

class _PrintIdentitasState extends State<PrintIdentitas> {
  List<Map<String, dynamic>> listPelanggan = [];

  Future<void> _createPDF() async {
    ByteData byteData =
        await rootBundle.load('assets/images/craudhah_logo_landscape.png');
    Uint8List logoByte = byteData.buffer.asUint8List();
    final netImage = pw.MemoryImage(logoByte);

    final pdf = pw.Document();
    // Nomor Urut
    int urut = 1;
    // Jumlah Halaman
    // angka kedua maksimal data dalam satu halaman
    int pages = (listPelanggan.length / 5).toInt() + 1;
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
                          pw.Text(
                              "DATA JAMAAH ${widget.keberangkatan} ${widget.jenisPaket} )}) )",
                              style: pw.TextStyle(
                                  fontSize: 15,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text('TOURS & TRAVEL - HAJI - UMRAH'),
                          pw.Text('Jl. SUTAATMAJA RT069/009 CIGADUNG SUBANG'),
                          pw.SizedBox(height: 20),
                          pw.Table.fromTextArray(
                              cellStyle: const pw.TextStyle(fontSize: 10),
                              cellPadding: const pw.EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              columnWidths: {
                                0: const pw.FlexColumnWidth(1),
                                1: const pw.FlexColumnWidth(3),
                                2: const pw.FlexColumnWidth(2),
                                3: const pw.FlexColumnWidth(2),
                                4: const pw.FlexColumnWidth(3),
                                5: const pw.FlexColumnWidth(7),
                                6: const pw.FlexColumnWidth(2),
                                7: const pw.FlexColumnWidth(3),
                              },
                              headers: [
                                'NO.',
                                'NIK.',
                                'NAMA',
                                'AYAH',
                                'TTL',
                                'ALAMAT LENGKAP',
                                'FOTO',
                                'NO HP / WA',
                              ],
                              data: <List>[
                                for (var i = (arrData + ((a - 1) * 5));
                                    i < (a != pages ? (a * 5) : maxData);
                                    i++)
                                  [
                                    (urut++).toString(),
                                    "${listPelanggan[i]['NOXX_IDNT'] ?? '-'}",
                                    listPelanggan[i]['NAMA_LGKP'].toString(),
                                    listPelanggan[i]['NAMA_AYAH'].toString(),
                                    "${listPelanggan[i]['TMPT_LHIR']}, ${fncGetTanggal(DateFormat("dd-MM-yyyy").format(DateTime.parse(listPelanggan[(a - 1)]['TGLX_LHIR'])))}",
                                    "${listPelanggan[i]['ALAMAT']} - ${listPelanggan[i]['KDXX_KELX']} - ${listPelanggan[i]['KDXX_KECX']} - ${listPelanggan[i]['KDXX_KOTA']} - ${listPelanggan[i]['KDXX_PROV']} [ ${listPelanggan[i]['KDXX_POSX']} ]",
                                    listPelanggan[i]['FOTO_JMAH'] != ''
                                        ? 'Sudah'
                                        : 'Belum',
                                    listPelanggan[i]['NOXX_TELP'].toString(),
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
      ..setAttribute("download", "identitas_jamaah_${widget.tglBgkt}.pdf")
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
      icon: const Icon(Icons.assignment_ind_outlined),
      style: fncButtonAuthStyle(authPrnt, context),
      label: fncLabelButtonStyle('Identitas', context),
    );
  }
}
