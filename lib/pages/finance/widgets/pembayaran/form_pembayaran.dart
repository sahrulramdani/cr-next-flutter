// ignore_for_file: missing_return, deprecated_member_use, prefer_interpolation_to_compose_strings
// import 'package:http/http.dart' as http;
import 'dart:html';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/models/http_pembayaran.dart';
import 'package:flutter_web_course/pages/finance/widgets/pembayaran/modal_bayar_kurang.dart';
import 'package:flutter_web_course/pages/finance/widgets/pembayaran/save_pembayaran_success.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PembayaranForm extends StatefulWidget {
  const PembayaranForm({Key key}) : super(key: key);

  @override
  State<PembayaranForm> createState() => _PembayaranFormState();
}

class _PembayaranFormState extends State<PembayaranForm> {
  final _formKey = GlobalKey<FormState>();
  List<Map> objBarang = [];

  String namaPelanggan;
  String nik;
  String namaJadwal;
  String idPendaftaran;
  // String idBank;
  // String namaBank;
  String idCaraBayar;
  String descCaraBayar;
  String keterangan;
  String mutasi;

  String stringTotal;
  String stringTagihan;
  bool cekAll = false;
  bool disabledCekAll = true;
  bool disabledMutasi = true;
  String uangDiterima;
  String uangKembali;
  String mataUang;

  List<Map<String, dynamic>> listJamaah = [];
  List<Map<String, dynamic>> listJadwal = [];
  List<Map<String, dynamic>> listTagihan = [];
  List<Map<String, dynamic>> listCaraBayar = [];
  List<Map<String, dynamic>> listMutasiRek = [];
  List<Map<String, dynamic>> detailTagihan = [];

  void getList() async {
    loadStart();

    var response = await http
        .get(Uri.parse("$urlAddress/finance/pembayaran/get-jamaah"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listJamaah = dataStatus;
    });
  }

  getBank() async {
    var response = await http
        .get(Uri.parse("$urlAddress/finance/all-carabayar"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listCaraBayar = dataStatus;
    });
  }

  getMutasi() async {
    var response = await http.get(
        Uri.parse("$urlAddress/finance/pembayaran/mutasi-rekening"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listMutasiRek = dataStatus;
    });

    loadEnd();
  }

  getTagihan(id) async {
    var response = await http.get(
        Uri.parse("$urlAddress/finance/pembayaran/get-tagihan/$id"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listTagihan = [];
    });

    for (var i = 0; i < dataStatus.length; i++) {
      var tagihan = {
        "NOXX_TGIH": dataStatus[i]['NOXX_TGIH'].toString(),
        "KDXX_DFTR": dataStatus[i]['KDXX_DFTR'].toString(),
        "JENS_TGIH": dataStatus[i]['JENS_TGIH'].toString(),
        "TOTL_TGIH": dataStatus[i]['SISA_TGIH'].toString(),
        "JMLX_BYAR": dataStatus[i]['SISA_TGIH'].toString(),
        "SISA_TGIH": '0',
        "STS_LUNAS": dataStatus[i]['STS_LUNAS'].toString(),
        "CEK": false,
      };
      listTagihan.add(tagihan);
    }

    int ttl = 0;
    for (var i = 0; i < listTagihan.length; i++) {
      if (listTagihan[i]['STS_LUNAS'] != 'LUNAS') {
        ttl += int.parse(
            listTagihan[i]['TOTL_TGIH'].toString().replaceAll(',', ''));
      }
    }

    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    setState(() {
      stringTagihan = myFormat.format(ttl).toString();
    });
  }

  @override
  void initState() {
    getList();
    getBank();
    getMutasi();
    super.initState();
  }

  Widget inputPilihJamaah() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      height: 50,
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Pilih No Pendaftaran",
          items: listJamaah,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                namaPelanggan = value["NAMA_LGKP"];
                nik = value["NOXX_IDNT"];
                namaJadwal = value['namaPaket'] +
                    ' - ' +
                    value['jenisPaket'] +
                    ' - ' +
                    value['KETERANGAN'];
                disabledCekAll = false;
                idPendaftaran = value['KDXX_DFTR'];
                mataUang = value['MATA_UANG'];
              });
              // getJadwal(value["KDXX_DFTR"]);
              getTagihan(value['KDXX_DFTR']);
            } else {
              setState(() {
                namaPelanggan = null;
                nik = null;
                namaJadwal = null;
                disabledCekAll = true;
                idPendaftaran = null;
                mataUang = null;
              });
              // getJadwal('cek');
              getTagihan('cek');
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(
                    item['KDXX_DFTR'] +
                        ' - ' +
                        item['NAMA_LGKP'] +
                        ' - ' +
                        item['UMUR'].toString() +
                        ' Tahun, ' +
                        item['JENS_KLMN'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                leading: CircleAvatar(
                  backgroundImage: item['FOTO_JMAH'] != ''
                      ? NetworkImage('$urlAddress/uploads/${item['FOTO_JMAH']}')
                      : const AssetImage('assets/images/NO_IMAGE.jpg'),
                ),
                subtitle: Text(
                    item['NOXX_IDNT'] +
                        ' - No Telp : ' +
                        item['NOXX_TELP'].toString() +
                        ' - TTL : ' +
                        item['TMPT_LHIR'] +
                        ', ' +
                        fncGetTanggal(item['LAHIR']),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(item['ALAMAT']),
              ),
          dropdownBuilder: (context, selectedItem) => Text(
              namaPelanggan != null ? '$nik - $namaPelanggan' : "Nama Jamaah"),
          validator: (value) {
            if (value == null) {
              return "Nama Jamaah masih kosong !";
            }
          },
          dropdownSearchDecoration:
              const InputDecoration(border: InputBorder.none)),
    );
  }

  Widget inputNamaJadwal() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 14),
      decoration: const InputDecoration(labelText: 'Jadwal Jamaah'),
      // onChanged: (value) {
      //   keterangan = value;
      // },
      readOnly: true,
      initialValue: namaJadwal ?? 'Jadwal Jamaah',
    );
  }

  Widget inputJumlahTagihan() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      readOnly: true,
      textAlign: TextAlign.right,
      decoration: const InputDecoration(
        labelText: 'Jumlah Tagihan',
      ),
      initialValue: stringTagihan ?? '0',
    );
  }

  Widget inputJumlahPembayaran() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      readOnly: true,
      textAlign: TextAlign.right,
      decoration: const InputDecoration(
        labelText: 'Jumlah Pembayaran',
      ),
      initialValue: stringTotal ?? '0',
    );
  }

  Widget inputTotalBayar() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 25),
      readOnly: true,
      textAlign: TextAlign.right,
      decoration: const InputDecoration(
        labelText: 'Total Pembayaran',
        labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      initialValue: stringTotal ?? '0',
    );
  }

  Widget inputUangDiterima() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: 'Uang Yang Diterima',
        labelStyle:
            TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),
      ),
      initialValue: uangDiterima ?? '0',
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      onFieldSubmitted: (value) {
        setState(() {
          uangDiterima = value;
        });
        fncKembali();
      },
      // onChanged: (value) {
      //   setState(() {
      //     uangDiterima = value;
      //   });
      //   fncKembali();
      // },
    );
  }

  Widget inputUangKembali() {
    return TextFormField(
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: 'Uang Kembali',
        labelStyle:
            TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold),
      ),
      initialValue: uangKembali ?? '0',
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
    );
  }

  Widget inputCaraBayar() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid, color: Colors.black, width: 0.4))),
      child: DropdownSearch(
        mode: Mode.MENU,
        label: "Metode Pembayaran",
        items: listCaraBayar,
        onChanged: (value) {
          setState(() {
            idCaraBayar = value['KODE_BANK'];
            descCaraBayar = value['NAMA_BANK'] + " - " + value['ACCT_CODE'];
            disabledMutasi = value['CHKX_BANK'] == '0' ? true : false;
          });
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) => ListTile(
          title: Text(item['NAMA_BANK'] ?? '-'),
        ),
        dropdownBuilder: (context, selectedItem) => Text(
            descCaraBayar ?? "Pilih Metode Pembayaran",
            style: TextStyle(
                color: descCaraBayar == null ? Colors.red : Colors.black)),
        dropdownSearchDecoration:
            const InputDecoration(border: InputBorder.none),
        validator: (value) {
          if (value == "Pilih Metode Pembayaran") {
            return "Metode Pembayaran masih kosong !";
          }
        },
      ),
    );
  }

  Widget inputMutasiRekening() {
    return TextFormField(
      initialValue: mutasi ?? "Mutasi Rekening",
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Mutasi', hintText: ''),
    );
  }

  Widget inputKeterangan() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(labelText: 'Keterangan Pembayaran'),
      onChanged: (value) {
        keterangan = value;
      },
      initialValue: keterangan ?? '',
    );
  }

  Widget buttonCari() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.save),
      label: const Text(
        'Cari Tagihan',
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

  Widget buttonRefresh() {
    return ElevatedButton.icon(
      onPressed: () {
        menuController.changeActiveitemTo('Pembayaran');
        navigationController.navigateTo('/finance/pembayaran-jamaah');
      },
      icon: const Icon(Icons.refresh_outlined),
      label: const Text(
        'Batal',
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

  // WIDGET MODAL HANDLING
  Widget mutasiRekeningModal(context) {
    final screenWidth = MediaQuery.of(context).size.width;
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    int x = 1;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.8,
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
                      Text('Daftar Mutasi Rekening',
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
                      child: Column(
                        children: [
                          DataTable(
                              dataRowHeight: 35,
                              headingRowHeight: 40,
                              border: TableBorder.all(color: Colors.grey),
                              columns: const [
                                DataColumn(
                                    label: Text('No.', style: styleColumn)),
                                DataColumn(
                                    label: Text('Kode Transaksi',
                                        style: styleColumn)),
                                DataColumn(
                                    label:
                                        Text('Keterangan', style: styleColumn)),
                                DataColumn(
                                    label: Text('Nominal', style: styleColumn)),
                                DataColumn(
                                    label: Text('Tanggal Transaksi',
                                        style: styleColumn)),
                              ],
                              rows: listMutasiRek.map((data) {
                                return DataRow(
                                    onLongPress: () {
                                      setState(() {
                                        mutasi = data['KODE_TRNX'];
                                        uangDiterima =
                                            myFormat.format(data['Amount']);
                                        fncKembali();
                                      });
                                      Navigator.pop(context);
                                    },
                                    cells: [
                                      DataCell(Text((x++).toString())),
                                      DataCell(Text(data['KODE_TRNX'] ?? '-')),
                                      DataCell(Text(data['Keterangan'] ?? '-')),
                                      DataCell(Text(
                                          myFormat.format(data['Amount']) ??
                                              '-')),
                                      DataCell(Text(data['TransDate'] ?? '-')),
                                    ]);
                              }).toList()),
                        ],
                      ),
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

  fncCekAll() {
    for (var i = 0; i < listTagihan.length; i++) {
      if (listTagihan[i]['STS_LUNAS'] != 'LUNAS') {
        setState(() {
          listTagihan[i]['CEK'] = cekAll;
        });
      }
    }
  }

  fncTotal() {
    int ttl = 0;
    for (var i = 0; i < listTagihan.length; i++) {
      if (listTagihan[i]['STS_LUNAS'] != 'LUNAS') {
        if (listTagihan[i]['CEK'] == true) {
          ttl += int.parse(
              listTagihan[i]['JMLX_BYAR'].toString().replaceAll(',', ''));
        }
      }
    }

    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    setState(() {
      stringTotal = myFormat.format(ttl).toString();
      uangKembali = '0';
    });
  }

  fncKembali() {
    int kembali = -1 *
        ((int.parse(stringTotal.replaceAll(',', ''))) -
            (int.parse(
                uangDiterima != '' ? uangDiterima.replaceAll(',', '') : 0)));
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    setState(() {
      uangKembali = myFormat.format(kembali == -0 ? 0 : kembali).toString();
    });
  }

  fncSaveData() async {
    detailTagihan = [];

    if (uangDiterima == null) {
      return showDialog(
          context: context,
          builder: (context) => const ModalInfo(
                deskripsi: "Kamu Lupa Menekan Enter Pada Uang Diterima!",
              ));
    }

    if (int.parse(uangDiterima.replaceAll(',', '')) <
        int.parse(stringTotal.replaceAll(',', ''))) {
      return showDialog(
          context: context, builder: (context) => const ModalBayarKurang());
    }

    // GET NOMOR FAKTUR
    var response1 = await http
        .get(Uri.parse("$urlAddress/finance/pembayaran/no-faktur"), headers: {
      'pte-token': kodeToken,
    });
    dynamic body1 = json.decode(response1.body);
    String noFaktur = body1['idFaktur'];

    // GET DETAIL BARANG
    for (var i = 0; i < listTagihan.length; i++) {
      if (listTagihan[i]['STS_LUNAS'] != 'LUNAS') {
        if (listTagihan[i]['CEK'] == true) {
          if (listTagihan[i]['JMLX_BYAR'] != '0') {
            var tagihan = {
              '"NOXX_TGIH"': '"${listTagihan[i]['NOXX_TGIH']}"',
              '"KDXX_DFTR"': '"${listTagihan[i]['KDXX_DFTR']}"',
              '"JENS_TGIH"': '"${listTagihan[i]['JENS_TGIH']}"',
              '"TOTL_TGIH"': '"${listTagihan[i]['TOTL_TGIH']}"',
              '"JMLX_BYAR"': '"${listTagihan[i]['JMLX_BYAR']}"',
              '"SISA_TGIH"': '"${listTagihan[i]['SISA_TGIH']}"',
              '"STS_LUNAS"': '"${listTagihan[i]['STS_LUNAS']}"',
            };
            detailTagihan.add(tagihan);
          }
        }
      }
    }

    // print(idPendaftaran);
    // print(stringTotal.replaceAll(',', ''));
    // print(metodePembayaran);
    // print(idBank);
    // print(keterangan);
    // print(uangDiterima.replaceAll(',', ''));
    // print(detailTagihan);

    HttpPembayaran.savePembayaran(
      noFaktur,
      idPendaftaran,
      stringTotal.replaceAll(',', ''),
      idCaraBayar,
      mutasi ?? '',
      keterangan ?? '',
      uangDiterima.replaceAll(',', ''),
      '$detailTagihan',
    ).then((value) {
      if (value.status == true) {
        menuController.changeActiveitemTo('Form Bayar');
        navigationController.navigateTo('/finance/form-bayar');

        showDialog(
            context: context,
            builder: (context) => ModalSavePembayaranSuccess(
                  noKwitansi: noFaktur,
                  noPelanggan: idPendaftaran,
                  namaPelanggan: namaPelanggan,
                  jumlahBayar: stringTotal.replaceAll(",", ""),
                  mataUang: mataUang,
                  detailPembayaran: detailTagihan,
                ));
      } else {
        showDialog(
            context: context, builder: (context) => const ModalSaveFail());
      }
    });

    // showDialog(
    //     context: context, builder: (context) => const ModalSaveSuccess());

    // menuController.changeActiveitemTo('Pengeluaran');
    // navigationController.navigateTo('/inventory/pengeluaran');
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    int x = 1;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pembayaran Jamaah',
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
              ElevatedButton.icon(
                onPressed: () {
                  fncSaveData();
                },
                icon: const Icon(Icons.save),
                style: fncButtonAuthStyle(authAddx, context),
                label: fncLabelButtonStyle('Simpan', context),
              )
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: 1085,
                    height: 60,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 300,
                          child: inputPilihJamaah(),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 300,
                          child: inputNamaJadwal(),
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // buttonCari(),
                            // const SizedBox(width: 5),
                            buttonRefresh()
                          ],
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 1085,
                    child: Row(children: [
                      Container(
                        width: 543,
                        height: 400,
                        // color: Colors.amber[200],
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 1,
                                style: BorderStyle.solid)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              dataRowHeight: 35,
                              columnSpacing: 30,
                              headingTextStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              border: TableBorder.all(color: Colors.grey[200]),
                              columns: [
                                const DataColumn(label: Text('No.')),
                                DataColumn(
                                    label: Checkbox(
                                  value: cekAll,
                                  onChanged: (bool value) {
                                    if (disabledCekAll == false) {
                                      setState(() {
                                        cekAll = !cekAll;
                                      });
                                      fncCekAll();
                                      fncTotal();
                                    }
                                  },
                                )),
                                const DataColumn(label: Text('Tagihan')),
                                const DataColumn(label: Text('Nominal')),
                                const DataColumn(label: Text('Jumlah Bayar')),
                                const DataColumn(label: Text('Sisa')),
                              ],
                              rows: namaJadwal == null
                                  ? []
                                  : listTagihan.map((e) {
                                      return DataRow(cells: [
                                        DataCell(Text((x++).toString())),
                                        DataCell(Checkbox(
                                          value: e['CEK'],
                                          onChanged: (bool value) {
                                            if (e['STS_LUNAS'] == 'BELUM') {
                                              setState(() {
                                                e['CEK'] = !e['CEK'];
                                              });
                                              fncTotal();
                                            }
                                          },
                                        )),
                                        DataCell(Text(
                                          e['JENS_TGIH'],
                                        )),
                                        DataCell(Text(
                                          myFormat.format(
                                              int.parse(e['TOTL_TGIH'])),
                                        )),
                                        // DataCell(Text(
                                        //     myFormat.format(
                                        //         int.parse(e['JMLX_BYAR'])),
                                        //     style: TextStyle(
                                        //         color: e['STS_LUNAS'] == 'LUNAS'
                                        //             ? Colors.green[900]
                                        //             : Colors.black))),
                                        DataCell(TextFormField(
                                          readOnly:
                                              e['CEK'] == true ? false : true,
                                          textAlign: TextAlign.right,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            ThousandsFormatter()
                                          ],
                                          decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 19)),
                                          style: const TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontSize: 15),
                                          initialValue: e['CEK'] == true
                                              ? myFormat.format(
                                                  int.parse(e['JMLX_BYAR']))
                                              : '0',
                                          onFieldSubmitted: (value) {
                                            setState(() {
                                              e['SISA_TGIH'] =
                                                  (int.parse(e['TOTL_TGIH']) -
                                                          int.parse(
                                                              value.replaceAll(
                                                                  ',', '')))
                                                      .toString();
                                            });

                                            fncTotal();
                                          },
                                          onChanged: (value) {
                                            e['JMLX_BYAR'] =
                                                value.replaceAll(',', '');
                                          },
                                        )),
                                        // --------------------------
                                        // --------------------------
                                        // --------------------------
                                        // --------------------------
                                        DataCell(Text(
                                          e['CEK'] == true
                                              ? myFormat.format(
                                                  int.parse(e['SISA_TGIH']))
                                              : myFormat.format(
                                                  int.parse(e['TOTL_TGIH'])),
                                        )),
                                      ]);
                                    }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 542,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 230,
                                  child: inputCaraBayar(),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 280,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 130,
                                        child: inputMutasiRekening(),
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                          width: 140,
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              disabledMutasi == true
                                                  ? ''
                                                  : showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          mutasiRekeningModal(
                                                              context));
                                            },
                                            icon: const Icon(
                                                Icons.shopping_basket_outlined),
                                            label: fncLabelButtonStyle(
                                                'Cek Mutasi', context),
                                            style: fncButtonAuthStyle(
                                                disabledMutasi == true
                                                    ? '0'
                                                    : '1',
                                                context),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(
                                  width: 255,
                                  child: inputJumlahTagihan(),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 255,
                                  child: inputJumlahPembayaran(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            inputTotalBayar(),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                SizedBox(
                                  width: 255,
                                  child: inputUangDiterima(),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 255,
                                  child: inputUangKembali(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 50),
                            Divider(
                              thickness: 5,
                              color: myBlue,
                            ),
                            const SizedBox(height: 35),
                            inputKeterangan(),
                          ],
                        ),
                      )
                    ]),
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
