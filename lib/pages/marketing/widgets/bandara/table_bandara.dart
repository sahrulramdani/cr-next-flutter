// ignore_for_file: must_be_immutable, missing_required_param

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/marketing/widgets/bandara/modal_cd_bandara.dart';
import 'package:flutter_web_course/pages/marketing/widgets/bandara/modal_hapus_bandara.dart';

/// Example without a datasource
// MYDATA

class ButtonEdit extends StatelessWidget {
  String idBandara;
  ButtonEdit({
    Key key,
    @required this.idBandara,
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
                builder: (context) => ModalCdBandara(
                      idBandara: idBandara,
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
  String idBandara;
  ButtonHapus({Key key, @required this.idBandara}) : super(key: key);

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
                builder: (context) => ModalHapusBandara(idBandara: idBandara))
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
  final List<Map<String, dynamic>> listBandara;
  MyData(this.listBandara);

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(), style: styleRowReguler)),
      DataCell(
          Text(listBandara[index]['NAMA_BAND'] ?? '-', style: styleRowReguler)),
      DataCell(
          Text(listBandara[index]['KDXX_BAND'] ?? '-', style: styleRowReguler)),
      DataCell(
          Text(listBandara[index]['JENIS'] ?? '-', style: styleRowReguler)),
      DataCell(Text(
          "${listBandara[index]['KOTA'] ?? '|'} - ${listBandara[index]['PROVINSI'] ?? '|'} - ${listBandara[index]['NEGARA'] ?? '|'}",
          style: styleRowReguler)),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 5),
            ButtonEdit(
              idBandara: listBandara[index]['IDXX_BAND'].toString(),
            ),
            const SizedBox(width: 5),
            ButtonHapus(
              idBandara: listBandara[index]['IDXX_BAND'].toString(),
            ),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listBandara.length;

  @override
  int get selectedRowCount => 0;
}

class TableBandara extends StatefulWidget {
  final List<Map<String, dynamic>> listBandara;
  const TableBandara({Key key, @required this.listBandara}) : super(key: key);

  @override
  State<TableBandara> createState() => _TableBandaraState();
}

class _TableBandaraState extends State<TableBandara> {
  @override
  Widget build(BuildContext context) {
    final DataTableSource myTable = MyData(widget.listBandara);
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
            DataColumn(label: Text('Nama Bandara', style: styleColumn)),
            DataColumn(label: Text('Kode', style: styleColumn)),
            DataColumn(label: Text('Jenis', style: styleColumn)),
            DataColumn(label: Text('Lokasi', style: styleColumn)),
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
