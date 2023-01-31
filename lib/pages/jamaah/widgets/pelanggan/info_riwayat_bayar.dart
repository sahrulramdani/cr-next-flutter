import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';

class InfoRiwayatBayar extends StatelessWidget {
  const InfoRiwayatBayar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.print_outlined),
              label: const Text(
                'Print Nota',
                style: TextStyle(fontFamily: 'Gilroy'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: myBlue,
                minimumSize: const Size(280, 40),
                shadowColor: Colors.grey,
                elevation: 5,
              ),
            ),
            const SizedBox(height: 20),
            DataTable(border: TableBorder.all(color: Colors.grey), columns: [
              DataColumn(
                  label: Text('No.',
                      style: TextStyle(
                          color: myGrey, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('REF',
                      style: TextStyle(
                          color: myGrey, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Operasional',
                      style: TextStyle(
                          color: myGrey, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Akun',
                      style: TextStyle(
                          color: myGrey, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Nominal',
                      style: TextStyle(
                          color: myGrey, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Jenis',
                      style: TextStyle(
                          color: myGrey, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Status',
                      style: TextStyle(
                          color: myGrey, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Kas',
                      style: TextStyle(
                          color: myGrey, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Kantor',
                      style: TextStyle(
                          color: myGrey, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Keterangan',
                      style: TextStyle(
                          color: myGrey, fontWeight: FontWeight.bold))),
            ], rows: const [
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('B20019920129')),
                DataCell(Text('24-12-2022 08:22')),
                DataCell(Text('HANDLING')),
                DataCell(Text('1,500,000')),
                DataCell(Text('Debet')),
                DataCell(Text('Lunas')),
                DataCell(Text('KECIL')),
                DataCell(Text('PUSAT')),
                DataCell(Text('Full Payment Handling')),
              ]),
              DataRow(cells: [
                DataCell(Text('2')),
                DataCell(Text('B20019920130')),
                DataCell(Text('24-12-2022 08:22')),
                DataCell(Text('VAKSIN')),
                DataCell(Text('500,000')),
                DataCell(Text('Debet')),
                DataCell(Text('Lunas')),
                DataCell(Text('KECIL')),
                DataCell(Text('PUSAT')),
                DataCell(Text('Full Payment Vaksin')),
              ]),
              DataRow(cells: [
                DataCell(Text('3')),
                DataCell(Text('B20019920132')),
                DataCell(Text('24-12-2022 08:22')),
                DataCell(Text('PAKET UMROH')),
                DataCell(Text('28,900,000')),
                DataCell(Text('Debet')),
                DataCell(Text('Lunas')),
                DataCell(Text('KECIL')),
                DataCell(Text('PUSAT')),
                DataCell(Text('Full Payment Paket Umroh')),
              ]),
            ]),
          ],
        ),
      ),
    );
  }
}
