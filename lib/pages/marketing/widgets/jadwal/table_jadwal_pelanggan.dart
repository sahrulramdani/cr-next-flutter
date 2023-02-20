// import 'package:flutter/material.dart';
// import 'package:flutter_web_course/constants/style.dart';
// import 'package:intl/intl.dart';

// /// Example without a datasource
// // MYDATA
// // class MyData extends DataTableSource {
// //   final List<Map<String, dynamic>> dataJadwalPel;
// //   MyData(this.dataJadwalPel);

// //   @override
// //   DataRow getRow(int index) {
// //     NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

// //     return DataRow(cells: [
// //       DataCell(Text((index + 1).toString())),
// //       DataCell(
// //         Checkbox(
// //           value: false,
// //           onChanged: (bool value) {},
// //         ),
// //       ),
// //       DataCell(Text(dataJadwalPel[index]['NAMA_LGKP'].toString())),
// //       DataCell(Text(dataJadwalPel[index]['JENS_KLMN'].toString())),
// //       DataCell(Text(dataJadwalPel[index]['UMUR'].toString())),
// //       DataCell(Text(dataJadwalPel[index]['PEMB_PSPR'])),
// //       DataCell(Text(dataJadwalPel[index]['PRSS_VKSN'])),
// //       DataCell(Text(dataJadwalPel[index]['HANDLING'])),
// //       DataCell(Text(dataJadwalPel[index]['NOXX_TELP'].toString())),
// //       DataCell(Text(myFormat.format(dataJadwalPel[index]['EST_TOTAL']))),
// //       DataCell(Text(myFormat.format(dataJadwalPel[index]['MASUK']))),
// //       DataCell(Text(myFormat.format(dataJadwalPel[index]['SISA']))),
// //       DataCell(Text(dataJadwalPel[index]['STATUS_BAYAR'].toString())),
// //       const DataCell(Text('Pending')),
// //     ]);
// //   }

// //   @override
// //   bool get isRowCountApproximate => false;

// //   @override
// //   int get rowCount => dataJadwalPel.length;

// //   @override
// //   int get selectedRowCount => 0;
// // }

// class TableJadwalPelanggan extends StatefulWidget {
//   final List<Map<String, dynamic>> dataJadwalPel;
//   const TableJadwalPelanggan({Key key, @required this.dataJadwalPel})
//       : super(key: key);

//   @override
//   State<TableJadwalPelanggan> createState() => _TableJadwalPelangganState();
// }

// class _TableJadwalPelangganState extends State<TableJadwalPelanggan> {
//   @override
//   Widget build(BuildContext context) {
//     // final DataTableSource myTable = MyData(widget.dataJadwalPel);
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return SizedBox(
//       width: screenWidth * 0.7,
//       height: 0.5 * screenHeight,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: DataTable(
//               dataRowHeight: 30,
//               headingRowHeight: 30,
//               border: TableBorder.all(color: Colors.grey[500]),
//               columns: const [
//                 DataColumn(
//                     label: Text('No.',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 12))),
//                 DataColumn(
//                     label: Text('#',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 12))),
//                 DataColumn(
//                     label: Text('Nama',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 12))),
//                 DataColumn(
//                     label: Text('JK',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 12))),
//                 DataColumn(
//                     label: Text('U',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 12))),
//                 DataColumn(
//                     label: Text('Pasp',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 12))),
//                 DataColumn(
//                     label: Text('Vaksin',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 12))),
//                 DataColumn(
//                     label: Text('Hand',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 12))),
//                 DataColumn(
//                     label: Text('Telp',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 12))),
//                 DataColumn(
//                     label: Text('Est. Total',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 12))),
//                 DataColumn(
//                     label: Text('Uang Masuk',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 12))),
//                 DataColumn(
//                     label: Text('Sisa Bayar',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 12))),
//                 DataColumn(
//                     label: Text('Lunas',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 12))),
//                 DataColumn(
//                     label: Text('Cetak',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 12))),
//               ],
//               rows: const [
//                 DataRow(cells: [
//                   DataCell(Text('wkwkwk')),
//                   DataCell(Text('wkwkwk')),
//                   DataCell(Text('wkwkwk')),
//                   DataCell(Text('wkwkwk')),
//                   DataCell(Text('wkwkwk')),
//                   DataCell(Text('wkwkwk')),
//                   DataCell(Text('wkwkwk')),
//                   DataCell(Text('wkwkwk')),
//                   DataCell(Text('wkwkwk')),
//                   DataCell(Text('wkwkwk')),
//                   DataCell(Text('wkwkwk')),
//                   DataCell(Text('wkwkwk')),
//                   DataCell(Text('wkwkwk')),
//                   DataCell(Text('wkwkwk')),
//                 ])
//               ]),
//         ),
//         // child: PaginatedDataTable(
//         //   source: myTable,
//         //   columnSpacing: 10,
//         //   columns: [
//         //     DataColumn(
//         //         label: Text('No.',
//         //             style: TextStyle(
//         //                 color: myGrey,
//         //                 fontWeight: FontWeight.bold,
//         //                 fontFamily: 'Gilroy',
//         //                 fontSize: 16))),
//         //     DataColumn(
//         //         label: Text('#',
//         //             style: TextStyle(
//         //                 color: myGrey,
//         //                 fontWeight: FontWeight.bold,
//         //                 fontFamily: 'Gilroy',
//         //                 fontSize: 16))),
//         //     DataColumn(
//         //         label: Text('Nama',
//         //             style: TextStyle(
//         //                 color: myGrey,
//         //                 fontWeight: FontWeight.bold,
//         //                 fontFamily: 'Gilroy',
//         //                 fontSize: 16))),
//         //     DataColumn(
//         //         label: Text('JK',
//         //             style: TextStyle(
//         //                 color: myGrey,
//         //                 fontWeight: FontWeight.bold,
//         //                 fontFamily: 'Gilroy',
//         //                 fontSize: 16))),
//         //     DataColumn(
//         //         label: Text('U',
//         //             style: TextStyle(
//         //                 color: myGrey,
//         //                 fontWeight: FontWeight.bold,
//         //                 fontFamily: 'Gilroy',
//         //                 fontSize: 16))),
//         //     DataColumn(
//         //         label: Text('Pasp',
//         //             style: TextStyle(
//         //                 color: myGrey,
//         //                 fontWeight: FontWeight.bold,
//         //                 fontFamily: 'Gilroy',
//         //                 fontSize: 16))),
//         //     DataColumn(
//         //         label: Text('Vaksin',
//         //             style: TextStyle(
//         //                 color: myGrey,
//         //                 fontWeight: FontWeight.bold,
//         //                 fontFamily: 'Gilroy',
//         //                 fontSize: 16))),
//         //     DataColumn(
//         //         label: Text('Hand',
//         //             style: TextStyle(
//         //                 color: myGrey,
//         //                 fontWeight: FontWeight.bold,
//         //                 fontFamily: 'Gilroy',
//         //                 fontSize: 16))),
//         //     DataColumn(
//         //         label: Text('Telp',
//         //             style: TextStyle(
//         //                 color: myGrey,
//         //                 fontWeight: FontWeight.bold,
//         //                 fontFamily: 'Gilroy',
//         //                 fontSize: 16))),
//         //     DataColumn(
//         //         label: Text('Est. Total',
//         //             style: TextStyle(
//         //                 color: myGrey,
//         //                 fontWeight: FontWeight.bold,
//         //                 fontFamily: 'Gilroy',
//         //                 fontSize: 16))),
//         //     DataColumn(
//         //         label: Text('Uang Masuk',
//         //             style: TextStyle(
//         //                 color: myGrey,
//         //                 fontWeight: FontWeight.bold,
//         //                 fontFamily: 'Gilroy',
//         //                 fontSize: 16))),
//         //     DataColumn(
//         //         label: Text('Sisa Bayar',
//         //             style: TextStyle(
//         //                 color: myGrey,
//         //                 fontWeight: FontWeight.bold,
//         //                 fontFamily: 'Gilroy',
//         //                 fontSize: 16))),
//         //     DataColumn(
//         //         label: Text('Lunas',
//         //             style: TextStyle(
//         //                 color: myGrey,
//         //                 fontWeight: FontWeight.bold,
//         //                 fontFamily: 'Gilroy',
//         //                 fontSize: 16))),
//         //     DataColumn(
//         //         label: Text('Cetak',
//         //             style: TextStyle(
//         //                 color: myGrey,
//         //                 fontWeight: FontWeight.bold,
//         //                 fontFamily: 'Gilroy',
//         //                 fontSize: 16))),
//         //   ],
//         // ),
//       ),
//     );
//   }
// }
