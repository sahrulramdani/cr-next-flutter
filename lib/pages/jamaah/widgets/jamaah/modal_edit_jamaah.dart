// ignore_for_file: deprecated_member_use, missing_return

import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class ModalEditJamaah extends StatefulWidget {
  const ModalEditJamaah({
    Key key,
  }) : super(key: key);

  @override
  State<ModalEditJamaah> createState() => _ModalEditJamaahState();
}

class _ModalEditJamaahState extends State<ModalEditJamaah> {
  String tglEstimasi;
  String idProvinsi;
  String namaProvinsi;
  String idKota;
  String namaKota;
  String idKec;
  String namaKec;
  String idKel;
  String namaKel;
  String tglKeluar;
  String tglExpire;

  List<Map<String, dynamic>> listProvinsi = [];
  List<Map<String, dynamic>> listKota = [];
  List<Map<String, dynamic>> listKec = [];
  List<Map<String, dynamic>> listKel = [];

  TextEditingController dateTgl = TextEditingController();
  TextEditingController dateKeluar = TextEditingController();
  TextEditingController dateExp = TextEditingController();

  void getProvinsi() async {
    var response = await http.get(Uri.parse(
        "https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listProvinsi = dataStatus;
    });
  }

  getKota(id) async {
    var response = await http.get(Uri.parse(
        "https://www.emsifa.com/api-wilayah-indonesia/api/regencies/$id.json"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listKota = dataStatus;
    });
  }

  getKec(id) async {
    var response = await http.get(Uri.parse(
        "https://www.emsifa.com/api-wilayah-indonesia/api/districts/$id.json"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listKec = dataStatus;
    });
  }

  getKel(id) async {
    var response = await http.get(Uri.parse(
        "https://www.emsifa.com/api-wilayah-indonesia/api/villages/$id.json"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      listKel = dataStatus;
    });
  }

  @override
  void initState() {
    getProvinsi();
    super.initState();
  }

  Widget inputNIK() {
    return TextFormField(
      initialValue: '32750119288821',
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'NIK',
          hintText: '32xxxxxxxxxxx'),
    );
  }

  Widget inputNama() {
    return TextFormField(
      initialValue: 'Alfi Gunawan S.pd Lc,MA',
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Nama Lengkap'),
    );
  }

  Widget inputJenisKelamin() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "Jenis Kelamin",
        mode: Mode.MENU,
        items: const ["Pria", "Wanita"],
        onChanged: print,
        selectedItem: "Pria",
      ),
    );
  }

  Widget inputTempatLahir() {
    return TextFormField(
      initialValue: 'SUBANG',
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Tempat Lahir'),
    );
  }

  Widget inputTglLahir() {
    return TextField(
      controller: dateTgl,
      decoration: const InputDecoration(
          labelText: 'Tanggal Lahir', border: OutlineInputBorder()),
      onChanged: (String value) {
        tglEstimasi = value;
      },
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          setState(() {
            dateTgl.text = formattedDate;
          });
        }
      },
    );
  }

  Widget inputAlamat() {
    return TextFormField(
      initialValue: 'Jl Rawa Aren, Kp.Baru, Bandung Barat',
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Alamat'),
    );
  }

  Widget inputProvinsi() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Provinsi",
          items: listProvinsi,
          onChanged: (value) {
            if (value != null) {
              namaProvinsi = value["name"];
              idProvinsi = value["id"];
              getKota(value['id']);
            } else {
              namaProvinsi = null;
              idProvinsi = null;
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['name'].toString()),
              ),
          dropdownBuilder: (context, selectedItem) =>
              Text(namaProvinsi ?? "JAWA BARAT"),
          validator: (value) {
            if (value == null) {
              return "Provinsi masih kosong !";
            }
          }),
    );
  }

  Widget inputKota() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Kab / Kota",
          items: listKota,
          onChanged: (value) {
            if (value != null) {
              namaKota = value["name"];
              idKota = value["id"];
              getKec(value['id']);
            } else {
              namaKota = null;
              idKota = null;
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['name'].toString()),
              ),
          dropdownBuilder: (context, selectedItem) =>
              Text(namaKota ?? "KOTA SUBANG"),
          validator: (value) {
            if (value == null) {
              return "Kota masih kosong !";
            }
          }),
    );
  }

  Widget inputKec() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Kecamatan",
          items: listKec,
          onChanged: (value) {
            if (value != null) {
              namaKec = value["name"];
              idKec = value["id"];
              getKel(value["id"]);
            } else {
              namaKec = null;
              idKec = null;
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['name'].toString()),
              ),
          dropdownBuilder: (context, selectedItem) =>
              Text(namaKec ?? "SUBANG BARAT"),
          validator: (value) {
            if (value == null) {
              return "Kecamatan masih kosong !";
            }
          }),
    );
  }

  Widget inputKel() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
          mode: Mode.BOTTOM_SHEET,
          label: "Kelurahan",
          items: listKel,
          onChanged: (value) {
            if (value != null) {
              namaKel = value["name"];
              idKel = value["id"];
            } else {
              namaKel = null;
              idKel = null;
            }
          },
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item['name'].toString()),
              ),
          dropdownBuilder: (context, selectedItem) =>
              Text(namaKel ?? "SEJAHTERA"),
          validator: (value) {
            if (value == null) {
              return "Kelurahan masih kosong !";
            }
          }),
    );
  }

  Widget inputKodePos() {
    return TextFormField(
      initialValue: '17139',
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Kode Pos'),
    );
  }

  Widget inputNamaAyah() {
    return TextFormField(
      initialValue: 'Kohar',
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Nama Ayah'),
    );
  }

  Widget inputTelp() {
    return TextFormField(
      initialValue: '08828817388127',
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Telepon',
          hintText: "08xxxxxxxxxxx"),
    );
  }

  Widget inputMenikah() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "Status Menikah",
        mode: Mode.MENU,
        items: const ["Single", "Menikah", "Duda / Janda"],
        onChanged: print,
        selectedItem: "Menikah",
      ),
    );
  }

  Widget inputPendidikan() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "Pendidikan Terakhir",
        mode: Mode.MENU,
        items: const [
          "TK / PAUD",
          "SD/MI Sederajat",
          "SMP/Mts Sederajat",
          "SMA/MA Sederajat",
          "D1 / Sederajat",
          "D2 / Sederajat",
          "D3 / Sederajat",
          "D4/S1 Sederajat",
          "S2 / Sederajat",
          "S3 / Sederajat"
        ],
        onChanged: print,
        selectedItem: "SMA/MA Sederajat",
      ),
    );
  }

  Widget inputPekerjaan() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "Pekerjaan",
        mode: Mode.MENU,
        items: const [
          "PNS",
          "Pegawai Swasta",
          "TNI/POLRI",
          "Petani",
          "Nelayan",
          "Wirausaha",
          "Ibu Rumah Tangga",
          "Tidak Bekerja",
          "Lainnya",
        ],
        onChanged: print,
        selectedItem: "Wirausaha",
      ),
    );
  }

  Widget inputPaspor() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "Paspor",
        mode: Mode.MENU,
        items: const ["Ada", "Belum Ada"],
        onChanged: print,
        selectedItem: "Ada",
      ),
    );
  }

  Widget inputNoPaspor() {
    return TextFormField(
      initialValue: '3777400000131',
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Nomor Paspor'),
    );
  }

  Widget inputPasporKeluar() {
    return TextFormField(
      initialValue: 'BANDUNG',
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Dikeluarkan di'),
    );
  }

  Widget inputTglKeluar() {
    return TextField(
      controller: dateKeluar,
      decoration: const InputDecoration(
          labelText: 'Tanggal Dikeluarkan', border: OutlineInputBorder()),
      onChanged: (String value) {
        tglKeluar = value;
      },
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          setState(() {
            dateKeluar.text = formattedDate;
          });
        }
      },
    );
  }

  Widget inputTglExp() {
    return TextField(
      controller: dateExp,
      decoration: const InputDecoration(
          labelText: 'Berlaku Hingga', border: OutlineInputBorder()),
      onChanged: (String value) {
        tglExpire = value;
      },
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          setState(() {
            dateExp.text = formattedDate;
          });
        }
      },
    );
  }

  fncSaveData() {
    showDialog(
        context: context, builder: (context) => const ModalSaveSuccess());

    menuController.changeActiveitemTo('Data Jamaah');
    navigationController.navigateTo('/jamaah/master');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.81,
            height: 700,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      Text('Ubah Data Identitas',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 530,
                            child: Column(
                              children: [
                                inputNIK(),
                                const SizedBox(height: 8),
                                inputNama(),
                                const SizedBox(height: 8),
                                inputJenisKelamin(),
                                const SizedBox(height: 8),
                                inputTempatLahir(),
                                const SizedBox(height: 8),
                                inputTglLahir(),
                                const SizedBox(height: 8),
                                inputAlamat(),
                                const SizedBox(height: 8),
                                inputProvinsi(),
                                const SizedBox(height: 8),
                                inputKota(),
                                const SizedBox(height: 8),
                                inputKec(),
                                const SizedBox(height: 8),
                                inputKel(),
                                const SizedBox(height: 65),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          SizedBox(
                            width: 530,
                            child: Column(
                              children: [
                                inputKodePos(),
                                const SizedBox(height: 8),
                                inputNamaAyah(),
                                const SizedBox(height: 8),
                                inputTelp(),
                                const SizedBox(height: 8),
                                inputMenikah(),
                                const SizedBox(height: 8),
                                inputPendidikan(),
                                const SizedBox(height: 8),
                                inputPekerjaan(),
                                const SizedBox(height: 8),
                                inputPaspor(),
                                const SizedBox(height: 8),
                                inputNoPaspor(),
                                const SizedBox(height: 8),
                                inputPasporKeluar(),
                                const SizedBox(height: 8),
                                inputTglKeluar(),
                                const SizedBox(height: 8),
                                inputTglExp(),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          fncSaveData();
                        },
                        icon: const Icon(Icons.save),
                        label: const Text(
                          'Simpan Data',
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
