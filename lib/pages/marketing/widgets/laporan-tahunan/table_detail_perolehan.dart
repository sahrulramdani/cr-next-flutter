// ignore_for_file: must_be_immutable, missing_required_param

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_hapus_jadwal.dart';
import 'package:flutter_web_course/pages/marketing/widgets/laporan-tahunan/modal_detail_pencapaian.dart';
import 'package:flutter_web_course/pages/marketing/widgets/laporan-tahunan/modal_detail_perolehan.dart';
// import 'package:intl/intl.dart';

/// Example without a datasource
// MYDATA

// class MyData extends DataTableSource {
//   final BuildContext context;
//   final List<Map<String, dynamic>> listDetPerolehan;
//   MyData(this.listDetPerolehan, this.context);

//   @override
//   DataRow getRow(int index) {
//     return DataRow(
//         onLongPress: () {
//           // showDialog(
//           //     context: context,
//           //     builder: (context) => ModalDetailPerolehan(
//           //         tahun: listDetPerolehan[index]['TAHUN'].toString()));
//         },
//         cells: [
//           DataCell(Text((index + 1).toString(),
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.grey[800]))),
//           DataCell(Text(listDetPerolehan[index]['TAHUN'].toString(),
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.grey[800]))),
//           DataCell(Text(listDetPerolehan[index]['PUSAT'].toString(),
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.grey[800]))),
//           DataCell(Text(listDetPerolehan[index]['AGEN'].toString(),
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.grey[800]))),
//           DataCell(Text(listDetPerolehan[index]['CABANG'].toString(),
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.grey[800]))),
//           DataCell(Text(listDetPerolehan[index]['TOURLEAD'].toString(),
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.grey[800]))),
//         ]);
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => listDetPerolehan.length;

//   @override
//   int get selectedRowCount => 0;
// }

class TableDetailPerolehan extends StatefulWidget {
  final List<Map<String, dynamic>> listDetPerolehan;
  const TableDetailPerolehan({Key key, @required this.listDetPerolehan})
      : super(key: key);

  @override
  State<TableDetailPerolehan> createState() => _TableDetailPerolehanState();
}

class _TableDetailPerolehanState extends State<TableDetailPerolehan> {
  @override
  Widget build(BuildContext context) {
    // final DataTableSource myTable = MyData(widget.listDetPerolehan, context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    int x = 1;

    return SizedBox(
        width: screenWidth * 0.75,
        child: DataTable(
          headingRowColor: MaterialStateColor.resolveWith((states) => myBlue),
          columns: const [
            DataColumn(
                label: Text('No.',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Tahun',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Pusat',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Agen',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Cabang',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Tourleader',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Total',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
          ],
          rows: widget.listDetPerolehan.map((e) {
            return DataRow(cells: [
              DataCell(Text((x++).toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                      fontSize: 16))),
              DataCell(Text(e['TAHUN'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                      fontSize: 16))),
              DataCell(Text(e['PUSAT'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                      fontSize: 16))),
              DataCell(
                Text(e['AGEN'].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                        fontSize: 16)),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => ModalDetailPencapaian(
                            tahun: e['TAHUN'].toString(),
                            kode: 'Agen',
                          ));
                },
              ),
              DataCell(
                Text(e['CABANG'].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                        fontSize: 16)),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => ModalDetailPencapaian(
                            tahun: e['TAHUN'].toString(),
                            kode: 'Cabang',
                          ));
                },
              ),
              DataCell(
                Text(e['TOURLEAD'].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                        fontSize: 16)),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => ModalDetailPencapaian(
                            tahun: e['TAHUN'].toString(),
                            kode: 'Tourleader',
                          ));
                },
              ),
              DataCell(Text(e['TOTAL'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                      fontSize: 16))),
            ]);
          }).toList(),
        ));
  }
}

// // ignore_for_file: must_be_immutable, missing_required_param

// import 'package:flutter/material.dart';
// import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_hapus_jadwal.dart';
// import 'package:flutter_web_course/pages/marketing/widgets/laporan-tahunan/modal_detail_perolehan.dart';
// // import 'package:intl/intl.dart';

// /// Example without a datasource
// // MYDATA

// class MyData extends DataTableSource {
//   final BuildContext context;
//   final List<Map<String, dynamic>> listDetPerolehan;
//   MyData(this.listDetPerolehan, this.context);

//   @override
//   DataRow getRow(int index) {
//     return DataRow(
//         onLongPress: () {
//           // showDialog(
//           //     context: context,
//           //     builder: (context) => ModalDetailPerolehan(
//           //         tahun: listDetPerolehan[index]['TAHUN'].toString()));
//         },
//         cells: [
//           DataCell(Text((index + 1).toString(),
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.grey[800]))),
//           DataCell(Text(listDetPerolehan[index]['TAHUN'].toString(),
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.grey[800]))),
//           DataCell(Text(listDetPerolehan[index]['PUSAT'].toString(),
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.grey[800]))),
//           DataCell(Text(listDetPerolehan[index]['AGEN'].toString(),
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.grey[800]))),
//           DataCell(Text(listDetPerolehan[index]['CABANG'].toString(),
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.grey[800]))),
//           DataCell(Text(listDetPerolehan[index]['TOURLEAD'].toString(),
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.grey[800]))),
//         ]);
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => listDetPerolehan.length;

//   @override
//   int get selectedRowCount => 0;
// }

// class TableDetailPerolehan extends StatefulWidget {
//   final List<Map<String, dynamic>> listDetPerolehan;
//   const TableDetailPerolehan({Key key, @required this.listDetPerolehan})
//       : super(key: key);

//   @override
//   State<TableDetailPerolehan> createState() => _TableDetailPerolehanState();
// }

// class _TableDetailPerolehanState extends State<TableDetailPerolehan> {
//   @override
//   Widget build(BuildContext context) {
//     final DataTableSource myTable = MyData(widget.listDetPerolehan, context);
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return SizedBox(
//       width: screenWidth * 0.75,
//       height: 0.7 * screenHeight,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: PaginatedDataTable(
//           source: myTable,
//           dataRowHeight: 40,
//           columnSpacing: 0,
//           columns: const [
//             DataColumn(
//                 label: Text('No.',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Gilroy',
//                         fontSize: 16))),
//             DataColumn(
//                 label: Text('Tahun',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Gilroy',
//                         fontSize: 16))),
//             DataColumn(
//                 label: Text('Pusat',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Gilroy',
//                         fontSize: 16))),
//             DataColumn(
//                 label: Text('Agen',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Gilroy',
//                         fontSize: 16))),
//             DataColumn(
//                 label: Text('Cabang',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Gilroy',
//                         fontSize: 16))),
//             DataColumn(
//                 label: Text('Tourleader',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Gilroy',
//                         fontSize: 16))),
//           ],
//         ),
//       ),
//     );
//   }
// }
