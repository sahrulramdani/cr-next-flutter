// ignore_for_file: must_be_immutable, missing_required_param

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/hr/widgets/kantor/modal_cd_kantor.dart';
import 'package:flutter_web_course/pages/hr/widgets/kantor/modal_hapus_kantor.dart';
// import 'modal_cd_maskapai.dart';
// import 'modal_hapus_maskapai.dart';
// import 'package:intl/intl.dart';

/// Example without a datasource
// MYDATA

class ButtonEdit extends StatelessWidget {
  String idKantor;
  ButtonEdit({
    Key key,
    @required this.idKantor,
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
                builder: (context) => ModalCdKantor(
                      idKantor: idKantor,
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
  String idKantor;
  ButtonHapus({Key key, @required this.idKantor}) : super(key: key);

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
                builder: (context) => ModalHapusKantor(idKantor: idKantor))
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
  final List<Map<String, dynamic>> listKantor;
  MyData(this.listKantor);

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(), style: styleRowReguler)),
      DataCell(Text(listKantor[index]['JENS_KNTR'].toString(),
          style: styleRowReguler)),
      DataCell(Text(listKantor[index]['NAMA_KNTR'].toString(),
          style: styleRowReguler)),
      DataCell(Text(listKantor[index]['ALMT_KNTR'].toString(),
          style: styleRowReguler)),
      DataCell(Text(listKantor[index]['TELP_KNTR'].toString(),
          style: styleRowReguler)),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 5),
            ButtonEdit(
              idKantor: listKantor[index]['KDXX_KNTR'].toString(),
            ),
            const SizedBox(width: 5),
            ButtonHapus(
              idKantor: listKantor[index]['KDXX_KNTR'].toString(),
            ),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listKantor.length;

  @override
  int get selectedRowCount => 0;
}

class TableKantor extends StatefulWidget {
  final List<Map<String, dynamic>> listKantor;
  const TableKantor({Key key, @required this.listKantor}) : super(key: key);

  @override
  State<TableKantor> createState() => _TableKantorState();
}

class _TableKantorState extends State<TableKantor> {
  @override
  Widget build(BuildContext context) {
    final DataTableSource myTable = MyData(widget.listKantor);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.9,
      height: 0.6 * screenHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          source: myTable,
          columns: const [
            DataColumn(label: Text('No.', style: styleColumn)),
            DataColumn(label: Text('Jenis Kantor', style: styleColumn)),
            DataColumn(label: Text('Nama Kantor', style: styleColumn)),
            DataColumn(label: Text('Alamat', style: styleColumn)),
            DataColumn(label: Text('No Telepon', style: styleColumn)),
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
