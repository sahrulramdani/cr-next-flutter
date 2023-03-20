import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/marketing/widgets/tourlead/modal_edit_tourlead.dart';

// import 'package:intl/intl.dart';
class ButtonEdit extends StatelessWidget {
  const ButtonEdit({Key key}) : super(key: key);

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
                builder: (context) => const ModalEditTourlead())
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
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(), style: styleRowReguler)),
      DataCell(
          Text(listKelolaTourLead[index]['id_lead'], style: styleRowReguler)),
      DataCell(Text(listKelolaTourLead[index]['nama'], style: styleRowReguler)),
      DataCell(
          Text(listKelolaTourLead[index]['level'], style: styleRowReguler)),
      DataCell(
          Text(listKelolaTourLead[index]['sukses'], style: styleRowReguler)),
      DataCell(
          Text(listKelolaTourLead[index]['pending'], style: styleRowReguler)),
      DataCell(Text(listKelolaTourLead[index]['2022'], style: styleRowReguler)),
      DataCell(Text(listKelolaTourLead[index]['naik'], style: styleRowReguler)),
      DataCell(
          Text(listKelolaTourLead[index]['total'], style: styleRowReguler)),
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
  int get rowCount => listKelolaTourLead.length;

  @override
  int get selectedRowCount => 0;
}

class TableTourleader extends StatefulWidget {
  const TableTourleader({Key key}) : super(key: key);

  @override
  State<TableTourleader> createState() => _TableTourleaderState();
}

class _TableTourleaderState extends State<TableTourleader> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final DataTableSource myTable = MyData();

    return SizedBox(
      width: screenWidth,
      height: fncHeightTableWithCard(context),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          source: myTable,
          columnSpacing: 15,
          columns: const [
            DataColumn(label: Text('No.', style: styleColumn)),
            DataColumn(label: Text('ID', style: styleColumn)),
            DataColumn(label: Text('Nama', style: styleColumn)),
            DataColumn(label: Text('Level', style: styleColumn)),
            DataColumn(label: Text('Sukses', style: styleColumn)),
            DataColumn(label: Text('Pending', style: styleColumn)),
            DataColumn(label: Text('2022', style: styleColumn)),
            DataColumn(label: Text('Naik Level', style: styleColumn)),
            DataColumn(label: Text('Total', style: styleColumn)),
            DataColumn(
                label: SizedBox(
                    width: 80,
                    child: Center(
                      child: Text('Aksi', style: styleColumn),
                    )))
          ],
        ),
      ),
    );
  }
}
