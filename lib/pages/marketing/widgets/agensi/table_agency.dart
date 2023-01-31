import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:intl/intl.dart';
import 'package:flutter_web_course/pages/marketing/widgets/agensi/modal_hapus_agency.dart';
import 'package:flutter_web_course/pages/marketing/widgets/agensi/modal_edit_agency.dart';

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
        color: myBlue,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ModalHapusAgency(
                  idAgency: idAgen,
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
        Icons.info_outline,
        color: myBlue,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ModalEditAgency(
                  idAgency: idAgen,
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
    return DataRow(cells: [
      DataCell(Text(
        (index + 1).toString(),
        style: TextStyle(
            color: dataAgency[index]['STAS_AGEN'] == 'n'
                ? Colors.red
                : Colors.black),
      )),
      DataCell(Text(
        dataAgency[index]['KDXX_MRKT'].toString(),
        style: TextStyle(
            color: dataAgency[index]['STAS_AGEN'] == 'n'
                ? Colors.red
                : Colors.black),
      )),
      DataCell(Text(
        dataAgency[index]['NAMA_LGKP'].toString(),
        style: TextStyle(
            color: dataAgency[index]['STAS_AGEN'] == 'n'
                ? Colors.red
                : Colors.black),
      )),
      DataCell(Text(
        dataAgency[index]['FEE'].toString(),
        style: TextStyle(
            color: dataAgency[index]['STAS_AGEN'] == 'n'
                ? Colors.red
                : Colors.black),
      )),
      DataCell(Text(
        dataAgency[index]['FIRST_LVL'].toString(),
        style: TextStyle(
            color: dataAgency[index]['STAS_AGEN'] == 'n'
                ? Colors.red
                : Colors.black),
      )),
      DataCell(Text(
        DateFormat("dd-MM-yyyy")
            .format(DateTime.parse(dataAgency[index]['TGLX_GBNG'])),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: dataAgency[index]['STAS_AGEN'] == 'n'
                ? Colors.red
                : Colors.black),
      )),
      DataCell(Text(
        dataAgency[index]['PERD_JMAH'].toString(),
        style: TextStyle(
            color: dataAgency[index]['STAS_AGEN'] == 'n'
                ? Colors.red
                : Colors.black),
      )),
      DataCell(Text(
        dataAgency[index]['TOTL_JMAH'].toString(),
        style: TextStyle(
            color: dataAgency[index]['STAS_AGEN'] == 'n'
                ? Colors.red
                : Colors.black),
      )),
      DataCell(Text(
        dataAgency[index]['TOTL_POIN'].toString(),
        style: TextStyle(
            color: dataAgency[index]['STAS_AGEN'] == 'n'
                ? Colors.red
                : Colors.black),
      )),
      DataCell(Center(
        child: Row(
          children: [
            ButtonEdit(idAgen: dataAgency[index]['KDXX_MRKT'].toString()),
            const SizedBox(
              width: 5,
            ),
            ButtonHapus(idAgen: dataAgency[index]['KDXX_MRKT'].toString()),
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
                label: Text('ID Agency',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Nama Agen',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Fee Level',
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
                label: Text('Periode',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Pelanggan',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Poin',
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
