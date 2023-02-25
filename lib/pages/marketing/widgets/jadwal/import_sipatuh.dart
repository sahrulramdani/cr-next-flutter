import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_data_fail.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ImportSipatuh extends StatefulWidget {
  final List<Map<String, dynamic>> listPelangganJadwal;
  String tglBgkt;

  ImportSipatuh({
    Key key,
    @required this.listPelangganJadwal,
    @required this.tglBgkt,
  }) : super(key: key);

  @override
  State<ImportSipatuh> createState() => _ImportSipatuhState();
}

class _ImportSipatuhState extends State<ImportSipatuh> {
  List<Map<String, dynamic>> listPelanggan = [];

  Future<void> _createExport() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A1').setText('NO');
    sheet.getRangeByName('B1').setText('NIK *');
    sheet.getRangeByName('C1').setText('JENIS IDENTITAS *');
    sheet.getRangeByName('D1').setText('NAMA JAMAAH *');
    sheet.getRangeByName('E1').setText('JENIS KELAMIN *');
    sheet.getRangeByName('F1').setText('TEMPAT LAHIR *');
    sheet.getRangeByName('G1').setText('TANGGAL LAHIR *');
    sheet.getRangeByName('H1').setText('STATUS MENIKAH');
    sheet.getRangeByName('I1').setText('NO TELP');
    sheet.getRangeByName('J1').setText('EMAIL');
    sheet.getRangeByName('K1').setText('PEKERJAAN');
    sheet.getRangeByName('L1').setText('PENDIDIKAN TERAKHIR *');
    sheet.getRangeByName('M1').setText('NO PASPOR');
    sheet.getRangeByName('N1').setText('NAMA PASPOR');
    sheet.getRangeByName('O1').setText('TGL DIKELUARKAN');
    sheet.getRangeByName('P1').setText('TGL HABIS');
    sheet.getRangeByName('Q1').setText('KOTA PASPOR');
    sheet.getRangeByName('R1').setText('PILIHAN KAMAR');
    sheet.getRangeByName('S1').setText('UMUR');

    int x = 2;
    int y = 1;
    for (var i = 0; i < listPelanggan.length; i++) {
      sheet.getRangeByName('A$x').setText((y++).toString());
      sheet.getRangeByName('B$x').setText(listPelanggan[i]['NOXX_IDNT'] != null
          ? listPelanggan[i]['NOXX_IDNT'].toString()
          : '');
      sheet.getRangeByName('C$x').setText('KTP');
      sheet.getRangeByName('D$x').setText(listPelanggan[i]['NAMA_LGKP'] != null
          ? listPelanggan[i]['NAMA_LGKP'].toString()
          : '');
      sheet.getRangeByName('E$x').setText(listPelanggan[i]['JENS_KLMN'] != null
          ? listPelanggan[i]['JENS_KLMN'].toString()
          : '');
      sheet.getRangeByName('F$x').setText(listPelanggan[i]['TMPT_LHIR'] != null
          ? listPelanggan[i]['TMPT_LHIR'].toString()
          : '');
      sheet.getRangeByName('G$x').setText(listPelanggan[i]['TGLX_LHIR'] != null
          ? fncGetTanggal(DateFormat("dd-MM-yyyy")
              .format(DateTime.parse(listPelanggan[i]['TGLX_LHIR'])))
          : '');
      sheet.getRangeByName('H$x').setText(listPelanggan[i]['MENIKAH'] != null
          ? listPelanggan[i]['MENIKAH'].toString()
          : '');
      sheet.getRangeByName('I$x').setText(listPelanggan[i]['NOXX_TELP'] != null
          ? listPelanggan[i]['NOXX_TELP'].toString()
          : '');
      sheet.getRangeByName('J$x').setText('');
      sheet.getRangeByName('K$x').setText(listPelanggan[i]['PEKERJAAN'] != null
          ? listPelanggan[i]['PEKERJAAN'].toString()
          : '');
      sheet.getRangeByName('L$x').setText(listPelanggan[i]['PENDIDIKAN'] != null
          ? listPelanggan[i]['PENDIDIKAN'].toString()
          : '');
      sheet.getRangeByName('M$x').setText(listPelanggan[i]['NOXX_PSPR'] != null
          ? listPelanggan[i]['NOXX_PSPR'].toString()
          : '');
      sheet.getRangeByName('N$x').setText(listPelanggan[i]['NAMA_PSPR'] != null
          ? listPelanggan[i]['NAMA_PSPR'].toString()
          : '');
      sheet.getRangeByName('O$x').setText(listPelanggan[i]['TGLX_KLUR'] != null
          ? fncGetTanggal(DateFormat("dd-MM-yyyy")
              .format(DateTime.parse(listPelanggan[i]['TGLX_KLUR'])))
          : '');
      sheet.getRangeByName('P$x').setText(listPelanggan[i]['TGLX_EXPX'] != null
          ? fncGetTanggal(DateFormat("dd-MM-yyyy")
              .format(DateTime.parse(listPelanggan[i]['TGLX_EXPX'])))
          : '');
      sheet.getRangeByName('Q$x').setText(listPelanggan[i]['KLUR_DIXX'] != null
          ? listPelanggan[i]['KLUR_DIXX'].toString()
          : '');
      sheet.getRangeByName('R$x').setText('');
      sheet.getRangeByName('S$x').setText(listPelanggan[i]['UMUR'] != null
          ? listPelanggan[i]['UMUR'].toString()
          : '');
      x++;
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "import_sipatuh_${widget.tglBgkt}.xlsx")
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
          _createExport();
        } else {
          showDialog(
              context: context, builder: (context) => const ModalDataFail());
        }
      },
      icon: const Icon(Icons.south_outlined),
      label: const Text(
        'Export Sipatuh',
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
