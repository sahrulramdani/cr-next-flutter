import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/constants/dummy_pelanggan.dart';
import 'package:flutter_web_course/pages/marketing/widgets/pemberangkatan/modal_konfirmasi_pemberangkatan.dart';

class DetailPemberangkatanJamaah extends StatelessWidget {
  String idJadwal;
  DetailPemberangkatanJamaah({Key key, @required this.idJadwal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List<Map<String, dynamic>> listPelangganPemberangkatanDummy =
        dummyPelangganTable
            .where(
                (element) => element['id_jadwal'].toString().contains(idJadwal))
            .toList();
    int x = 1;

    return SizedBox(
      width: screenWidth,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              DataTable(
                  columns: [
                    DataColumn(
                        label: Text('No.',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                    DataColumn(
                        label: Text('ID Pelanggan',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                    DataColumn(
                        label: Text('Nama',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                    DataColumn(
                        label: Text('ID Marketing',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                    DataColumn(
                        label: Text('Marketing',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                    DataColumn(
                        label: Text('Jenis',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                    DataColumn(
                        label: Text('Level',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                    DataColumn(
                        label: Text('Pendaftaran Via',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                    DataColumn(
                        label: Text('Jamaah Ke',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                    DataColumn(
                        label: Text('Biaya',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                    DataColumn(
                        label: Text('VB',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16))),
                    DataColumn(
                        label: Text('Aksi',
                            style: TextStyle(
                                color: myGrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy',
                                fontSize: 16)))
                  ],
                  rows: listPelangganPemberangkatanDummy.map((data) {
                    return DataRow(cells: [
                      DataCell(Text((x++).toString())),
                      DataCell(Text(data['id_pelanggan'])),
                      DataCell(Text(data['nama_lengkap'])),
                      DataCell(Text(data['id_marketing'])),
                      DataCell(Text(data['nama_marketing'])),
                      DataCell(Text(data['refjam'])),
                      const DataCell(Text('Jamaah')),
                      DataCell(Text(data['sebutan'])),
                      DataCell(Text(x.toString())),
                      DataCell(Text(data['dpe_status'])),
                      const DataCell(Icon(
                        '1' == '1' ? Icons.check : Icons.add_alert_outlined,
                        color: '1' == '1' ? Colors.green : Colors.red,
                      )),
                      DataCell(IconButton(
                        icon: Icon(
                          Icons.info_outline,
                          color: myBlue,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  const ModalKonfirmasiBerangkat());
                        },
                      )),
                    ]);
                  }).toList()),
            ],
          ),
        ),
      ),
    );
  }
}
