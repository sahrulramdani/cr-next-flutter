import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:flutter_web_course/pages/jamaah/widgets/modal_edit_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jadwal.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_upload_jamaah.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:intl/intl.dart';

class ButtonChat extends StatelessWidget {
  const ButtonChat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.chat_outlined,
        color: myBlue,
      ),
      onPressed: () => launch(
          'https://api.whatsapp.com/send/?phone=62895616007743&text&type=phone_number&app_absent=0'),
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> dataAlumni;
  MyData(this.dataAlumni);

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(),
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(dataAlumni[index]['identitas'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(dataAlumni[index]['nama_lengkap'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(dataAlumni[index]['jenis_kelamin'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(
          '${dataAlumni[index]['tempat_lahir']}, ${dataAlumni[index]['in_tanggallahir']}',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(dataAlumni[index]['tg_berangkat'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(dataAlumni[index]['alamat'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(dataAlumni[index]['nama_marketing'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(dataAlumni[index]['telepon'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            ButtonChat(),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataAlumni.length;

  @override
  int get selectedRowCount => 0;
}

class TableAlumni extends StatefulWidget {
  final List<Map<String, dynamic>> dataAlumni;
  const TableAlumni({Key key, @required this.dataAlumni}) : super(key: key);

  @override
  State<TableAlumni> createState() => _TableAlumniState();
}

class _TableAlumniState extends State<TableAlumni> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final DataTableSource myTable = MyData(widget.dataAlumni);

    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.72,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          columnSpacing: 15,
          source: myTable,
          columns: const [
            DataColumn(
                label: Text('No.',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('NIK',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Nama Lengkap',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Jenis Kelamin',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Tempat, Tanggal Lahir',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Berangkat',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Alamat',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Agency',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Telepon',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: SizedBox(
                    width: 80,
                    child: Center(
                      child: Text('Aksi',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy',
                              fontSize: 16)),
                    )))
          ],
        ),
      ),
    );
  }
}
