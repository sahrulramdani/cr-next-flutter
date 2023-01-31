// ignore_for_file: must_be_immutable

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
// import 'package:intl/intl.dart';

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
  ButtonEdit({Key key, @required this.idJadwal}) : super(key: key);

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
  const ButtonHapus({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete_outline,
        color: myBlue,
      ),
      onPressed: () {
        showDialog(
            context: context, builder: (context) => const ModalHapusJadwal());
      },
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> dataJadwal;
  MyData(this.dataJadwal);

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Icon(
        dataJadwal[index]['status'] == '0'
            ? Icons.punch_clock_outlined
            : Icons.check,
        color: dataJadwal[index]['status'] == '0' ? Colors.red : Colors.green,
        size: 20,
      )),
      DataCell(Text(dataJadwal[index]['tipe'])),
      DataCell(Text(dataJadwal[index]['jenisna'])),
      DataCell(Text(dataJadwal[index]['jumlah_hari'])),
      DataCell(Text(dataJadwal[index]['tgi_berangkat'])),
      DataCell(Text(dataJadwal[index]['tgi_pulang'])),
      DataCell(Text(dataJadwal[index]['biaya_rp'])),
      DataCell(Text(dataJadwal[index]['mata_uang'])),
      DataCell(Text(dataJadwal[index]['sisa_seat'].toString())),
      DataCell(Text(dataJadwal[index]['tipena'])),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonDetail(
              idJadwal: dataJadwal[index]['id_jadwal'],
            ),
            const SizedBox(width: 5),
            ButtonEdit(
              idJadwal: dataJadwal[index]['id_jadwal'],
            ),
            const SizedBox(width: 5),
            const ButtonHapus(),
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
