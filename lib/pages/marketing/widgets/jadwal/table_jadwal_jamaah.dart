// ignore_for_file: must_be_immutable, prefer_const_constructors, avoid_print, unused_import, unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
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
  ButtonDetail({Key key, this.idJadwal}) : super(key: key);

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
            builder: (context) => ModalDetailJadwal(idJadwal: idJadwal));
      },
    );
  }
}

class ButtonEdit extends StatelessWidget {
  String idJadwal;
  ButtonEdit({
    Key key,
    @required this.idJadwal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.edit_outlined,
        color: myBlue,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ModalEditJadwal(
                  idJadwal: idJadwal,
                ));
      },
    );
  }
}

class ButtonHapus extends StatelessWidget {
  String idJadwal;
  ButtonHapus({Key key, @required this.idJadwal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete_outline,
        color: myBlue,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ModalHapusJadwal(idJadwal: idJadwal));
      },
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> dataJadwal;
  MyData(this.dataJadwal);

  @override
  DataRow getRow(int index) {
    NumberFormat myformat = NumberFormat.decimalPattern('en_us');
    var Tanggal = (DateFormat("dd-MM-yyyy").format(DateTime.now())).toString();
    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Icon(
        dataJadwal[index]['status'] == 1
            ? Icons.check
            : Icons.access_time_outlined,
        color: dataJadwal[index]['status'] == 1
            ? Colors.green
            : Colors.orange[800],
        size: 20,
      )),
      DataCell(Text(dataJadwal[index]['namaPaket'].toString())),
      DataCell(Text(dataJadwal[index]['jenisPaket'].toString())),
      DataCell(Text(dataJadwal[index]['JMLX_HARI'].toString())),
      DataCell(Text(dataJadwal[index]['TGLX_BGKT'] == null
          ? "00-00-0000"
          : dataJadwal[index]['TGLX_BGKT'].toString())),
      DataCell(Text(dataJadwal[index]["TGLX_PLNG"] == null
          ? "00-00-0000"
          : dataJadwal[index]["TGLX_PLNG"].toString())),
      DataCell(Text(myformat
          .format(int.parse(dataJadwal[index]['TARIF_PKET'].toString())))),
      DataCell(Text(dataJadwal[index]['MATA_UANG'].toString())),
      DataCell(Text("0")),
      DataCell(Text(dataJadwal[index]['KETERANGAN'])),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonDetail(
              idJadwal: dataJadwal[index]['IDXX_JDWL'],
            ),
            const SizedBox(width: 5),
            ButtonEdit(
              idJadwal: dataJadwal[index]['IDXX_JDWL'].toString(),
            ),
            const SizedBox(width: 5),
            ButtonHapus(
              idJadwal: dataJadwal[index]['IDXX_JDWL'].toString(),
            ),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataJadwal.length;

  @override
  int get selectedRowCount => 0;
}

class TableJadwalJamaah extends StatefulWidget {
  final List<Map<String, dynamic>> dataJadwal;
  const TableJadwalJamaah({Key key, @required this.dataJadwal})
      : super(key: key);

  @override
  State<TableJadwalJamaah> createState() => _TableJadwalJamaahState();
}

class _TableJadwalJamaahState extends State<TableJadwalJamaah> {
  @override
  Widget build(BuildContext context) {
    final DataTableSource myTable = MyData(widget.dataJadwal);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth,
      height: 0.41 * screenHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          columnSpacing: 5.0,
          source: myTable,
          columns: [
            DataColumn(
                label: Text('No.',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('#',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Paket',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Jenis',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Hari',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Berangkat',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Pulang',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Tarif',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('MU',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Sisa',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Keterangan',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: SizedBox(
                    width: 80,
                    child: Center(
                      child: Text('Aksi',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy',
                              fontSize: 16)),
                    )))
          ],
        ),
      ),
    );
  }
}
