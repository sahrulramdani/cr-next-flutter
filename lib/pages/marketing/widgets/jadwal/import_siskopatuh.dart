// ignore_for_file: unused_element, avoid_web_libraries_in_flutter, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_data_fail.dart';
import 'dart:convert';
import "package:universal_html/html.dart";
import 'package:flutter_web_course/constants/style.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ImportSiskopatuh extends StatefulWidget {
  final List<Map<String, dynamic>> listPelangganJadwal;
  String tglBgkt;

  ImportSiskopatuh({
    Key key,
    @required this.listPelangganJadwal,
    @required this.tglBgkt,
  }) : super(key: key);

  @override
  State<ImportSiskopatuh> createState() => _ImportSiskopatuhState();
}

class _ImportSiskopatuhState extends State<ImportSiskopatuh> {
  List<Map<String, dynamic>> listPelanggan = [];

  Future<void> _createExport() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A1').setText('NO');
    sheet.getRangeByName('B1').setText('TITLE ');
    sheet.getRangeByName('C1').setText('NAMA ');
    sheet.getRangeByName('D1').setText('NAMA AYAH ');
    sheet.getRangeByName('E1').setText('JENIS IDENTITAS ');
    sheet.getRangeByName('F1').setText('NO IDENTITAS ');
    sheet.getRangeByName('G1').setText('NAMA PASPOR');
    sheet.getRangeByName('H1').setText('NO PASPOR');
    sheet.getRangeByName('I1').setText('TANGGAL DIKELUARKAN PASPOR');
    sheet.getRangeByName('J1').setText('KOTA PASPOR');
    sheet.getRangeByName('K1').setText('TEMPAT LAHIR');
    sheet.getRangeByName('L1').setText('TANGGAL LAHIR');
    sheet.getRangeByName('M1').setText('ALAMAT');
    sheet.getRangeByName('N1').setText('PROVINSI');
    sheet.getRangeByName('O1').setText('KABUPATEN');
    sheet.getRangeByName('P1').setText('KECAMATAN');
    sheet.getRangeByName('Q1').setText('KELURAHAN');
    sheet.getRangeByName('R1').setText('NO TELPON');
    sheet.getRangeByName('S1').setText('NO HP');
    sheet.getRangeByName('T1').setText('KEWARGANEGARAAN');
    sheet.getRangeByName('U1').setText('STATUS PERNIKAHAN');
    sheet.getRangeByName('V1').setText('PENDIDIKAN');
    sheet.getRangeByName('W1').setText('PEKERJAAN');

    int x = 2;
    int y = 1;
    for (var i = 0; i < listPelanggan.length; i++) {
      sheet.getRangeByName('A$x').setText((y++).toString());
      sheet.getRangeByName('B$x').setText('');
      sheet.getRangeByName('C$x').setText(listPelanggan[i]['NAMA_LGKP'] != null
          ? listPelanggan[i]['NAMA_LGKP'].toString()
          : '');
      sheet.getRangeByName('D$x').setText(listPelanggan[i]['NAMA_AYAH'] != null
          ? listPelanggan[i]['NAMA_AYAH'].toString()
          : '');
      sheet.getRangeByName('E$x').setText('KTP');
      sheet.getRangeByName('F$x').setText(listPelanggan[i]['NOXX_IDNT'] != null
          ? listPelanggan[i]['NOXX_IDNT'].toString()
          : '');
      sheet.getRangeByName('G$x').setText(listPelanggan[i]['NAMA_PSPR'] != null
          ? listPelanggan[i]['NAMA_PSPR'].toString()
          : '');
      sheet.getRangeByName('H$x').setText(listPelanggan[i]['NOXX_PSPR'] != null
          ? listPelanggan[i]['NOXX_PSPR'].toString()
          : '');
      sheet.getRangeByName('I$x').setText(listPelanggan[i]['TGLX_KLUR'] != null
          ? listPelanggan[i]['TGLX_KLUR'].toString()
          : '');
      sheet.getRangeByName('J$x').setText(listPelanggan[i]['KLUR_DIXX'] != null
          ? listPelanggan[i]['KLUR_DIXX'].toString()
          : '');
      sheet.getRangeByName('K$x').setText(listPelanggan[i]['TMPT_LHIR'] != null
          ? listPelanggan[i]['TMPT_LHIR'].toString()
          : '');
      sheet.getRangeByName('L$x').setText(listPelanggan[i]['TGLX_LHIR'] != null
          ? listPelanggan[i]['TGLX_LHIR'].toString()
          : '');
      sheet.getRangeByName('M$x').setText(listPelanggan[i]['ALAMAT'] != null
          ? listPelanggan[i]['ALAMAT'].toString()
          : '');
      sheet.getRangeByName('N$x').setText(listPelanggan[i]['KDXX_PROV'] != null
          ? listPelanggan[i]['KDXX_PROV'].toString()
          : '');
      sheet.getRangeByName('O$x').setText(listPelanggan[i]['KDXX_KOTA'] != null
          ? listPelanggan[i]['KDXX_KOTA'].toString()
          : '');
      sheet.getRangeByName('P$x').setText(listPelanggan[i]['KDXX_KECX'] != null
          ? listPelanggan[i]['KDXX_KECX'].toString()
          : '');
      sheet.getRangeByName('Q$x').setText(listPelanggan[i]['KDXX_KELX'] != null
          ? listPelanggan[i]['KDXX_KELX'].toString()
          : '');
      sheet.getRangeByName('R$x').setText('');
      sheet.getRangeByName('S$x').setText(listPelanggan[i]['NOXX_TELP'] != null
          ? listPelanggan[i]['NOXX_TELP'].toString()
          : '');
      sheet.getRangeByName('T$x').setText('INDONESIA');
      sheet.getRangeByName('U$x').setText(listPelanggan[i]['MENIKAH'] != null
          ? listPelanggan[i]['MENIKAH'].toString()
          : '');
      sheet.getRangeByName('V$x').setText(listPelanggan[i]['PENDIDIKAN'] != null
          ? listPelanggan[i]['PENDIDIKAN'].toString()
          : '');
      sheet.getRangeByName('W$x').setText(listPelanggan[i]['PEKERJAAN'] != null
          ? listPelanggan[i]['PEKERJAAN'].toString()
          : '');
      x++;
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "import_siskopatuh_${widget.tglBgkt}.xlsx")
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
      icon: const Icon(Icons.keyboard_double_arrow_down),
      style: fncButtonAuthStyle(authExpt, context),
      label: fncLabelButtonStyle('Export Siskopatuh', context),
    );
  }
}
