// ignore_for_file: deprecated_member_use, missing_return, avoid_print, unrelated_type_equality_checks, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:flutter_web_course/comp/header_title_menu.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/models/http_pendaftaran.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pendaftaran/table_side_pendaftaran.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
// import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class JamaahPendaftaranPage extends StatefulWidget {
  const JamaahPendaftaranPage({Key key}) : super(key: key);

  @override
  State<JamaahPendaftaranPage> createState() => _JamaahPendaftaranPageState();
}

class _JamaahPendaftaranPageState extends State<JamaahPendaftaranPage>
    with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  String idKantor;
  String namaKantor;
  String idProduk;
  String namaProduk;
  String nik;
  String namaPelanggan;
  String kk;
  String ktp;
  String lampiran;
  String pembuatan;
  String vaksin;
  String kamar;
  String handling;
  String textHandling = 'List Barang Handling';
  String refrensi;
  String namaAgency;
  String totalEst;
  String tglBerangkat;

  String paket;
  String jenisKelamin;
  String tarif;
  String harga;
  String berangkat;
  String pulang;
  String umur;
  String alamat;
  String paspor;
  String fasilitas;
  // String biaya;
  String biayaVaksin = '0';
  String biayaPaspor = '0';
  String biayaAdmin = '0';
  String biayaKamar = '0';
  String biayaHandling = '0';
  String estimasi = '0';
  String mataUang;

  String ktpPelanggan;
  String ktpPelangganBase = "";
  Uint8List ktpPelangganByte;

  String fotoKkPelanggan = "";
  String fotoKkPelangganBase = "";
  Uint8List fotoKkPelangganByte;

  String fotoDokPelanggan = "";
  String fotoDokPelangganBase = "";
  Uint8List fotoDokPelangganByte;

  bool enableMarket = false;
  bool disableHand = true;
  bool isKtp = true;

  List<Map<String, dynamic>> listJamaah = [];
  List<Map<String, dynamic>> listBarangHandling = [];
  List<Map<String, dynamic>> listBarangPelanggan = [];
  List<Map<String, dynamic>> listJadwal = [];
  List<Map<String, dynamic>> listBiayaPaspor = [];
  List<Map<String, dynamic>> listBiayaVaksin = [];
  List<Map<String, dynamic>> listBiayaKamar = [];
  List<Map<String, dynamic>> listAgency = [];
  List<Map<String, dynamic>> listTagihan = [];

  void getAuth() async {
    var response = await http.get(
        Uri.parse("$urlAddress/get-permission/$menuKode/$username"),
        headers: {
          'pte-token': kodeToken,
        });

    var auth = json.decode(response.body);
    setState(() {
      authAddx = auth['AUTH_ADDX'];
      authEdit = auth['AUTH_EDIT'];
      authDelt = auth['AUTH_DELT'];
      authInqu = auth['AUTH_INQU'];
      authPrnt = auth['AUTH_PRNT'];
      authExpt = auth['AUTH_EXPT'];
    });
  }

  getKantor() async {
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/jadwal/getKantorUser/$username"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      idKantor = dataStatus[0]['KDXX_KNTR'];
      namaKantor = dataStatus[0]['NAMA_KNTR'];
    });
  }

  void getJamaah() async {
    var response =
        await http.get(Uri.parse("$urlAddress/jamaah/all-jamaah"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listJamaah = dataStatus;
    });
  }

  getJadwal() async {
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/jadwal/get-jadwal"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listJadwal = dataStatus;
    });
  }

  void getBiayaPaspor() async {
    var response =
        await http.get(Uri.parse("$urlAddress/setup/biaya-paspor"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listBiayaPaspor = dataStatus;
    });
  }

  void getBiayaVaksin() async {
    var response =
        await http.get(Uri.parse("$urlAddress/setup/biaya-vaksin"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listBiayaVaksin = dataStatus;
    });
  }

  void getBiayaKamar() async {
    var response =
        await http.get(Uri.parse("$urlAddress/setup/biaya-kamar"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listBiayaKamar = dataStatus;
    });
  }

  void getBiayaAdmin() async {
    NumberFormat myformat = NumberFormat.decimalPattern('en_us');
    var response =
        await http.get(Uri.parse("$urlAddress/setup/biaya-admin"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      biayaAdmin = myformat.format(dataStatus[0]['JMLH_BYAX'] ?? 0);
    });

    fncTotal();
  }

  void getAgency() async {
    var response =
        await http.get(Uri.parse("$urlAddress/marketing/all-agency"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listAgency = dataStatus;
    });
  }

  void getBarangHandling(jk) async {
    var response = await http.get(
        Uri.parse("$urlAddress/jamaah/pendaftaran/get-handling/$jk"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listBarangHandling = [];
    });

    for (var i = 0; i < dataStatus.length; i++) {
      var barang = {
        "KDXX_BRGX": dataStatus[i]['KDXX_BRGX'].toString(),
        "NAMA_BRGX": dataStatus[i]['NAMA_BRGX'].toString(),
        "JENS_BRGX": dataStatus[i]['JENS_BRGX'].toString(),
        "STOK_BRGX": dataStatus[i]['STOK_BRGX'].toString(),
        "HRGX_BELI": dataStatus[i]['HRGX_BELI'].toString(),
        "HRGX_JUAL": dataStatus[i]['HRGX_JUAL'].toString(),
        "KETERANGAN": dataStatus[i]['KETERANGAN'].toString(),
        "JMLH": dataStatus[i]['JMLH'].toString(),
        "SUBTOTAL":
            (dataStatus[i]['HRGX_JUAL'] * dataStatus[i]['JMLH']).toString(),
        "CEK": dataStatus[i]['JMLH'] == 0 ? false : true,
      };
      listBarangHandling.add(barang);
    }

    int ttl = 0;
    for (var j = 0; j < dataStatus.length; j++) {
      if (dataStatus[j]['JMLH'] != 0) {
        ttl += (dataStatus[j]['HRGX_JUAL'] * dataStatus[j]['JMLH']);
      }
    }

    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    setState(() {
      biayaHandling = myFormat.format(ttl).toString();
    });
  }

  @override
  void initState() {
    loadStart();
    getAuth();
    getKantor();
    getJamaah();
    getJadwal();
    getBiayaPaspor();
    getBiayaVaksin();
    getBiayaKamar();
    getBiayaAdmin();
    getAgency();
    loadEnd();
    super.initState();
  }

  Widget inputKantor() {
    return TextFormField(
      initialValue: namaKantor ?? 'Kantor Tidak Terdeteksi',
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Nama Kantor', hintText: ''),
    );
  }

  Widget inputNamapelanggan() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      height: 50,
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Nama Pelanggan",
          items: listJamaah,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                nik = value['NOXX_IDNT'];
                namaPelanggan = value["NAMA_LGKP"];
                umur = value['UMUR'].toString();
                alamat = value['ALAMAT'];
                paspor =
                    value['NOXX_PSPR'] != null ? 'Tersedia' : 'Tidak Tersedia';

                ktp = value['FOTO_KTPX'] != '' ? 'KTP' : 'Belum';
                kk = 'Belum';
                lampiran = 'Belum';
                ktpPelanggan =
                    value['FOTO_KTPX'] == '' ? null : value['FOTO_KTPX'];
                isKtp = value['FOTO_KTPX'] == '' ? false : true;
                jenisKelamin = value['JENS_KLMN'] == 'P' ? 'L' : 'P';
                disableHand = false;
                textHandling = 'Lihat List Barang Handling';
                getBarangHandling(value['JENS_KLMN'] == 'P' ? 'L' : 'P');
              });
            } else {
              setState(() {
                nik = null;
                namaPelanggan = '';
                umur = '';
                alamat = '';
                paspor = '';

                ktp = null;
                kk = null;
                lampiran = null;
                ktpPelanggan = null;
                isKtp = false;
                jenisKelamin = null;
                disableHand = true;
                textHandling = 'Barang Handling';
                getBarangHandling(null);
              });
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['NAMA_LGKP'].toString()),
                leading: CircleAvatar(
                  backgroundImage: item['FOTO_JMAH'] != ""
                      ? NetworkImage(
                          '$urlAddress/uploads/foto/${item['FOTO_JMAH']}')
                      : const AssetImage('assets/images/box-background.png'),
                ),
                subtitle: Text(item['NOXX_IDNT'].toString()),
                trailing: Text(
                    DateFormat("dd-MM-yyyy")
                        .format(DateTime.parse(item['TGLX_LHIR'].toString())),
                    textAlign: TextAlign.center),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
              namaPelanggan ?? "Pelanggan Belum dipilih",
              style: TextStyle(
                  color: namaPelanggan == null ? Colors.red : Colors.black)),
          validator: (value) {
            if (value == null) {
              return "Nama Pelanggan masih kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputNamaJadwal() {
    NumberFormat myformat = NumberFormat.decimalPattern('en_us');

    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Jadwal",
          items: listJadwal,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                idProduk = value['IDXX_JDWL'];
                paket = value["namaPaket"] +
                    ' ' +
                    value['jenisPaket'] +
                    ' - ' +
                    value['KETERANGAN'];
                tarif = myformat.format(value['TARIF_PKET']);
                berangkat = fncGetTanggal(value['TGLX_BGKT']);
                pulang = fncGetTanggal(value['TGLX_PLNG'] ?? '10-12-2023');
                harga = myformat.format(value['TARIF_PKET']);
                mataUang = value['MATA_UANG'];
                tglBerangkat = value['TGLX_BGKT'];
              });
              fncTotal();
            } else {
              setState(() {
                idProduk = '';
                paket = '';
                tarif = '';
                berangkat = '';
                pulang = '';
                harga = '';
                mataUang = '';
                tglBerangkat;
              });
              fncTotal();
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(
                  item['namaPaket'] +
                      ' - ' +
                      item['jenisPaket'] +
                      ' - ' +
                      item['KETERANGAN'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    item['MATA_UANG'] +
                        ' ' +
                        myformat.format(item['TARIF_PKET']) +
                        ' - ' +
                        'Sisa Seat : ' +
                        item['SISA'].toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(
                    fncGetTanggal(item['TGLX_BGKT']) +
                        ' - ' +
                        fncGetTanggal(item['TGLX_PLNG'] ?? '01-12-2023'),
                    textAlign: TextAlign.center),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
              paket ?? "Jadwal Belum dipilih",
              style:
                  TextStyle(color: paket == null ? Colors.red : Colors.black)),
          validator: (value) {
            if (value == null) {
              return "Jadwal Produk masih kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputKTP() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "KTP",
          mode: Mode.MENU,
          items: const [
            "KTP",
            "Belum",
          ],
          onChanged: (value) {
            ktp = value;
          },
          dropdownBuilder: (context, selectedItem) => Text(
              ktp ?? "Pilih Status KTP",
              style: TextStyle(color: ktp == null ? Colors.red : Colors.black)),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputKK() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "KK",
          mode: Mode.MENU,
          items: const [
            "KK",
            "Belum",
          ],
          onChanged: (value) {
            kk = value;
          },
          dropdownBuilder: (context, selectedItem) => Text(
              kk ?? "Pilih Status KK",
              style: TextStyle(color: kk == null ? Colors.red : Colors.black)),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputLampiran() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "Lampiran lainnya",
          mode: Mode.MENU,
          items: const [
            "Akte",
            "Surat Nikah",
            "Ijazah",
            "Belum",
          ],
          onChanged: (value) {
            lampiran = value;
          },
          dropdownBuilder: (context, selectedItem) => Text(
              lampiran ?? "Lampiran",
              style: TextStyle(
                  color: lampiran == null ? Colors.red : Colors.black)),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputPaspor() {
    NumberFormat myformat = NumberFormat.decimalPattern('en_us');
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "Paspor",
          mode: Mode.MENU,
          onChanged: (value) {
            setState(() {
              pembuatan = value['NAMA_BYAX'];
              biayaPaspor = myformat.format(value['JMLH_BYAX']);
            });

            fncTotal();
          },
          items: listBiayaPaspor,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['NAMA_BYAX'].toString()),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
              pembuatan ?? "Pilih Paspor",
              style: TextStyle(
                  color: pembuatan == null ? Colors.red : Colors.black)),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputVaksin() {
    NumberFormat myformat = NumberFormat.decimalPattern('en_us');
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "Vaksin",
          mode: Mode.MENU,
          onChanged: (value) {
            setState(() {
              vaksin = value['NAMA_BYAX'];
              biayaVaksin = myformat.format(value['JMLH_BYAX']);
            });

            fncTotal();
          },
          items: listBiayaVaksin,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['NAMA_BYAX'].toString()),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
              vaksin ?? "Pilih Vaksin",
              style:
                  TextStyle(color: vaksin == null ? Colors.red : Colors.black)),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputKamar() {
    NumberFormat myformat = NumberFormat.decimalPattern('en_us');
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "Kamar",
          mode: Mode.MENU,
          onChanged: (value) {
            setState(() {
              kamar = value['NAMA_BYAX'];
              biayaKamar = myformat.format(value['JMLH_BYAX']);
            });

            fncTotal();
          },
          items: listBiayaKamar,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['NAMA_BYAX'].toString()),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
              kamar ?? "Pilih Kamar",
              style:
                  TextStyle(color: kamar == null ? Colors.red : Colors.black)),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputStatusHandling() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "Status Handling",
          mode: Mode.MENU,
          items: const [
            "Diterima Lengkap",
            "Diterima Sebagian",
            "Belum Diterima",
            "Tidak Dengan Handling",
          ],
          onChanged: (value) {
            handling = value;
          },
          selectedItem: "Pilih Status Handling",
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputHandling() {
    return TextFormField(
      initialValue: textHandling ?? 'Barang Handling',
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Handling', hintText: ''),
    );
  }

  // WIDGET MODAL HANDLING
  Widget barangHandling(context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int x = 1;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: 700,
            height: 700,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.people_alt_outlined,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      Text('Barang Handling',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                    child: SizedBox(
                  width: screenWidth,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                          dataRowHeight: 35,
                          headingRowHeight: 40,
                          border: TableBorder.all(color: Colors.grey),
                          columns: const [
                            DataColumn(label: Text('No.', style: styleColumn)),
                            DataColumn(
                                label: Text('Nama Barang', style: styleColumn)),
                            DataColumn(
                                label: Text('Harga', style: styleColumn)),
                            DataColumn(
                                label: Text('Jumlah', style: styleColumn)),
                            DataColumn(
                                label: Text('Subtotal', style: styleColumn)),
                          ],
                          rows: listBarangHandling.map((data) {
                            return DataRow(cells: [
                              DataCell(Text((x++).toString())),
                              DataCell(Text(data['NAMA_BRGX'] ?? '-')),
                              DataCell(Text(data['HRGX_JUAL'] ?? '-')),
                              DataCell(TextFormField(
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 19)),
                                style: const TextStyle(
                                    fontFamily: 'Gilroy', fontSize: 15),
                                initialValue: data['JMLH'],
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    data['SUBTOTAL'] =
                                        (int.parse(data['HRGX_JUAL']) *
                                                int.parse(value))
                                            .toString();
                                  });

                                  fncTotalHandling();
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          barangHandling(context));
                                },
                                onChanged: (value) {
                                  data['JMLH'] = value.toString();
                                },
                              )),
                              DataCell(Text(data['SUBTOTAL'] ?? '-')),
                            ]);
                          }).toList()),
                    ),
                  ),
                )),
                SizedBox(
                  height: 40,
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
  // WIDGET MODAL HANDLING

  Widget inputKurs() {
    return TextFormField(
      initialValue: "15,653",
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration:
          const InputDecoration(labelText: 'Kurs Saat Ini', hintText: '15,653'),
    );
  }

  Widget inputRefrensi() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          label: "Refrensi",
          mode: Mode.BOTTOM_SHEET,
          items: const [
            "LANGSUNG",
            "MARKETING",
            "MARKETING NONSISTEM",
            "UMROH SMART",
            "TOURLEADER",
            "FREE",
          ],
          onChanged: (value) {
            refrensi = value;
            if (value == 'MARKETING') {
              setState(() {
                enableMarket = true;
              });
            } else {
              setState(() {
                enableMarket = false;
              });
            }
          },
          dropdownBuilder: (context, selectedItem) => Text(
              refrensi ?? "Pilih Refrensi",
              style: TextStyle(
                  color: refrensi == null ? Colors.red : Colors.black)),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputNamaMarketing() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
          enabled: enableMarket,
          mode: Mode.BOTTOM_SHEET,
          label: "Nama Marketing",
          items: listAgency,
          onChanged: (value) {
            if (value != null) {
              namaAgency = value["KDXX_MRKT"];
            } else {
              namaAgency = '';
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['NAMA_LGKP'].toString()),
                leading: CircleAvatar(
                  backgroundImage: item['FOTO_AGEN'] != ""
                      ? NetworkImage(
                          '$urlAddress/uploads/foto/${item['FOTO_AGEN']}')
                      : const AssetImage('assets/images/box-background.png'),
                ),
                subtitle: Text(item['KDXX_MRKT'].toString()),
                trailing: Text(
                    DateFormat("dd-MM-yyyy")
                        .format(DateTime.parse(item['TGLX_LHIR'].toString())),
                    textAlign: TextAlign.center),
              ),
          dropdownBuilder: (context, selectedItem) => Text(selectedItem != null
              ? selectedItem['NAMA_LGKP']
              : "Marketing belum Dipilih"),
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget btnUploadKK() {
    return ElevatedButton.icon(
      onPressed: () {
        getImageKK();
      },
      icon: const Icon(Icons.save),
      label: const Text(
        'Upload KK',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 10,
      ),
    );
  }

  Widget btnUploadDokumen() {
    return ElevatedButton.icon(
      onPressed: () {
        getImageDok();
      },
      icon: const Icon(Icons.save),
      label: const Text(
        'Upload Dokumen',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 10,
      ),
    );
  }

  Widget btnUploadKTP() {
    return ElevatedButton.icon(
      onPressed: () {
        getImageKTP();
      },
      icon: const Icon(Icons.save),
      label: const Text(
        'Upload KTP',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 10,
      ),
    );
  }

  Widget resultFotoKTP() {
    if (ktpPelangganByte != null) {
      return Image.memory(
        ktpPelangganByte,
        height: 100,
      );
    } else {
      if (ktpPelanggan != null) {
        return Image(
          image: NetworkImage('$urlAddress/uploads/ktp/$ktpPelanggan'),
          height: 100,
        );
      } else {
        return const Image(
          image: AssetImage('assets/images/ktp_pict.jpg'),
          height: 100,
        );
      }
    }
  }

  Widget resultFotoKK() {
    if (fotoKkPelangganByte != null) {
      return Image.memory(
        fotoKkPelangganByte,
        height: 100,
      );
    } else {
      return const Image(
        image: AssetImage('assets/images/kartu_keluarga.png'),
        height: 100,
      );
    }
  }

  Widget resultFotoDok() {
    if (fotoDokPelangganByte != null) {
      return Image.memory(
        fotoDokPelangganByte,
        height: 100,
      );
    } else {
      return const Image(
        image: AssetImage('assets/images/NO_IMAGE.jpg'),
        height: 100,
      );
    }
  }

  getImageKK() async {
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    Uint8List bytes = fileResult.files.first.bytes;
    String encodeFoto = base64.encode(bytes);

    if (fileResult != null) {
      setState(() {
        fotoKkPelanggan = fileResult.files.first.name;
        fotoKkPelangganByte = fileResult.files.first.bytes;
        fotoKkPelangganBase = encodeFoto;
      });
    }
  }

  getImageDok() async {
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    Uint8List bytes = fileResult.files.first.bytes;
    String encodeFoto = base64.encode(bytes);

    if (fileResult != null) {
      setState(() {
        fotoDokPelanggan = fileResult.files.first.name;
        fotoDokPelangganByte = fileResult.files.first.bytes;
        fotoDokPelangganBase = encodeFoto;
      });
    }
  }

  getImageKTP() async {
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    Uint8List bytes = fileResult.files.first.bytes;
    String encodeFoto = base64.encode(bytes);

    if (fileResult != null) {
      setState(() {
        ktpPelanggan = fileResult.files.first.name;
        ktpPelangganByte = fileResult.files.first.bytes;
        ktpPelangganBase = encodeFoto;
      });
    }
  }

  fncTotalHandling() {
    int ttl = 0;
    for (var i = 0; i < listBarangHandling.length; i++) {
      if (listBarangHandling[i]['JMLH'] != 0) {
        ttl += int.parse(
            listBarangHandling[i]['SUBTOTAL'].toString().replaceAll(',', ''));
      }
    }

    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    setState(() {
      biayaHandling = myFormat.format(ttl).toString();
    });
  }

  fncTotal() {
    int cek = (
        // (biaya != null ? int.parse(biaya.replaceAll(',', '')) : 0) +
        (harga != null ? int.parse(harga.replaceAll(',', '')) : 0) +
            (biayaPaspor != null
                ? int.parse(biayaPaspor.replaceAll(',', ''))
                : 0) +
            (biayaAdmin != null
                ? int.parse(biayaAdmin.replaceAll(',', ''))
                : 0) +
            (biayaVaksin != null
                ? int.parse(biayaVaksin.replaceAll(',', ''))
                : 0) +
            (biayaHandling != null
                ? int.parse(biayaHandling.replaceAll(',', ''))
                : 0) +
            (biayaKamar != null
                ? int.parse(biayaKamar.replaceAll(',', ''))
                : 0));

    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    setState(() {
      estimasi = ('${mataUang ?? 'Rp'}.${myFormat.format(cek)}').toString();
      totalEst = cek.toString();
    });
  }

  fncSaveFoto() {
    HttpPendaftaran.saveFotoPendaftaran(
      nik,
      ktpPelangganBase != '' ? ktpPelangganBase : 'TIDAK',
      fotoKkPelangganBase != '' ? fotoKkPelangganBase : 'TIDAK',
      fotoDokPelangganBase != '' ? fotoDokPelangganBase : 'TIDAK',
    ).then((value) {
      if (value.status == true) {
        fncSaveData(value.namaKk, value.namaDok);
      } else {
        print('UPLOAD FOTO GAGAL');
      }
    });
  }

  fncSaveData(namaKk, namaDok) async {
    // GET ID PELANGGAN
    var response1 = await http
        .get(Uri.parse("$urlAddress/jamaah/pendaftaran/kode"), headers: {
      'pte-token': kodeToken,
    });
    dynamic body1 = json.decode(response1.body);
    String idPelanggan = body1['idPelanggan'];

    listTagihan = [];
    listBarangPelanggan = [];

    var tagihan = {
      {
        '"nama_tagihan"': '"Biaya Paket"',
        '"total_tagihan"': '"${tarif.replaceAll(',', '')}"',
      },
      if (biayaVaksin != '0')
        {
          '"nama_tagihan"': '"Vaksin"',
          '"total_tagihan"': '"${biayaVaksin.replaceAll(',', '')}"',
        },
      if (biayaPaspor != '0')
        {
          '"nama_tagihan"': '"Paspor"',
          '"total_tagihan"': '"${biayaPaspor.replaceAll(',', '')}"',
        },
      if (biayaAdmin != '0')
        {
          '"nama_tagihan"': '"Biaya Admin"',
          '"total_tagihan"': '"${biayaAdmin.replaceAll(',', '')}"',
        },
      if (biayaHandling != '0')
        {
          '"nama_tagihan"': '"Biaya Handling"',
          '"total_tagihan"': '"${biayaHandling.replaceAll(',', '')}"',
        },
      if (biayaKamar != '0')
        {
          '"nama_tagihan"': '"Biaya Kamar"',
          '"total_tagihan"': '"${biayaKamar.replaceAll(',', '')}"',
        },
    };
    listTagihan.addAll(tagihan);

    for (var i = 0; i < listBarangHandling.length; i++) {
      if (listBarangHandling[i]['JMLH'] != '0') {
        var barang = {
          '"KDXX_BRGX"': '"${listBarangHandling[i]['KDXX_BRGX'].toString()}"',
          '"NAMA_BRGX"': '"${listBarangHandling[i]['NAMA_BRGX'].toString()}"',
          '"JENS_BRGX"': '"${listBarangHandling[i]['JENS_BRGX'].toString()}"',
          '"STOK_BRGX"': '"${listBarangHandling[i]['STOK_BRGX'].toString()}"',
          '"HRGX_BELI"': '"${listBarangHandling[i]['HRGX_BELI'].toString()}"',
          '"HRGX_JUAL"': '"${listBarangHandling[i]['HRGX_JUAL'].toString()}"',
          '"KETERANGAN"': '"${listBarangHandling[i]['KETERANGAN'].toString()}"',
          '"JMLH"': '"${listBarangHandling[i]['JMLH'].toString()}"',
          '"SUBTOTAL"': '"${listBarangHandling[i]['SUBTOTAL'].toString()}"',
        };
        listBarangPelanggan.add(barang);
      }
    }

    HttpPendaftaran.savePendaftaran(
      idPelanggan,
      idKantor,
      nik,
      idProduk,
      ktp,
      kk,
      lampiran,
      pembuatan,
      vaksin,
      handling,
      refrensi,
      namaAgency ?? '',
      totalEst,
      fncJatuhTempo(tglBerangkat).toString(),
      '$listTagihan',
      '$listBarangPelanggan',
      namaKk,
      namaDok,
    ).then((value) {
      if (value.status == true) {
        showDialog(
            context: context, builder: (context) => const ModalSaveSuccess());
        menuController.changeActiveitemTo('Pendaftaran');
        navigationController.navigateTo('/jamaah/pendaftaran');
      } else {
        showDialog(
            context: context, builder: (context) => const ModalSaveFail());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    TabController _tabController = TabController(vsync: this, length: 2);

    return Form(
      key: formKey,
      child: Column(
        children: [
          Obx(() => HeaderTitleMenu(menu: menuController.activeItem.value)),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              width: screenWidth,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Form Pendaftaran',
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: myBlue),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(child: SizedBox(width: 20)),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              authAddx == '1'
                                  ? fncSaveFoto()
                                  : showDialog(
                                      context: context,
                                      builder: (context) => const ModalInfo(
                                            deskripsi:
                                                'Anda Tidak Memiliki Akses',
                                          ));
                            },
                            icon: const Icon(Icons.save),
                            style: fncButtonAuthStyle(authAddx, context),
                            label: fncLabelButtonStyle('Simpan', context),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                              menuController.changeActiveitemTo('Pendaftaran');
                              navigationController
                                  .navigateTo('/jamaah/pendaftaran');
                            },
                            icon: const Icon(Icons.restart_alt),
                            label: fncLabelButtonStyle('Batal', context),
                            style: fncButtonRegulerStyle(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        controller: _tabController,
                        labelColor: myBlue,
                        unselectedLabelColor: Colors.grey[700],
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'Gilroy'),
                        tabs: const [
                          Tab(text: 'Form'),
                          Tab(text: 'Detail'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child:
                                              SizedBox(child: inputKantor())),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: SizedBox(
                                            child: inputNamapelanggan()),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child:
                                            SizedBox(child: inputNamaJadwal()),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                          child: SizedBox(child: inputKTP())),
                                      const SizedBox(width: 12),
                                      Expanded(
                                          child: SizedBox(child: inputKK())),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                          child:
                                              SizedBox(child: inputLampiran())),
                                      const SizedBox(width: 12),
                                      Expanded(
                                          child:
                                              SizedBox(child: inputVaksin())),
                                      const SizedBox(width: 12),
                                      Expanded(
                                          child:
                                              SizedBox(child: inputPaspor())),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: SizedBox(child: inputKamar())),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: SizedBox(
                                            child: inputStatusHandling()),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                          child:
                                              SizedBox(child: inputHandling())),
                                      const SizedBox(width: 12),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          disableHand == true
                                              ? ''
                                              : showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      barangHandling(context));
                                        },
                                        icon: const Icon(
                                            Icons.shopping_basket_outlined),
                                        label: fncLabelButtonStyle(
                                            'Handling', context),
                                        style: fncButtonAuthStyle(
                                            disableHand == true ? '0' : '1',
                                            context),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: SizedBox(child: inputKurs())),
                                      const SizedBox(width: 12),
                                      Expanded(
                                          child:
                                              SizedBox(child: inputRefrensi())),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: SizedBox(
                                            child: inputNamaMarketing()),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 680,
                                        height: 260,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            resultFotoKTP(),
                                            const SizedBox(width: 10),
                                            resultFotoKK(),
                                            const SizedBox(width: 10),
                                            resultFotoDok()
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              btnUploadKK(),
                                              const SizedBox(width: 10),
                                              btnUploadDokumen(),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          isKtp != true
                                              ? btnUploadKTP()
                                              : const SizedBox(),
                                          const SizedBox(height: 180),
                                          const SizedBox(
                                            width: 300,
                                            child: Text(
                                                '*Pembayaran lunas dilakukan paling lambat 30 hari sebelum keberangkatan'),
                                          )
                                        ],
                                      ),
                                      const SizedBox(width: 60),
                                    ],
                                  ),
                                  const SizedBox(width: 60),
                                ],
                              )),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: TableSidePendaftaran(
                                tarif: tarif,
                                biayaVaksin: biayaVaksin,
                                biayaPaspor: biayaPaspor,
                                biayaAdmin: biayaAdmin,
                                biayaHandling: biayaHandling,
                                biayaKamar: biayaKamar,
                                estimasi: estimasi,
                                paket: paket,
                                berangkat: berangkat,
                                pulang: pulang,
                                namaPelanggan: namaPelanggan,
                                umur: umur,
                                harga: harga,
                                alamat: alamat,
                                paspor: paspor,
                                vaksin: vaksin,
                                pembuatan: pembuatan),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
