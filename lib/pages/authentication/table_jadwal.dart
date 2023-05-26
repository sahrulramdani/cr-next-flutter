// ignore_for_file: must_be_immutable, prefer_const_constructors, avoid_print, unused_import, unused_local_variable, non_constant_identifier_names, prefer_if_null_operators, sized_box_for_whitespace, missing_required_param

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_edit_jadwal.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_edit_jamaah.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_hapus_jadwal.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_detail_jadwal.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_upload_jamaah.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ButtonDetail extends StatelessWidget {
  String idJadwal;
  String keberangkatan;
  String jenisPaket;
  String harga;
  String tglBgkt;
  String tglPlng;
  ButtonDetail(
      {Key key,
      this.idJadwal,
      this.keberangkatan,
      this.jenisPaket,
      this.harga,
      this.tglBgkt,
      this.tglPlng})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.info_outline,
        color: myBlue,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ModalDetailJadwal(
                  idJadwal: idJadwal,
                  keberangkatan: keberangkatan,
                  jenisPaket: jenisPaket,
                  harga: harga,
                  tglBgkt: tglBgkt,
                  tglPlng: tglPlng,
                ));
      },
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> dataJadwal;
  MyData(this.dataJadwal);
  int x = 1;

  @override
  DataRow getRow(int index) {
    NumberFormat myformat = NumberFormat.decimalPattern('en_us');
    var Tanggal = (DateFormat("dd-MM-yyyy").format(DateTime.now())).toString();
    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text(fncGetTanggal(dataJadwal[index]['TGLX_BGKT'].toString()))),
      DataCell(Text(dataJadwal[index]['NAME_PESWT_BGKT'])),
      DataCell(Text(dataJadwal[index]['RUTE_AKHR_BRKT'] == null
          ? ""
          : "${dataJadwal[index]['RUTE_AKHR_BRKT'].toString()} - ${dataJadwal[index]['RUTE_AWAL_PLNG'].toString()}")),
      DataCell(Center(
          child: Text(
        dataJadwal[index]["CODD_DESC"] == null
            ? "-"
            : "*${dataJadwal[index]["CODD_DESC"].toString()}",
      ))),
      DataCell(Center(
        child: Text(
            "${myformat.format(int.parse(dataJadwal[index]['TARIF_PKET'].toString()) / 1000000)} Juta"),
      )),
      DataCell(Text(dataJadwal[index]['JMLX_SEAT'] == null
          ? "-"
          : dataJadwal[index]['JMLX_SEAT'].toString())),
      DataCell(Text(dataJadwal[index]['TERISI'].toString())),
      DataCell(Text(dataJadwal[index]['SISA'] == 0
          ? 'Full'
          : dataJadwal[index]['SISA'].toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataJadwal.length;

  @override
  int get selectedRowCount => 0;
}

class TableJadwalDashboard extends StatefulWidget {
  final List<Map<String, dynamic>> dataJadwal;
  bool show;
  TableJadwalDashboard(
      {Key key, @required this.dataJadwal, @required this.show})
      : super(key: key);

  @override
  State<TableJadwalDashboard> createState() => _TableJadwalDashboardState();
}

class _TableJadwalDashboardState extends State<TableJadwalDashboard> {
  Widget datatableLogin(row, col) {
    int y = 1;
    NumberFormat myformat = NumberFormat.decimalPattern('en_us');
    bool show = widget.show;
    double fontSizeHeader = 0;
    double fontSizeRow = 0;
    double spacingTable = 0;
    if (show == true) {
      fontSizeHeader = 22;
      fontSizeRow = 20;
      spacingTable = 30;
    } else {
      fontSizeHeader = 16;
      fontSizeRow = 17;
      spacingTable = 18;
    }

    final tbLoginColumnStyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'Gilroy',
        fontSize: fontSizeHeader);
    final tbLoginRowStyle = TextStyle(
        color: Color.fromARGB(249, 48, 50, 51),
        fontWeight: FontWeight.bold,
        fontSize: fontSizeRow);

    return DataTable(
      columnSpacing: spacingTable,
      dataRowColor: MaterialStateColor.resolveWith(
          (states) => Color.fromARGB(189, 231, 231, 231)),
      headingRowColor: MaterialStateColor.resolveWith(
          (states) => Color.fromARGB(255, 33, 149, 243)),
      dataRowHeight: row,
      headingRowHeight: col,
      columns: [
        DataColumn(
            label: Expanded(
          child: Center(
            child: Text('No.',
                textAlign: TextAlign.center, style: tbLoginColumnStyle),
          ),
        )),
        DataColumn(
            label: Expanded(
          child: Center(
            child: Text('Keberangkatan', style: tbLoginColumnStyle),
          ),
        )),
        DataColumn(
            label: Expanded(
          child: Center(
            child: Text('Pesawat',
                textAlign: TextAlign.center, style: tbLoginColumnStyle),
          ),
        )),
        DataColumn(
            label: Expanded(
          child: Center(
            child: Text('Rute', style: tbLoginColumnStyle),
          ),
        )),
        DataColumn(
            label: Expanded(
          child: Center(
            child: Text('Hotel', style: tbLoginColumnStyle),
          ),
        )),
        DataColumn(
            label: Expanded(
          child: Center(
            child: Text('Harga', style: tbLoginColumnStyle),
          ),
        )),
        DataColumn(
            label: Expanded(
          child: Center(
            child: Text('Seat', style: tbLoginColumnStyle),
          ),
        )),
        DataColumn(
            label: Expanded(
          child: Center(
            child: Text('Terisi', style: tbLoginColumnStyle),
          ),
        )),
        DataColumn(
            label: Expanded(
          child: Center(
            child: Text('Sisa', style: tbLoginColumnStyle),
          ),
        )),
      ],
      rows: widget.dataJadwal.map((e) {
        return DataRow(cells: [
          DataCell(Center(
            child: Text(
              (y++).toString(),
              style: tbLoginRowStyle,
            ),
          )),
          DataCell(Center(
            child: Text(
              fncGetTanggal(e['TGLX_BGKT'].toString()),
              style: tbLoginRowStyle,
            ),
          )),
          DataCell(Center(
            child: Text(
              e['NAME_PESWT_BGKT'] == null
                  ? "-"
                  : e['NAME_PESWT_BGKT'].toString(),
              style: tbLoginRowStyle,
            ),
          )),
          DataCell(Center(
            child: Text(
              e['KETX_RUTE'] ?? '-',
              style: tbLoginRowStyle,
            ),
          )),
          col == 50
              ? DataCell(Center(
                  child: Row(
                    children: [
                      Text(""),
                      Center(
                          child: Text(
                        e["KETX_HTLX"] == null
                            ? "-"
                            : e["KETX_HTLX"].toString(),
                        style: tbLoginRowStyle,
                      )),
                    ],
                  ),
                ))
              : DataCell(Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 15,
                      color: Color.fromARGB(248, 213, 192, 0),
                    ),
                    Text(
                      e["KETX_HTLX"] == null ? "-" : e["KETX_HTLX"].toString(),
                      style: tbLoginRowStyle,
                    ),
                  ],
                )),
          DataCell(Center(
            child: Text(
              e['MATA_UANG'] == 'IDR'
                  ? "${myformat.format(int.parse(e['TARIF_PKET'].toString()) / 1000000)} Juta"
                  : "\$ ${myformat.format(int.parse(e['TARIF_PKET'].toString()) / 1000)} Ribu",
              style: tbLoginRowStyle,
            ),
          )),
          DataCell(Center(
            child: Text(
              e['JMLX_SEAT'] == null ? "-" : e['JMLX_SEAT'].toString(),
              style: tbLoginRowStyle,
            ),
          )),
          DataCell(Center(
            child: Text(
              e['TERISI'].toString(),
              style: tbLoginRowStyle,
            ),
          )),
          DataCell(Center(
            child: Text(
              e['SISA'] == 0 ? 'Full' : e['SISA'].toString(),
              style: tbLoginRowStyle,
            ),
          )),
        ]);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    int x = 1;

    return Align(
      child: Container(
        alignment: Alignment.center,
        width: screenWidth * 1,
        height: 0.45 * screenHeight,
        child: Column(children: [
          datatableLogin(0, 50),
          Expanded(
              child: CupertinoScrollbar(
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [datatableLogin(50, 0)]),
                    ),
                  )))
        ]),
      ),
    );
  }
}
