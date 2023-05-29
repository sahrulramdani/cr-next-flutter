// ignore_for_file: must_be_immutable, missing_required_param

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/marketing/widgets/hotel/modal_cd_hotel.dart';
import 'package:flutter_web_course/pages/marketing/widgets/hotel/modal_hapus_hotel.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_hapus_jadwal.dart';
import 'package:flutter_web_course/pages/pengaturan/widget/musim/modal_update_musim.dart';
// import 'modal_cd_maskapai.dart';
// import 'modal_hapus_maskapai.dart';
// import 'package:intl/intl.dart';

/// Example without a datasource
// MYDATA

class ButtonEdit extends StatelessWidget {
  String idMusim;
  ButtonEdit({
    Key key,
    @required this.idMusim,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.power_settings_new_sharp,
        color: authEdit == '1' ? myBlue : Colors.red[700],
      ),
      onPressed: () {
        authEdit == '1'
            ? showDialog(
                context: context,
                builder: (context) => ModalUpdateMusim(idMusim: idMusim))
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
  final List<Map<String, dynamic>> listMusim;
  MyData(this.listMusim);

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(), style: styleRowReguler)),
      DataCell(Text(listMusim[index]['AWAL_MUSM'].toString(),
          style: styleRowReguler)),
      DataCell(Text(listMusim[index]['AKHR_MUSM'].toString(),
          style: styleRowReguler)),
      DataCell(Text(listMusim[index]['PELANGGAN'].toString(),
          style: styleRowReguler)),
      DataCell(Text(listMusim[index]['BERANGKAT'].toString(),
          style: styleRowReguler)),
      DataCell(Container(
        padding: const EdgeInsets.all(3),
        color: listMusim[index]['STAS_MUSM'] == '1' ? Colors.green : Colors.red,
        child: Text(
          listMusim[index]['STAS_MUSM'] == '1' ? 'Active' : 'NonActive',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      )),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonEdit(
              idMusim: listMusim[index]['KDXX_MUSM'].toString(),
            ),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listMusim.length;

  @override
  int get selectedRowCount => 0;
}

class TableMusim extends StatefulWidget {
  final List<Map<String, dynamic>> listMusim;
  const TableMusim({Key key, @required this.listMusim}) : super(key: key);

  @override
  State<TableMusim> createState() => _TableMusimState();
}

class _TableMusimState extends State<TableMusim> {
  @override
  Widget build(BuildContext context) {
    final DataTableSource myTable = MyData(widget.listMusim);
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.9,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          source: myTable,
          columns: const [
            DataColumn(label: Text('No.', style: styleColumn)),
            DataColumn(label: Text('Tanggal Awal', style: styleColumn)),
            DataColumn(label: Text('Tanggal Akhir', style: styleColumn)),
            DataColumn(label: Text('Pelanggan Musim Ini', style: styleColumn)),
            DataColumn(
                label: Text('Jamaah Berangkat Musim Ini', style: styleColumn)),
            DataColumn(label: Text('Status', style: styleColumn)),
            DataColumn(
                label: SizedBox(
                    width: 80,
                    child: Center(
                      child: Text('Opsi', style: styleColumn),
                    ))),
          ],
        ),
      ),
    );
  }
}
