import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy_ujrah.dart';
import 'package:flutter_web_course/pages/finance/widgets/ujrah/modal_detail_ujrah.dart';
// import 'package:intl/intl.dart';

class ButtonEdit extends StatelessWidget {
  const ButtonEdit({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.info_outline,
        color: myBlue,
      ),
      onPressed: () {
        showDialog(
            context: context, builder: (context) => const ModalDetailUjrah());
      },
    );
  }
}

class MyData extends DataTableSource {
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(),
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Icon(
        dummyListUjrah[index]['status_tm'] == 'p'
            ? Icons.punch_clock_outlined
            : Icons.check,
        color: dummyListUjrah[index]['status_tm'] == 'p'
            ? Colors.red
            : Colors.green,
        size: 20,
      )),
      DataCell(Text(dummyListUjrah[index]['id_faktur'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(dummyListUjrah[index]['nama_lengkap'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(dummyListUjrah[index]['co_tr'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(dummyListUjrah[index]['ujroh'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(dummyListUjrah[index]['status_text'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text('-',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text('-',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(dummyListUjrah[index]['no_wa'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            ButtonEdit(),
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
  int get rowCount => dummyListUjrah.length;

  @override
  int get selectedRowCount => 0;
}

class TableTransaksi extends StatefulWidget {
  const TableTransaksi({Key key}) : super(key: key);

  @override
  State<TableTransaksi> createState() => _TableTransaksiState();
}

class _TableTransaksiState extends State<TableTransaksi> {
  @override
  Widget build(BuildContext context) {
    final DataTableSource myTable = MyData();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth,
      height: 0.41 * screenHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          source: myTable,
          columnSpacing: 8,
          columns: const [
            DataColumn(
                label: Text('No.',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('#',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Faktur',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Marketing',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Tr',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Ujroh',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Status Transfer',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Otorisasi',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Tranfer',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Telepon',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: SizedBox(
                    width: 80,
                    child: Center(
                      child: Text('Aksi',
                          style: TextStyle(
                              color: Colors.black,
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
