import 'dart:io';
import 'dart:convert';
import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PrintAgency extends StatelessWidget {
  final List<Map<String, dynamic>> listAgency;

  const PrintAgency({
    Key key,
    @required this.listAgency,
  }) : super(key: key);

  // void getPDF() async {
  //   // final pdf = pw.Document();
  //   // final font = await rootBundle.load("assets/fonts/open-sans.ttf");
  //   // final ttf = pw.Font.ttf(font);

  //   // pdf.addPage(pw.Page(
  //   //     pageFormat: PdfPageFormat.a4,
  //   //     build: (pw.Context context) {
  //   //       return pw.Center(
  //   //         child: pw.Text("Hello World",
  //   //             style: pw.TextStyle(fontSize: 20, font: ttf)),
  //   //       );
  //   //     }));

  //   // print('Print');

  //   // Uint8List bytes = await pdf.save();

  //   // final dir = await getApplicationDocumentsDirectory();

  //   // final file = File('${dir.path}/mydocument.pdf');

  //   // await file.writeAsBytes(bytes);

  //   // print(dir);

  //   // await OpenFile.open(file.path);
  // }

  Future<void> _createPDF() async {
    //Create a PDF document.
    // PdfDocument document = PdfDocument();
    // //Add a page and draw text
    // document.pages.add().graphics.drawString(
    //     'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 20),
    //     brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    //     bounds: Rect.fromLTWH(20, 60, 150, 30));
    // //Save the document
    // List<int> bytes = await document.save();

    final pdf = pw.Document();
    final font = await rootBundle.load("assets/fonts/open-sans.ttf");
    final ttf = pw.Font.ttf(font);
    int x = 1;
    int pages = (listAgency.length / 26).toInt() + 1;
    int arrData = 0;
    int maxData = listAgency.length;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.portrait,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        build: (pw.Context context) {
          return <pw.Widget>[
            for (var a = 1; a <= pages; a++)
              pw.Wrap(
                children: <pw.Widget>[
                  pw.Container(
                      width: PdfPageFormat.a4.width,
                      child: pw.Container(
                          child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Laporan Daftar Agency',
                              style: pw.TextStyle(fontSize: 18, font: ttf)),
                          pw.SizedBox(height: 20),
                          pw.Table.fromTextArray(
                              cellPadding: const pw.EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 1),
                              headers: [
                                'No.',
                                'ID Marketing',
                                'Nama',
                                'Fee',
                                'Per',
                                'Ttl',
                                'Poin',
                              ],
                              data: <List>[
                                for (var i = (arrData + ((a - 1) * 40));
                                    i < (a != pages ? (a * 40) : maxData);
                                    i++)
                                  [
                                    (x++).toString(),
                                    listAgency[i]['KDXX_MRKT'].toString(),
                                    listAgency[i]['NAMA_LGKP'].toString(),
                                    listAgency[i]['FEE'].toString(),
                                    listAgency[i]['PERD_JMAH'].toString(),
                                    listAgency[i]['TOTL_JMAH'].toString(),
                                    listAgency[i]['TOTL_POIN'].toString(),
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

    // final datas = listAgency.map((e) {
    //   return [
    //     'wkwkwkw',
    //     'wkwkwkw',
    //     'wkwkwkw',
    //   ].toList();
    // }).toList();

    // final wk = [
    //   for (var i = 0; i < listAgency.length; i++)
    //     [
    //       'wkwkwkw',
    //       'wkwkwkw',
    //       'wkwkwkw',
    //     ]
    // ];

    // final List<List<dynamic>> datas = [...data];

    // print(datas);
    // print(listAgency.length);

    // pdf.addPage(pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     build: (pw.Context context) {
    //       return pw.Container(
    //           padding: const pw.EdgeInsets.all(10),
    //           child: pw.Column(
    //             children: [
    //               pw.Text('Daftar Agency',
    //                   style: pw.TextStyle(fontSize: 10, font: ttf)),
    //               pw.SizedBox(height: 10),
    //               pw.Table(
    //                   border: pw.TableBorder.all(),
    //                   children: listAgency.map(
    //                     (e) {
    //                       return pw.TableRow(children: [
    //                         pw.Padding(
    //                             padding: const pw.EdgeInsets.all(2),
    //                             child: pw.Center(
    //                                 child: pw.Text((x++).toString(),
    //                                     style: pw.TextStyle(
    //                                         fontSize: 7, font: ttf)))),
    //                         pw.Padding(
    //                             padding: const pw.EdgeInsets.all(2),
    //                             child: pw.Center(
    //                                 child: pw.Text(e['id_marketing'].toString(),
    //                                     style: pw.TextStyle(
    //                                         fontSize: 7, font: ttf)))),
    //                         pw.Padding(
    //                             padding: const pw.EdgeInsets.all(2),
    //                             child: pw.Center(
    //                                 child: pw.Text(e['nama_lengkap'].toString(),
    //                                     style: pw.TextStyle(
    //                                         fontSize: 7, font: ttf)))),
    //                         pw.Padding(
    //                             padding: const pw.EdgeInsets.all(2),
    //                             child: pw.Center(
    //                                 child: pw.Text(e['mk'].toString(),
    //                                     style: pw.TextStyle(
    //                                         fontSize: 7, font: ttf)))),
    //                         pw.Padding(
    //                             padding: const pw.EdgeInsets.all(2),
    //                             child: pw.Center(
    //                                 child: pw.Text(
    //                                     '${e['periode_pelanggan']} Periode',
    //                                     style: pw.TextStyle(
    //                                         fontSize: 7, font: ttf)))),
    //                         pw.Padding(
    //                             padding: const pw.EdgeInsets.all(2),
    //                             child: pw.Center(
    //                                 child: pw.Text(
    //                                     '${e['total_pelanggan']} Pelanggan',
    //                                     style: pw.TextStyle(
    //                                         fontSize: 7, font: ttf)))),
    //                         pw.Padding(
    //                             padding: const pw.EdgeInsets.all(2),
    //                             child: pw.Center(
    //                                 child: pw.Text('${e['poin']} Poin',
    //                                     style: pw.TextStyle(
    //                                         fontSize: 7, font: ttf)))),
    //                       ]);
    //                     },
    //                   ).toList())
    //             ],
    //           ));
    //     }));
    // print('Print');

    Uint8List bytes = await pdf.save();
    //Dispose the document
    // document.dispose();
    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "daftar_agency.pdf")
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        authPrnt == '1'
            ? _createPDF()
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
      icon: const Icon(Icons.print_outlined),
      label: const Text(
        'Print',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: authPrnt == '1' ? myBlue : Colors.blue[200],
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }
}
