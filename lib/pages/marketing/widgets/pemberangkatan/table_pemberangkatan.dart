// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/marketing/widgets/pemberangkatan/modal_edit_pemberangkatan.dart';

/// BUTTON HAPUS
// class ButtonHapus extends StatelessWidget {
//   const ButtonHapus({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: Icon(
//         Icons.delete_outline,
//         color: myBlue,
//       ),
//       onPressed: () {
//         // showDialog(
//         //     context: context,
//         //     builder: (context) => ModalHapusAgency(
//         //           idAgency: idAgen,
//         //         ));
//       },
//     );
//   }
// }

/// BUTTON DETAIL
class ButtonEdit extends StatelessWidget {
  String idJadwal;
  ButtonEdit({Key key, @required this.idJadwal}) : super(key: key);

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
                builder: (context) =>
                    ModalEditPemberangkatan(idJadwal: idJadwal))
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
  final List<Map<String, dynamic>> dataPemberangkatan;
  MyData(this.dataPemberangkatan);

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(), style: styleRowReguler)),
      DataCell(Icon(
        dataPemberangkatan[index]['STATUS'] == 1
            ? Icons.check
            : Icons.access_alarm_outlined,
        color: dataPemberangkatan[index]['STATUS'] == 1
            ? Colors.green
            : Colors.orange[800],
        size: 20,
      )),
      DataCell(Text(
          '${dataPemberangkatan[index]['jenisPaket']}, ${dataPemberangkatan[index]['KETERANGAN']}',
          style: styleRowReguler)),
      DataCell(Text(
          fncGetTanggal(dataPemberangkatan[index]['TGLX_BGKT'].toString()),
          style: styleRowReguler)),
      DataCell(Text(dataPemberangkatan[index]['JMLX_HARI'].toString(),
          style: styleRowReguler)),
      DataCell(Text(dataPemberangkatan[index]['JMLX_SEAT'].toString(),
          style: styleRowReguler)),
      DataCell(Text(dataPemberangkatan[index]['JAMAAH_AGEN'].toString(),
          style: styleRowReguler)),
      DataCell(Text(dataPemberangkatan[index]['JAMAAH_KNTR'].toString(),
          style: styleRowReguler)),
      DataCell(Text('0/${dataPemberangkatan[index]['TOTL_KONFIRMASI']}',
          style: styleRowReguler)),
      DataCell(Text(dataPemberangkatan[index]['SISA'].toString(),
          style: styleRowReguler)),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonEdit(
              idJadwal: dataPemberangkatan[index]['IDXX_JDWL'],
            ),
            // SizedBox(
            //   width: 5,
            // ),
            // ButtonHapus(),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataPemberangkatan.length;

  @override
  int get selectedRowCount => 0;
}

class TablePemberangkatan extends StatefulWidget {
  final List<Map<String, dynamic>> dataPemberangkatan;
  const TablePemberangkatan({Key key, @required this.dataPemberangkatan})
      : super(key: key);

  @override
  State<TablePemberangkatan> createState() => _TablePemberangkatanState();
}

class _TablePemberangkatanState extends State<TablePemberangkatan> {
  @override
  Widget build(BuildContext context) {
    final DataTableSource myTable = MyData(widget.dataPemberangkatan);
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      height: fncHeightTableWithCardWithoutTambah(context),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          columnSpacing: 15,
          source: myTable,
          columns: const [
            DataColumn(label: Text('No.', style: styleColumn)),
            DataColumn(label: Text('#', style: styleColumn)),
            DataColumn(label: Text('Paket', style: styleColumn)),
            DataColumn(label: Text('Berangkat', style: styleColumn)),
            DataColumn(label: Text('Hari', style: styleColumn)),
            DataColumn(label: Text('Seat', style: styleColumn)),
            DataColumn(label: Text('Agen', style: styleColumn)),
            DataColumn(label: Text('Kantor', style: styleColumn)),
            DataColumn(label: Text('Konfirmasi', style: styleColumn)),
            DataColumn(label: Text('Sisa', style: styleColumn)),
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
