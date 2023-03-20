import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/marketing/widgets/agensi/modal_edit_agency.dart';
import 'package:intl/intl.dart';
import 'package:flutter_web_course/pages/marketing/widgets/agensi/modal_hapus_agency.dart';
import 'package:flutter_web_course/pages/marketing/widgets/agensi/modal_detail_agency.dart';

/// Example without a datasource
/// BUTTON HAPUS
class ButtonHapus extends StatelessWidget {
  final String idAgen;
  const ButtonHapus({Key key, @required this.idAgen}) : super(key: key);

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
                builder: (context) => ModalHapusAgency(
                      idAgency: idAgen,
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

/// BUTTON DETAIL
class ButtonDetail extends StatelessWidget {
  final String idAgen;
  const ButtonDetail({Key key, @required this.idAgen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.info_outline,
        color: authInqu == '1' ? myBlue : Colors.blue[200],
      ),
      onPressed: () {
        authInqu == '1'
            ? showDialog(
                context: context,
                builder: (context) => ModalDetailAgency(
                      idAgency: idAgen,
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

/// BUTTON DETAIL
class ButtonEdit extends StatelessWidget {
  final String idAgen;
  const ButtonEdit({Key key, @required this.idAgen}) : super(key: key);

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
                builder: (context) => ModalEditAgency(idAgency: idAgen))
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
    );
  }
}

// MYDATA
class MyData extends DataTableSource {
  final List<Map<String, dynamic>> dataAgency;
  MyData(this.dataAgency);

  @override
  DataRow getRow(int index) {
    final styleRow = TextStyle(
        fontWeight: FontWeight.bold,
        color: dataAgency[index]['STAS_AGEN'] == 0
            ? Colors.red
            : Colors.grey[800]);

    return DataRow(cells: [
      DataCell(Text((index + 1).toString(), style: styleRow)),
      DataCell(
          Text(dataAgency[index]['KDXX_MRKT'].toString(), style: styleRow)),
      DataCell(
          Text(dataAgency[index]['NAMA_LGKP'].toString(), style: styleRow)),
      DataCell(Text(dataAgency[index]['FEE'].toString(), style: styleRow)),
      DataCell(
          Text(dataAgency[index]['FIRST_LVL'].toString(), style: styleRow)),
      DataCell(Text(
          DateFormat("dd-MM-yyyy")
              .format(DateTime.parse(dataAgency[index]['TGLX_GBNG'])),
          textAlign: TextAlign.center,
          style: styleRow)),
      DataCell(
          Text(dataAgency[index]['TOTL_JMAH'].toString(), style: styleRow)),
      DataCell(
          Text(dataAgency[index]['PERD_JMAH'].toString(), style: styleRow)),
      DataCell(
          Text(dataAgency[index]['TOTL_POIN'].toString(), style: styleRow)),
      DataCell(Text((20 - dataAgency[index]['TOTL_POIN']).toString(),
          style: styleRow)),
      DataCell(Center(
        child: Row(
          children: [
            ButtonEdit(idAgen: dataAgency[index]['KDXX_MRKT'].toString()),
            const SizedBox(
              width: 5,
            ),
            ButtonDetail(idAgen: dataAgency[index]['KDXX_MRKT'].toString()),
            // const SizedBox(
            //   width: 5,
            // ),
            // ButtonHapus(idAgen: dataAgency[index]['KDXX_MRKT'].toString()),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataAgency.length;

  @override
  int get selectedRowCount => 0;
}

class TableAgency extends StatefulWidget {
  final List<Map<String, dynamic>> dataAgency;
  const TableAgency({Key key, @required this.dataAgency}) : super(key: key);

  @override
  State<TableAgency> createState() => _TableAgencyState();
}

class _TableAgencyState extends State<TableAgency> {
  @override
  Widget build(BuildContext context) {
    final DataTableSource myTable = MyData(widget.dataAgency);
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      height: fncHeightTableWithCard(context),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          columnSpacing: 5.0,
          source: myTable,
          columns: const [
            DataColumn(label: Text('No.', style: styleColumn)),
            DataColumn(label: Text('ID Agency', style: styleColumn)),
            DataColumn(label: Text('Nama Agen', style: styleColumn)),
            DataColumn(label: Text('Kategori Marketing', style: styleColumn)),
            DataColumn(label: Text('Level', style: styleColumn)),
            DataColumn(label: Text('Tgl. Bergabung', style: styleColumn)),
            DataColumn(label: Text('Total', style: styleColumn)),
            DataColumn(label: Text('Musim', style: styleColumn)),
            DataColumn(label: Text('Poin', style: styleColumn)),
            DataColumn(label: Text('Kurang Poin', style: styleColumn)),
            DataColumn(
                label: SizedBox(
              width: 80,
              child: Center(
                child: Text('Aksi', style: styleColumn),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
