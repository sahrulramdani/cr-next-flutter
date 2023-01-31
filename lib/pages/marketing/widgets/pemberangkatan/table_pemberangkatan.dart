// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
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
        color: myBlue,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ModalEditPemberangkatan(idJadwal: idJadwal));
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
      DataCell(Text((index + 1).toString())),
      DataCell(Icon(
        dataPemberangkatan[index]['status_berangkat'] == 'a'
            ? Icons.check
            : Icons.punch_clock_outlined,
        color: dataPemberangkatan[index]['status_berangkat'] == 'a'
            ? Colors.green
            : Colors.red,
        size: 20,
      )),
      DataCell(Text(dataPemberangkatan[index]['tipe'].toString())),
      DataCell(Text(dataPemberangkatan[index]['tg_berangkat'].toString())),
      DataCell(Text(dataPemberangkatan[index]['jumlah_hari'].toString())),
      DataCell(Text(dataPemberangkatan[index]['jumlah_seat'].toString())),
      DataCell(Text(dataPemberangkatan[index]['via_marketing'].toString())),
      DataCell(Text(dataPemberangkatan[index]['via_kantor'].toString())),
      DataCell(Text(dataPemberangkatan[index]['status_konfirmasi'].toString())),
      DataCell(Text(dataPemberangkatan[index]['sisa_seat'].toString())),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonEdit(
              idJadwal: dataPemberangkatan[index]['id_jadwal'],
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
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth,
      height: 0.5 * screenHeight,
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
                label: Text('Berangkat',
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
                label: Text('Seat',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Agen',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Kantor',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Konfirmasi',
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
