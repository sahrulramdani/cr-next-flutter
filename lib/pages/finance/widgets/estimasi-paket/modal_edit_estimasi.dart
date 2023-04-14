// // ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print

// import 'package:pattern_formatter/pattern_formatter.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter_web_course/models/http_pengguna.dart';
// import 'package:flutter_web_course/pages/hr/widgets/menu/modul_detail_submenu.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_web_course/constants/style.dart';
// // import 'package:flutter_web_course/comp/modal_save_fail.dart';
// import 'package:flutter_web_course/comp/modal_save_success.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
// import 'package:flutter_web_course/constants/controllers.dart';
// // import 'package:flutter_web_course/models/http_controller.dart';
// // import 'package:intl/intl.dart';
// // import 'dart:convert';

// class ModalTambahEstimasi extends StatefulWidget {
//   final String idJadwal;
//   List<Map<String, dynamic>> listDetailJadwal = [];

//   // final bool tambah;

//   ModalTambahEstimasi(
//       {Key key, @required this.idJadwal, @required this.listDetailJadwal})
//       : super(key: key);

//   @override
//   State<ModalTambahEstimasi> createState() => _ModalTambahEstimasiState();
// }

// class _ModalTambahEstimasiState extends State<ModalTambahEstimasi> {
//   List<Map<String, dynamic>> listDetail = [];
//   String namaSumberDana;
//   String nominal;
//   int urut = 0;

//   String namaBiaya;
//   String nominalBiaya;

//   void getListBiaya(detail) async {
//     List<Map<String, dynamic>> list = detail;
//     NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

//     for (var i = 0; i < list.length; i++) {
//       var pushPaket = {
//         "NOXX_URUT": "${(i + 1)}",
//         "NAMA_BIAYA": list[i]['NAMA_BIAYA'],
//         "NOMINAL": list[i]['NOMINAL'],
//       };
//       listDetail.add(pushPaket);
//     }

//     setState(() {
//       urut = list.length;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getListBiaya(widget.listDetailJadwal);
//   }

//   Widget inputSumberDana() {
//     return Container(
//       height: 50,
//       decoration: const BoxDecoration(
//           border: Border(
//               bottom: BorderSide(
//                   style: BorderStyle.solid, color: Colors.black, width: 0.4))),
//       child: DropdownSearch(
//         label: "Sumber Dana",
//         mode: Mode.MENU,
//         items: const ["Biaya Paket", "Biaya Handling"],
//         onChanged: (value) {
//           namaSumberDana = value;
//         },
//         dropdownBuilder: (context, selectedItem) => Text(
//             namaSumberDana ?? "Pilih Sumber Dana",
//             style: TextStyle(
//                 color: namaSumberDana == null ? Colors.red : Colors.black)),
//         dropdownSearchDecoration: const InputDecoration(
//             border: InputBorder.none, filled: true, fillColor: Colors.white),
//         validator: (value) {
//           if (value == "Pilih Sumber Dana") {
//             return "Sumber Dana masih kosong !";
//           }
//         },
//       ),
//     );
//   }

//   Widget inputTarif() {
//     return TextFormField(
//       textAlign: TextAlign.right,
//       keyboardType: TextInputType.number,
//       inputFormatters: [ThousandsFormatter()],
//       style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
//       decoration: const InputDecoration(
//           label: Text("Nominal", style: TextStyle(color: Colors.red)),
//           filled: true,
//           fillColor: Colors.white,
//           hoverColor: Colors.white),
//       onChanged: (value) {
//         nominal = value;
//       },
//       validator: (value) {
//         if (nominal.isEmpty) {
//           return "Nominal masih kosong !";
//         }
//       },
//     );
//   }

//   Widget inputNamaBiaya() {
//     return TextFormField(
//       style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
//       decoration: const InputDecoration(
//           label: Text('Nama Biaya', style: TextStyle(color: Colors.red)),
//           filled: true,
//           fillColor: Colors.white,
//           hoverColor: Colors.white),
//       onChanged: (value) {
//         namaBiaya = value;
//       },
//       initialValue: namaBiaya,
//       validator: (value) {
//         if (value.isEmpty) {
//           return "Nama Biaya masih kosong !";
//         }
//       },
//     );
//   }

//   Widget inputNominal() {
//     return TextFormField(
//       textAlign: TextAlign.right,
//       keyboardType: TextInputType.number,
//       inputFormatters: [ThousandsFormatter()],
//       style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
//       decoration: const InputDecoration(
//           label: Text("Nominal Biaya", style: TextStyle(color: Colors.red)),
//           filled: true,
//           fillColor: Colors.white,
//           hoverColor: Colors.white),
//       onChanged: (value) {
//         nominalBiaya = value;
//       },
//       validator: (value) {
//         if (nominalBiaya.isEmpty) {
//           return "Nominal Biaya masih kosong !";
//         }
//       },
//     );
//   }

//   Widget cmdTambah(context) {
//     return ElevatedButton.icon(
//       onPressed: () async {},
//       icon: const Icon(Icons.add),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: myBlue,
//         minimumSize: const Size(100, 40),
//         shadowColor: Colors.grey,
//         elevation: 5,
//       ),
//       label: const Text(
//         'Tambah List',
//         style: TextStyle(fontFamily: 'Gilroy'),
//       ),
//     );
//   }

//   fncSaveData() {
//     // HttpPengguna.saveSubmenu(idMenu, namaSubmenu).then((value) {
//     //   if (value.status == true) {
//     //     showDialog(
//     //         context: context, builder: (context) => const ModalSaveSuccess());
//     //   } else {
//     //     showDialog(
//     //         context: context, builder: (context) => const ModalSaveFail());
//     //   }
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final formKey = GlobalKey<FormState>();

//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
//       child: Stack(children: [
//         Form(
//           key: formKey,
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
//             width: screenWidth * 0.73,
//             height: 600,
//             child: Column(
//               children: [
//                 SizedBox(
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.edit_outlined,
//                         color: Colors.amber[900],
//                       ),
//                       const SizedBox(width: 10),
//                       Text("Tambah Detail Biaya ${widget.idJadwal}",
//                           style: TextStyle(
//                               color: myGrey,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20)),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//                   SizedBox(width: 445, child: inputSumberDana()),
//                   const SizedBox(width: 40),
//                   SizedBox(width: 445, child: inputTarif()),
//                 ]),
//                 const SizedBox(height: 20),
//                 Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
//                   SizedBox(width: 355, child: inputNamaBiaya()),
//                   const SizedBox(width: 40),
//                   SizedBox(width: 355, child: inputNominal()),
//                   const SizedBox(width: 40),
//                   cmdTambah(context)
//                 ]),
//                 const SizedBox(height: 20),
//                 Expanded(
//                     child: SingleChildScrollView(
//                         scrollDirection: Axis.vertical,
//                         child: SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Column(
//                               children: [
//                                 DataTable(
//                                     headingRowColor:
//                                         MaterialStateProperty.resolveWith<
//                                             Color>((Set<MaterialState> states) {
//                                       return Colors.blue;
//                                     }),
//                                     headingTextStyle: const TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: 'Gilroy',
//                                         fontSize: 16),
//                                     columnSpacing: 220,
//                                     dataRowHeight: 40,
//                                     dataTextStyle:
//                                         const TextStyle(fontSize: 13),
//                                     columns: const [
//                                       DataColumn(label: Text('No.')),
//                                       DataColumn(label: Text('Nama Biaya')),
//                                       DataColumn(label: Text('Nominal')),
//                                       DataColumn(label: Text('Aksi')),
//                                     ],
//                                     rows: listDetail.map((e) {
//                                       return DataRow(cells: [
//                                         DataCell(Text(
//                                             (e['NOXX_URUT']).toString() ?? "")),
//                                         DataCell(Text(
//                                             (e['NAMA_BIAYA']).toString() ??
//                                                 "")),
//                                         DataCell(Text(
//                                             (e['NOMINAL']).toString() ?? "")),
//                                         DataCell(IconButton(
//                                           icon: Icon(
//                                             Icons.delete_outline,
//                                             color: myBlue,
//                                           ),
//                                           onPressed: () {},
//                                         )),
//                                       ]);
//                                     }).toList())
//                               ],
//                             )))),
//                 SizedBox(
//                   height: 50,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       ElevatedButton.icon(
//                         onPressed: () {
//                           fncSaveData();
//                         },
//                         icon: const Icon(Icons.save),
//                         label: const Text(
//                           'Simpan Data',
//                           style: TextStyle(fontFamily: 'Gilroy'),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: myBlue,
//                           shadowColor: Colors.grey,
//                           elevation: 5,
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       ElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Text('Kembali'))
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         )
//       ]),
//     );
//   }
// }
