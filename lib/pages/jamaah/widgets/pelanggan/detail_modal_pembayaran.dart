// ignore_for_file: deprecated_member_use, missing_return

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:intl/intl.dart';

class DetailModalPembayaran extends StatefulWidget {
  const DetailModalPembayaran({
    Key key,
  }) : super(key: key);

  @override
  State<DetailModalPembayaran> createState() => _DetailModalPembayaranState();
}

class _DetailModalPembayaranState extends State<DetailModalPembayaran> {
  String dibayarkan;

  TextEditingController nominal = TextEditingController();
  TextEditingController kembali = TextEditingController();

  Widget inputFaktur() {
    return TextFormField(
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Nomor Faktur'),
      initialValue: 'SP0000000001',
    );
  }

  Widget inputAkun() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Akun",
          items: listDataAkun,
          onChanged: (value) {
            setState(() {
              nominal.text = value['nominal'];
            });
            fncKembali();
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['akun'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                leading: const CircleAvatar(),
                subtitle: Text(item['id'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(item['kantor'] + ' - KAS : ' + item['kas']),
              ),
          dropdownBuilder: (context, selectedItem) => Text(selectedItem != null
              ? selectedItem['akun']
              : "Akun belum Dipilih"),
          validator: (value) {
            if (value == null) {
              return "Akun masih kosong !";
            }
          }),
    );
  }

  Widget inputResi() {
    return TextFormField(
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      initialValue: 'Auto Generate',
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Resi'),
    );
  }

  Widget inputNominal() {
    return TextFormField(
      textAlign: TextAlign.right,
      readOnly: true,
      controller: nominal,
      onChanged: (value) {},
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Nominal'),
    );
  }

  Widget inputBayar() {
    return TextFormField(
      textAlign: TextAlign.right,
      onChanged: (value) {
        setState(() {
          dibayarkan = value;
        });
        fncKembali();
      },
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Dibayarkan'),
    );
  }

  Widget inputKembali() {
    return TextFormField(
      textAlign: TextAlign.right,
      readOnly: true,
      controller: kembali,
      onChanged: (value) {},
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Kembalian'),
    );
  }

  Widget inputStatusAkun() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "Status Akun",
        mode: Mode.MENU,
        items: const [
          "PEMBAYARAN",
          "PELUNASAN",
        ],
        onChanged: print,
        selectedItem: "Pilih Status Akun",
      ),
    );
  }

  Widget inputKeterangan() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Keterangan'),
      initialValue: "Pembayaran Nanim Sumartini",
    );
  }

  fncKembali() {
    int cek = ((nominal.text != ''
            ? int.parse(nominal.text.replaceAll(',', ''))
            : 0) -
        (dibayarkan != null ? int.parse(dibayarkan.replaceAll(',', '')) : 0));

    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    setState(() {
      kembali.text = (myFormat.format(cek)).toString();
    });
  }

  // fncSaveData() {
  //   showDialog(
  //       context: context, builder: (context) => const ModalSaveSuccess());

  //   menuController.changeActiveitemTo('Jadwal');
  //   navigationController.navigateTo('/jamaah/jadwal');
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: screenWidth > 600 ? 800 : 400,
            height: 700,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.wallet_outlined,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      FittedBox(
                        child: Text('Pembayaran Nanim Sumartini',
                            style: TextStyle(
                                color: myGrey, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SizedBox(
                    width: screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Sisa Bayar : IDR.29,460,000',
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 150,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: DataTable(
                                  border: TableBorder.all(color: Colors.grey),
                                  columns: const [
                                    DataColumn(label: Text('No.')),
                                    DataColumn(label: Text('Pembayaran')),
                                    DataColumn(label: Text('Nominam')),
                                    DataColumn(label: Text('Sudah Bayar')),
                                    DataColumn(label: Text('Sisa')),
                                  ],
                                  rows: const [
                                    DataRow(cells: [
                                      DataCell(Text('1.')),
                                      DataCell(Text('PAKET UMROH')),
                                      DataCell(Text('28,900,000')),
                                      DataCell(Text('0')),
                                      DataCell(Text('28,900,000')),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('2.')),
                                      DataCell(Text('VAKSIN')),
                                      DataCell(Text('180,000')),
                                      DataCell(Text('0')),
                                      DataCell(Text('180,000')),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('3.')),
                                      DataCell(Text('PASPORT')),
                                      DataCell(Text('380,000')),
                                      DataCell(Text('0')),
                                      DataCell(Text('380,000')),
                                    ]),
                                  ],
                                )),
                          ),
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          width: screenWidth,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 380, child: inputFaktur()),
                                    const SizedBox(width: 8),
                                    SizedBox(width: 380, child: inputAkun()),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    SizedBox(width: 380, child: inputResi()),
                                    const SizedBox(width: 8),
                                    SizedBox(width: 380, child: inputNominal()),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    SizedBox(width: 380, child: inputBayar()),
                                    const SizedBox(width: 8),
                                    SizedBox(width: 380, child: inputKembali()),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 380, child: inputStatusAkun()),
                                    const SizedBox(width: 8),
                                    SizedBox(
                                        width: 380, child: inputKeterangan()),
                                  ],
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
                  height: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) => const ModalSaveSuccess());
                        },
                        icon: const Icon(Icons.payments_outlined),
                        label: const Text(
                          'Bayar',
                          style: TextStyle(fontFamily: 'Gilroy'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myBlue,
                          shadowColor: Colors.grey,
                          elevation: 5,
                        ),
                      ),
                      const SizedBox(width: 10),
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
          ),
        )
      ]),
    );
  }
}
