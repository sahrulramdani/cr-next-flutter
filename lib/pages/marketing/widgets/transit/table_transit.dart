// ignore_for_file: must_be_immutable, missing_required_param

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_hapus_jadwal.dart';
import 'modal_cd_transit.dart';
import 'modal_hapus_transit.dart';
// import 'package:intl/intl.dart';

/// Example without a datasource
// MYDATA

class ButtonEdit extends StatelessWidget {
  String idTransit;
  ButtonEdit({
    Key key,
    @required this.idTransit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.edit_outlined,
        color: authEdit == '1' ? myBlue : Colors.blue[200],
      ),
      onPressed: () {
        authEdit == '1'
            ? showDialog(
                context: context,
                builder: (context) => ModalCdTransit(
                      idTransit: idTransit,
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

class ButtonHapus extends StatelessWidget {
  String idTransit;
  ButtonHapus({Key key, @required this.idTransit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete_outline,
        color: authDelt == '1' ? myBlue : Colors.blue[200],
      ),
      onPressed: () {
        authEdit == '1'
            ? showDialog(
                context: context,
                builder: (context) => ModalHapusTransit(idTransit: idTransit))
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
  final List<Map<String, dynamic>> listTransit;
  MyData(this.listTransit);

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(), style: styleRowReguler)),
      DataCell(Text(listTransit[index]['NAMA_NEGR'].toString(),
          style: styleRowReguler)),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 5),
            ButtonEdit(
              idTransit: listTransit[index]['IDXX_RTRS'].toString(),
            ),
            const SizedBox(width: 5),
            ButtonHapus(
              idTransit: listTransit[index]['IDXX_RTRS'].toString(),
            ),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listTransit.length;

  @override
  int get selectedRowCount => 0;
}

class TableMasterTransit extends StatefulWidget {
  final List<Map<String, dynamic>> listTransit;
  const TableMasterTransit({Key key, @required this.listTransit})
      : super(key: key);

  @override
  State<TableMasterTransit> createState() => _TableMasterTransitState();
}

class _TableMasterTransitState extends State<TableMasterTransit> {
  @override
  Widget build(BuildContext context) {
    final DataTableSource myTable = MyData(widget.listTransit);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.9,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          source: myTable,
          columns: const [
            DataColumn(label: Text('No.', style: styleColumn)),
            DataColumn(label: Text('Nama', style: styleColumn)),
            DataColumn(
                label: SizedBox(
                    width: 80,
                    child: Center(
                      child: Text('Aksi', style: styleColumn),
                    ))),
          ],
        ),
      ),
    );
  }
}
