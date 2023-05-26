import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ModalEditTourlead extends StatefulWidget {
  final String idAgen;
  final String namaAgen;
  final String nik;
  const ModalEditTourlead(
      {Key key,
      @required this.idAgen,
      @required this.namaAgen,
      @required this.nik})
      : super(key: key);

  @override
  State<ModalEditTourlead> createState() => _ModalEditTourleadState();
}

class _ModalEditTourleadState extends State<ModalEditTourlead> {
  List<Map<String, dynamic>> listDetJadwalTL = [];
  List<Map<String, dynamic>> listDetJamaahTL = [];

  void getDetTourlead() async {
    var id = widget.idAgen;
    var nik = widget.nik;
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/tourlead/detail-jadwal-tl/$id/$nik"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    var first = {
      "TGLX_BGKT": 'Sistem Lama 2017',
      "KETERANGAN": '',
      "STAS_BGKT": 'Y',
      "TOTAL": '',
      "SENDIRI": '',
      "PERD": '',
    };

    listDetJadwalTL.add(first);

    int perd = 0;
    for (var i = 0; i < data.length; i++) {
      var sisa = perd - 20;

      if (sisa > 0) {
        perd = sisa;

        var list = {
          "TGLX_BGKT": 'Kesempatan Berangkat',
          "KETERANGAN": '',
          "STAS_BGKT": 'X',
          "TOTAL": sisa,
          "SENDIRI": '',
          "PERD": '',
        };

        listDetJadwalTL.add(list);
      } else {}
      perd += data[i]['TOTAL'];

      var list = {
        "TGLX_BGKT": data[i]['TGLX_BGKT'],
        "KETERANGAN": data[i]['KETERANGAN'],
        "STAS_BGKT": data[i]['STAS_BGKT'],
        "TOTAL": data[i]['TOTAL'],
        "SENDIRI": data[i]['SENDIRI'],
        "PERD": perd,
      };

      listDetJadwalTL.add(list);
    }

    setState(() {});
    // loadEnd();
  }

  void getJamaahTL(id, tgl) async {
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/tourlead/detail-jamaah-tl/$id/$tgl"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listDetJamaahTL = data;
    });
  }

  @override
  void initState() {
    getDetTourlead();
    super.initState();
  }

  Widget cmdPrint() {
    return ElevatedButton.icon(
      onPressed: () {
        authPrnt == '1'
            ? ''
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
      icon: const Icon(Icons.print_outlined),
      label: const Text(
        'Print Akumulatif',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: authInqu == '1' ? myBlue : Colors.blue[200],
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdRefresh() {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          listDetJamaahTL = [];
        });
      },
      icon: const Icon(Icons.restart_alt_outlined),
      label: const Text(
        'Refresh',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget menuButton() => SizedBox(
        height: 50,
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            cmdPrint(),
          ],
        ),
      );

  Widget menuRefresh() => SizedBox(
        height: 50,
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            cmdRefresh(),
          ],
        ),
      );

  fncColorRow(kode) {
    if (kode == 'Y') {
      return myBlue;
    } else if (kode == 'X') {
      return Colors.green[600];
    } else {
      return Colors.white;
    }
  }

  fncTextColorRow(kode) {
    if (kode == 'Y' || kode == 'X') {
      return const TextStyle(
          color: Colors.white, fontFamily: 'Gilroy', fontSize: 11);
    } else {
      return const TextStyle(
          color: Colors.black, fontFamily: 'Gilroy', fontSize: 11);
    }
  }

  fncIcon(kode) {
    if (kode == 'Y') {
      return const Icon(
        Icons.calendar_month,
        color: Colors.white,
      );
    } else if (kode == 'X') {
      return const Icon(
        Icons.card_giftcard,
        color: Colors.white,
      );
    } else if (kode == '0') {
      return Icon(
        Icons.timer,
        color: Colors.orange[600],
      );
    } else {
      return Icon(
        Icons.check,
        color: Colors.green[600],
      );
    }
  }

  fncIconDep(kode) {
    if (kode == '1') {
      return const Icon(
        Icons.check,
        color: Colors.green,
      );
    } else {
      return const SizedBox();
    }
  }

  fncTanggalBerangkat(kode, tanggal) {
    if (kode == 'Y' || kode == 'X') {
      return tanggal;
    } else {
      return fncGetTanggal(tanggal);
    }
  }

  Widget detJadwalTL() {
    final screenWidth = MediaQuery.of(context).size.width;
    int i = 1;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: screenWidth,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: DataTable(
          dataRowHeight: 30,
          headingRowHeight: 30,
          headingTextStyle: const TextStyle(
              color: Colors.black,
              fontFamily: 'Gilroy',
              fontSize: 13,
              fontWeight: FontWeight.bold),
          columnSpacing: 5,
          columns: const [
            DataColumn(label: Text('No.')),
            DataColumn(label: Text('#')),
            DataColumn(label: Text('Pemberangkatan')),
            DataColumn(label: Text('Jamaah')),
            DataColumn(label: Text('Total')),
            DataColumn(label: Text('Dep')),
          ],
          rows: listDetJadwalTL.map((e) {
            return DataRow(
                onLongPress: () {
                  getJamaahTL(widget.idAgen, e['TGLX_BGKT']);
                },
                color: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return fncColorRow(e['STAS_BGKT']);
                }),
                cells: [
                  DataCell(Text((i++).toString(),
                      style: fncTextColorRow(e['STAS_BGKT']))),
                  DataCell(fncIcon(e['STAS_BGKT'].toString())),
                  DataCell(Text(
                      fncTanggalBerangkat(
                          e['STAS_BGKT'], e['TGLX_BGKT'].toString()),
                      style: fncTextColorRow(e['STAS_BGKT']))),
                  DataCell(Text((e['TOTAL']).toString(),
                      style: fncTextColorRow(e['STAS_BGKT']))),
                  DataCell(Text((e['PERD']).toString(),
                      style: fncTextColorRow(e['STAS_BGKT']))),
                  DataCell(fncIconDep(e['SENDIRI'].toString())),
                ]);
          }).toList(),
        ),
      ),
    );
  }

  Widget detJamaahTL() {
    int i = 1;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: listDetJamaahTL.isEmpty ? 600 : 700,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: DataTable(
          dataTextStyle: const TextStyle(
              color: Colors.black, fontFamily: 'Gilroy', fontSize: 11),
          headingRowHeight: 30,
          dataRowHeight: 30,
          headingTextStyle: const TextStyle(
              color: Colors.black,
              fontFamily: 'Gilroy',
              fontSize: 13,
              fontWeight: FontWeight.bold),
          columnSpacing: 5,
          columns: const [
            DataColumn(label: Text('No.')),
            DataColumn(label: Text('Nama Pelanggan')),
            DataColumn(label: Text('Jenis Kelamin')),
            DataColumn(label: Text('Alamat')),
          ],
          rows: listDetJamaahTL.map((e) {
            return DataRow(cells: [
              DataCell(Text((i++).toString())),
              DataCell(Text(e['NAMA_LGKP'])),
              DataCell(Text(e['JENS_KLMN'])),
              DataCell(Text(e['ALAMAT'])),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.9,
            height: 700,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.personal_injury_outlined,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      Text('TL. ${widget.namaAgen}', style: styleHeaderSmall),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ResponsiveWidget.isSmallScreen(context)
                    ? Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              SizedBox(
                                width: screenWidth * 0.8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Jadwal Keberangkatan',
                                        style: TextStyle(
                                            color: myGrey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    menuButton(),
                                    SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: detJadwalTL()),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Daftar Pelanggan',
                                        style: TextStyle(
                                            color: myGrey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    menuRefresh(),
                                    SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: detJamaahTL()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Jadwal Keberangkatan',
                                          style: TextStyle(
                                              color: myGrey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                      menuButton(),
                                      Expanded(
                                        child: detJadwalTL(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                  height: 700, width: 1, color: Colors.grey),
                              Expanded(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Daftar Pelanggan',
                                          style: TextStyle(
                                              color: myGrey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                      menuRefresh(),
                                      Expanded(
                                        child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: detJamaahTL()),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Kembali'))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
