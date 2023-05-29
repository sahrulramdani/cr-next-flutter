import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/marketing/widgets/tourlead/modal_edit_tourlead.dart';

// import 'package:intl/intl.dart';
class ButtonEdit extends StatelessWidget {
  final String idAgen;
  final String namaAgen;
  final String nik;
  const ButtonEdit(
      {Key key,
      @required this.idAgen,
      @required this.namaAgen,
      @required this.nik})
      : super(key: key);

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
                builder: (context) => ModalEditTourlead(
                      idAgen: idAgen,
                      namaAgen: namaAgen,
                      nik: nik,
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
  final List<Map<String, dynamic>> dataTourleader;
  MyData(this.dataTourleader);

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(), style: styleRowReguler)),
      DataCell(
          Text(dataTourleader[index]['KDXX_MRKT'], style: styleRowReguler)),
      DataCell(
          Text(dataTourleader[index]['NAMA_LGKP'], style: styleRowReguler)),
      DataCell(
          Text(dataTourleader[index]['FEE_LEVEL'], style: styleRowReguler)),
      DataCell(Text(dataTourleader[index]['TLH_BGKT'].toString(),
          style: styleRowReguler)),
      DataCell(Text(dataTourleader[index]['PENDING'].toString(),
          style: styleRowReguler)),
      DataCell(Text(dataTourleader[index]['TAHUN_INI'].toString(),
          style: styleRowReguler)),
      DataCell(Text(dataTourleader[index]['PERD_JMAH'].toString(),
          style: styleRowReguler)),
      DataCell(Text(dataTourleader[index]['TTL_SELURUH'].toString(),
          style: styleRowReguler)),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonEdit(
              idAgen: dataTourleader[index]['KDXX_MRKT'],
              namaAgen: dataTourleader[index]['NAMA_LGKP'],
              nik: dataTourleader[index]['NOXX_IDNT'],
            ),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataTourleader.length;

  @override
  int get selectedRowCount => 0;
}

class TableTourleader extends StatefulWidget {
  final List<Map<String, dynamic>> dataTourleader;

  const TableTourleader({Key key, @required this.dataTourleader})
      : super(key: key);

  @override
  State<TableTourleader> createState() => _TableTourleaderState();
}

class _TableTourleaderState extends State<TableTourleader> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final DataTableSource myTable = MyData(widget.dataTourleader);

    return SizedBox(
      width: screenWidth,
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
