// ignore_for_file: must_be_immutable, missing_required_param

import 'package:flutter/material.dart';
import 'package:flutter_web_course/pages/inventory/widgets/handling/modal_hapus_barang_handling.dart';
import 'package:intl/intl.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/inventory/widgets/handling/modal_tambah_handling.dart';
// import 'package:intl/intl.dart';

/// Example without a datasource
// MYDATA

class ButtonHapus extends StatelessWidget {
  final String idBarang;
  final String idGrup;
  const ButtonHapus({
    Key key,
    @required this.idBarang,
    @required this.idGrup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete_outline,
        color: authDelt == '1' ? myBlue : Colors.blue[200],
      ),
      onPressed: () {
        authDelt == '1'
            ? showDialog(
                context: context,
                builder: (context) => ModalHapusBarangHandling(
                      idGrup: idGrup,
                      idBarang: idBarang,
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
  final BuildContext context;
  final List<Map<String, dynamic>> listHandling;
  MyData(this.listHandling, this.context);

  @override
  DataRow getRow(int index) {
    final styleRow =
        TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]);
    NumberFormat myformat = NumberFormat.decimalPattern('en_us');

    return DataRow(cells: [
      DataCell(Text((index + 1).toString(), style: styleRow)),
      DataCell(
          Text(listHandling[index]['NAMA_BRGX'].toString(), style: styleRow)),
      DataCell(
          Text(listHandling[index]['JMLH_BRGX'].toString(), style: styleRow)),
      DataCell(Text(myformat.format(listHandling[index]['HRGX_JUAL']),
          style: styleRow)),
      DataCell(Center(
        child: Row(
          children: [
            ButtonHapus(
              idBarang: listHandling[index]['KDXX_BRGX'].toString(),
              idGrup: listHandling[index]['KDXX_GHAN'].toString(),
            ),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listHandling.length;

  @override
  int get selectedRowCount => 0;
}

class TableGrupHandling extends StatefulWidget {
  final List<Map<String, dynamic>> listHandling;
  final String judul;
  final String jenis;
  final String idGrup;
  const TableGrupHandling({
    Key key,
    @required this.listHandling,
    @required this.judul,
    @required this.jenis,
    @required this.idGrup,
  }) : super(key: key);

  @override
  State<TableGrupHandling> createState() => _TableGrupHandlingState();
}

class _TableGrupHandlingState extends State<TableGrupHandling> {
  @override
  Widget build(BuildContext context) {
    final DataTableSource myTable = MyData(widget.listHandling, context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(0.2),
              blurRadius: 12)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Barang Handling Laki Laki',
                style: styleHeaderSmall,
              ),
              Expanded(child: Container()),
              ElevatedButton.icon(
                onPressed: () async {
                  authAddx == '1'
                      ? showDialog(
                          context: context,
                          builder: (context) =>
                              ModalTambahBarangHandling(idGrup: widget.idGrup))
                      : showDialog(
                          context: context,
                          builder: (context) => const ModalInfo(
                                deskripsi: 'Anda Tidak Memiliki Akses',
                              ));
                },
                icon: const Icon(Icons.add),
                style: fncButtonAuthStyle(authAddx, context),
                label: fncLabelButtonStyle('Tambah Data', context),
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: screenWidth * 0.9,
            height: 0.66 * screenHeight,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: PaginatedDataTable(
                source: myTable,
                dataRowHeight: 40,
                columnSpacing: 14,
                columns: const [
                  DataColumn(label: Text('No.', style: styleColumn)),
                  DataColumn(label: Text('Nama Barang', style: styleColumn)),
                  DataColumn(label: Text('Jumlah', style: styleColumn)),
                  DataColumn(label: Text('Harga', style: styleColumn)),
                  DataColumn(label: Text('Aksi', style: styleColumn)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
