// ignore_for_file: must_be_immutable, prefer_const_constructors, avoid_print, unused_import, unused_local_variable, non_constant_identifier_names, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/pages/finance/widgets/estimasi-paket/modal_detail_estimasi.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
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
  String seat;
  String harga;
  ButtonDetail({
    Key key,
    this.idJadwal,
    this.keberangkatan,
    this.seat,
    this.harga,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.info_outline,
        color: authInqu == '1' ? myBlue : Colors.blue[200],
      ),
      onPressed: () {
        authInqu == '1'
            ? showDialog(
                context: context,
                builder: (context) => ModalDetailEstimasi(
                    idJadwal: idJadwal,
                    keberangkatan: keberangkatan,
                    seat: seat,
                    harga: harga))
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
  final List<Map<String, dynamic>> dataJadwal;
  MyData(this.dataJadwal);

  @override
  DataRow getRow(int index) {
    NumberFormat myformat = NumberFormat.decimalPattern('en_us');
    var Tanggal = (DateFormat("dd-MM-yyyy").format(DateTime.now())).toString();
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(), style: styleRowReguler)),
      DataCell(Icon(
        dataJadwal[index]['CEK'] != null ? Icons.check : Icons.clear,
        color: dataJadwal[index]['CEK'] != null ? Colors.green : Colors.red,
        size: 20,
      )),
      DataCell(Text(dataJadwal[index]['jenisPaket'].toString(),
          style: styleRowReguler)),
      // DataCell(Text(dataJadwal[index]['jenisPaket'].toString())),
      DataCell(Text(dataJadwal[index]['JMLX_HARI'].toString(),
          style: styleRowReguler)),
      DataCell(Text(
          dataJadwal[index]['TGL_BGKT'] == null
              ? "00-00-0000"
              : dataJadwal[index]['TGL_BGKT'].toString(),
          style: styleRowReguler)),
      DataCell(Text(
          dataJadwal[index]["TGL_PLNG"] == null
              ? "00-00-0000"
              : dataJadwal[index]["TGL_PLNG"].toString(),
          style: styleRowReguler)),
      DataCell(Text(
          dataJadwal[index]['NAME_PESWT_BGKT'] == null
              ? "-"
              : dataJadwal[index]['NAME_PESWT_BGKT'].toString(),
          style: styleRowReguler)),
      DataCell(Text(
          dataJadwal[index]['NAME_PESWT_PLNG'] == null
              ? "-"
              : dataJadwal[index]['NAME_PESWT_PLNG'].toString(),
          style: styleRowReguler)),
      DataCell(Text(
          myformat
              .format(int.parse(dataJadwal[index]['TARIF_PKET'].toString())),
          style: styleRowReguler)),
      // DataCell(Text(dataJadwal[index]['MATA_UANG'].toString())),
      DataCell(Text(dataJadwal[index]['JMLX_SEAT'].toString(),
          style: styleRowReguler)),
      DataCell(Text(
          dataJadwal[index]['SISA'] == 0
              ? 'Full'
              : dataJadwal[index]['SISA'].toString(),
          style: styleRowReguler)),
      // DataCell(Text(dataJadwal[index]['KETERANGAN'], style: styleRowReguler)),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonDetail(
              idJadwal: dataJadwal[index]['IDXX_JDWL'],
              keberangkatan:
                  fncGetTanggal(dataJadwal[index]['TGL_BGKT'].toString()),
              seat: dataJadwal[index]['JMLX_SEAT'].toString(),
              harga: myformat.format(
                  int.parse(dataJadwal[index]['TARIF_PKET'].toString())),
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

class TableEstimasiPaket extends StatefulWidget {
  final List<Map<String, dynamic>> dataJadwal;
  const TableEstimasiPaket({Key key, @required this.dataJadwal})
      : super(key: key);

  @override
  State<TableEstimasiPaket> createState() => _TableEstimasiPaketState();
}

class _TableEstimasiPaketState extends State<TableEstimasiPaket> {
  @override
  Widget build(BuildContext context) {
    final DataTableSource myTable = MyData(widget.dataJadwal);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.72,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          columnSpacing: 15,
          source: myTable,
          columns: const [
            DataColumn(label: Text('No.', style: styleColumn)),
            DataColumn(label: Text(' ', style: styleColumn)),
            DataColumn(label: Text('Paket', style: styleColumn)),
            DataColumn(label: Text('Hari', style: styleColumn)),
            DataColumn(label: Text('Berangkat', style: styleColumn)),
            DataColumn(label: Text('Pulang', style: styleColumn)),
            DataColumn(label: Text('Pesawat Berangkat', style: styleColumn)),
            DataColumn(label: Text('Pesawat Pulang', style: styleColumn)),
            DataColumn(label: Text('Tarif', style: styleColumn)),
            DataColumn(label: Text('Seat', style: styleColumn)),
            DataColumn(label: Text('Sisa', style: styleColumn)),
            // DataColumn(label: Text('Keterangan', style: styleColumn)),
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
