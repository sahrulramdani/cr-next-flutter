import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/pages/inventory/widgets/satuan/modal_edit_satuan.dart';
import 'package:flutter_web_course/pages/inventory/widgets/satuan/modal_hapus_satuan.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jadwal.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_edit_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jadwal.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_upload_jamaah.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:intl/intl.dart';

class ButtonEdit extends StatelessWidget {
  final String satuan;
  const ButtonEdit({Key key, @required this.satuan}) : super(key: key);

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
            builder: (context) => ModalEditSatuan(satuan: satuan));
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
            context: context, builder: (context) => const ModalHapusSatuan());
      },
    );
  }
}

class MyData extends DataTableSource {
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text(listDataSatuan[index]['satuan'])),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonEdit(satuan: listDataSatuan[index]['satuan']),
            const SizedBox(width: 10),
            const ButtonHapus()
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listDataSatuan.length;

  @override
  int get selectedRowCount => 0;
}

class TableSatuan extends StatefulWidget {
  const TableSatuan({Key key}) : super(key: key);

  @override
  State<TableSatuan> createState() => _TableSatuanState();
}

class _TableSatuanState extends State<TableSatuan> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final DataTableSource myTable = MyData();

    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.63,
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
                label: Text('Satuan',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Expanded(
              child: Center(
                child: Text('Aksi',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16)),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
