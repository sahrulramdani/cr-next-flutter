// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_hapus_jadwal.dart';
import 'package:flutter_web_course/pages/marketing/widgets/laporan-tahunan/modal_detail_pencapaian.dart';
import 'package:flutter_web_course/pages/marketing/widgets/laporan-tahunan/modal_detail_perolehan.dart';

class TableDetailPencapaian extends StatefulWidget {
  final List<Map<String, dynamic>> listDetailPencapaian;
  const TableDetailPencapaian({Key key, @required this.listDetailPencapaian})
      : super(key: key);

  @override
  State<TableDetailPencapaian> createState() => _TableDetailPencapaianState();
}

class _TableDetailPencapaianState extends State<TableDetailPencapaian> {
  fncGetColor(nomor) {
    if (nomor == 1) {
      return MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
        return const Color.fromARGB(255, 255, 217, 0);
      });
    } else if (nomor == 2) {
      return MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
        return const Color.fromARGB(255, 192, 192, 192);
      });
    } else if (nomor == 3) {
      return MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
        return const Color.fromARGB(255, 205, 128, 50);
      });
    } else {
      return MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
        return Colors.white;
      });
    }
  }

  fncGetIcon(nomor) {
    if (nomor == 1) {
      return const Image(
        width: 40,
        fit: BoxFit.cover,
        image: AssetImage('images/gold-medal.png'),
      );
    } else if (nomor == 2) {
      return const Image(
        width: 40,
        fit: BoxFit.cover,
        image: AssetImage('images/silver-medal.png'),
      );
    } else if (nomor == 3) {
      return const Image(
        width: 40,
        fit: BoxFit.cover,
        image: AssetImage('images/bronze-medal.png'),
      );
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final DataTableSource myTable = MyData(widget.listDetailPencapaian, context);
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    int x = 1;

    return SizedBox(
        width: screenWidth * 0.75,
        child: DataTable(
          headingRowColor: MaterialStateColor.resolveWith((states) => myBlue),
          columns: const [
            DataColumn(
                label: Text('No.',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text(' ',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Nama Lengkap',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Pencapaian Jamaah',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
          ],
          rows: widget.listDetailPencapaian.map((e) {
            return DataRow(color: fncGetColor(x), cells: [
              DataCell(Text((x++).toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                      fontSize: 16))),
              DataCell(fncGetIcon(x - 1)),
              DataCell(Text(e['NAMA_LGKP'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                      fontSize: 16))),
              DataCell(Text(e['PEROLEHAN'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                      fontSize: 16))),
            ]);
          }).toList(),
        ));
  }
}
