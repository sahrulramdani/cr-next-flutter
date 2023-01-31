import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/hr/widgets/karyawan/modal_hapus_karyawan.dart';

/// Example without a datasource
/// BUTTON HAPUS
class ButtonHapus extends StatelessWidget {
  final String idKaryawan;
  const ButtonHapus({Key key, @required this.idKaryawan}) : super(key: key);

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
            builder: (context) => ModalHapusKaryawan(
                  idKaryawan: idKaryawan,
                ));
      },
    );
  }
}

/// BUTTON DETAIL
// class ButtonEdit extends StatelessWidget {
//   final String idAgen;
//   const ButtonEdit({Key key, @required this.idAgen}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: Icon(
//         Icons.info_outline,
//         color: myBlue,
//       ),
//       onPressed: () {
//         showDialog(
//             context: context,
//             builder: (context) => ModalEditAgency(
//                   idAgency: idAgen,
//                 ));
//       },
//     );
//   }
// }

// MYDATA
class MyData extends DataTableSource {
  final List<Map<String, dynamic>> dataKaryawan;
  MyData(this.dataKaryawan);

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(
        (index + 1).toString(),
        style: TextStyle(
            color: dataKaryawan[index]['status_aktif'] == 'n'
                ? Colors.red
                : Colors.black),
      )),
      DataCell(Text(
        dataKaryawan[index]['id_karyawan'].toString(),
        style: TextStyle(
            color: dataKaryawan[index]['status_aktif'] == 'n'
                ? Colors.red
                : Colors.black),
      )),
      DataCell(Text(
        dataKaryawan[index]['nama_lengkap'].toString(),
        style: TextStyle(
            color: dataKaryawan[index]['status_aktif'] == 'n'
                ? Colors.red
                : Colors.black),
      )),
      DataCell(Text(
        dataKaryawan[index]['mk'].toString(),
        style: TextStyle(
            color: dataKaryawan[index]['status_aktif'] == 'n'
                ? Colors.red
                : Colors.black),
      )),
      DataCell(Text(
        dataKaryawan[index]['masa_kerja'].toString(),
        style: TextStyle(
            color: dataKaryawan[index]['status_aktif'] == 'n'
                ? Colors.red
                : Colors.black),
      )),
      DataCell(Text(
        dataKaryawan[index]['level'].toString(),
        style: TextStyle(
            color: dataKaryawan[index]['status_aktif'] == 'n'
                ? Colors.red
                : Colors.black),
      )),
      DataCell(Text(
        dataKaryawan[index]['tanggal_gabung'].toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: dataKaryawan[index]['status_aktif'] == 'n'
                ? Colors.red
                : Colors.black),
      )),
      DataCell(Center(
        child: Row(
          children: [
            // ButtonEdit(idAgen: dataKaryawan[index]['id_karyawan'].toString()),
            // const SizedBox(width: 5),
            ButtonHapus(
                idKaryawan: dataKaryawan[index]['id_karyawan'].toString()),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataKaryawan.length;

  @override
  int get selectedRowCount => 0;
}

class TableKaryawan extends StatefulWidget {
  final List<Map<String, dynamic>> dataKaryawan;
  const TableKaryawan({Key key, @required this.dataKaryawan}) : super(key: key);

  @override
  State<TableKaryawan> createState() => _TableKaryawanState();
}

class _TableKaryawanState extends State<TableKaryawan> {
  @override
  Widget build(BuildContext context) {
    final DataTableSource myTable = MyData(widget.dataKaryawan);
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
                label: Text('ID Karyawan',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Nama Karyawan',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Level Karyawan',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Masa Kerja',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('First Level',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Tgl. Bergabung',
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
              ),
            )),
          ],
        ),
      ),
    );
  }
}
