// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_edit_jadwal.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/modal_menu_pelanggan.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_edit_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jadwal.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_upload_jamaah.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:intl/intl.dart';

class ButtonEdit extends StatelessWidget {
  String idPelanggan;
  String namaPelanggan;
  ButtonEdit(
      {Key key, @required this.idPelanggan, @required this.namaPelanggan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.info_outline,
        color: authAddx == '1' ? myBlue : Colors.blue[200],
      ),
      onPressed: () {
        authAddx == '1'
            ? showDialog(
                context: context,
                builder: (context) => ModalMenuPelanggan(
                      idPelanggan: idPelanggan,
                      namaPelanggan: namaPelanggan,
                    ))
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> dataPelanggan;
  MyData(this.dataPelanggan);

  @override
  DataRow getRow(int index) {
    // NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(), style: styleRowReguler)),
      DataCell(Icon(
          dataPelanggan[index]['STS_BRGKT'] == 0
              ? Icons.access_alarm_outlined
              : Icons.check,
          color: dataPelanggan[index]['STS_BRGKT'] == 0
              ? Colors.orange[800]
              : Colors.green)),
      DataCell(Text(dataPelanggan[index]['KDXX_DFTR'].toString(),
          style: styleRowReguler)),
      DataCell(Text(dataPelanggan[index]['NAMA_LGKP'], style: styleRowReguler)),
      DataCell(Text(dataPelanggan[index]['JENS_KLMN'], style: styleRowReguler)),
      DataCell(Text(dataPelanggan[index]['UMUR'].toString(),
          style: styleRowReguler)),
      DataCell(Text(dataPelanggan[index]['BERANGKAT'] ?? '-',
          style: styleRowReguler)),
      DataCell(Text(
          dataPelanggan[index]['PASPORAN'] == 'BELUM' ? 'BELUM' : 'PASPORAN',
          style: styleRowReguler)),
      // DataCell(Text(dataPelanggan[index]['HANDLING'])),
      // DataCell(Text(dataPelanggan[index]['NOXX_TELP'].toString())),
      // DataCell(Text(myFormat.format(dataPelanggan[index]['UANG_MASUK']))),
      // DataCell(Text(myFormat.format(dataPelanggan[index]['SISA']))),
      // DataCell(Text(dataPelanggan[index]['NAMA_MRKT'])),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonEdit(
              idPelanggan: dataPelanggan[index]['KDXX_DFTR'].toString(),
              namaPelanggan: dataPelanggan[index]['NAMA_LGKP'],
            ),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataPelanggan.length;

  @override
  int get selectedRowCount => 0;
}

class TablePelanggan extends StatefulWidget {
  final List<Map<String, dynamic>> dataPelanggan;
  const TablePelanggan({Key key, @required this.dataPelanggan})
      : super(key: key);

  @override
  State<TablePelanggan> createState() => _TablePelangganState();
}

class _TablePelangganState extends State<TablePelanggan> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final DataTableSource myTable = MyData(widget.dataPelanggan);

    return SizedBox(
      width: screenWidth,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          columnSpacing: 17,
          source: myTable,
          columns: const [
            DataColumn(label: Text('No.', style: styleColumn)),
            DataColumn(label: Text(' ', style: styleColumn)),
            DataColumn(label: Text('ID', style: styleColumn)),
            DataColumn(label: Text('Nama', style: styleColumn)),
            DataColumn(label: Text('Jenis Kelamin', style: styleColumn)),
            DataColumn(label: Text('Umur', style: styleColumn)),
            DataColumn(label: Text('Berangkat', style: styleColumn)),
            DataColumn(label: Text('Persyaratan', style: styleColumn)),
            DataColumn(
                label: SizedBox(
                    width: 80,
                    child: Center(
                      child: Text('Aksi', style: styleColumn),
                    )))
          ],
        ),
      ),
    );
  }
}
