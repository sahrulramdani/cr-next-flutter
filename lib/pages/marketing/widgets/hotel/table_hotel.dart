// ignore_for_file: must_be_immutable, missing_required_param

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/marketing/widgets/hotel/modal_cd_hotel.dart';
import 'package:flutter_web_course/pages/marketing/widgets/hotel/modal_hapus_hotel.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_hapus_jadwal.dart';
// import 'modal_cd_maskapai.dart';
// import 'modal_hapus_maskapai.dart';
// import 'package:intl/intl.dart';

/// Example without a datasource
// MYDATA

class ButtonEdit extends StatelessWidget {
  String idHotel;
  ButtonEdit({
    Key key,
    @required this.idHotel,
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
                builder: (context) => ModalCdHotel(
                      idHotel: idHotel,
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
  String idHotel;
  ButtonHapus({Key key, @required this.idHotel}) : super(key: key);

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
                builder: (context) => ModalHapusHotel(idHotel: idHotel))
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
  final List<Map<String, dynamic>> listHotel;
  MyData(this.listHotel);

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(), style: styleRowReguler)),
      DataCell(Text(listHotel[index]['NAMA_HTLX'].toString(),
          style: styleRowReguler)),
      DataCell(Text(listHotel[index]['CODD_DESC'].toString(),
          style: styleRowReguler)),
      DataCell(Text(listHotel[index]['LOKX_HTLX'].toString(),
          style: styleRowReguler)),
      DataCell(Text(listHotel[index]['ALMT_HTLX'].toString(),
          style: styleRowReguler)),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 5),
            ButtonEdit(
              idHotel: listHotel[index]['IDXX_HTLX'].toString(),
            ),
            const SizedBox(width: 5),
            ButtonHapus(
              idHotel: listHotel[index]['IDXX_HTLX'].toString(),
            ),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listHotel.length;

  @override
  int get selectedRowCount => 0;
}

class TableHotel extends StatefulWidget {
  final List<Map<String, dynamic>> listHotel;
  const TableHotel({Key key, @required this.listHotel}) : super(key: key);

  @override
  State<TableHotel> createState() => _TableHotelState();
}

class _TableHotelState extends State<TableHotel> {
  @override
  Widget build(BuildContext context) {
    final DataTableSource myTable = MyData(widget.listHotel);
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.9,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          source: myTable,
          columns: const [
            DataColumn(label: Text('No.', style: styleColumn)),
            DataColumn(label: Text('Nama', style: styleColumn)),
            DataColumn(label: Text('Bintang', style: styleColumn)),
            DataColumn(label: Text('Lokasi', style: styleColumn)),
            DataColumn(label: Text('Alamat', style: styleColumn)),
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
