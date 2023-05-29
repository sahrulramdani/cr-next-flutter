// ignore_for_file: deprecated_member_use, missing_return, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_web_course/models/http_maskapai.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/constants/controllers.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';

class ModalCdMaskapai extends StatefulWidget {
  final String idMaskapai;
  final bool tambah;

  const ModalCdMaskapai(
      {Key key, @required this.idMaskapai, @required this.tambah})
      : super(key: key);

  @override
  State<ModalCdMaskapai> createState() => _ModalCdMaskapaiState();
}

class _ModalCdMaskapaiState extends State<ModalCdMaskapai> {
  String idMaskapai;
  String kodeMaskapai;
  String namaMaskapai;
  String fotoMaskapai = "";
  String fotoMaskapaiBase = "";
  Uint8List fotoMaskapaiByte;
  String fotoLamaMaskapai = "";

  void getDetailSatuan() async {
    var id = widget.idMaskapai;
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/maskapai/getDetailMaskapai/$id"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      idMaskapai = data[0]['IDXX_PSWT'];
      kodeMaskapai = data[0]['KODE_PSWT'];
      namaMaskapai = data[0]['NAMA_PSWT'];
      fotoMaskapai = data[0]['FOTO_PSWT'];
      fotoLamaMaskapai = data[0]['FOTO_PSWT'];
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.tambah != true) {
      getDetailSatuan();
    }
  }

  Widget inputKodeMaskapai() {
    return TextFormField(
      initialValue: kodeMaskapai ?? "",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      onChanged: ((value) {
        kodeMaskapai = value;
      }),
      decoration: const InputDecoration(
        label: Text('Kode Maskapai', style: TextStyle(color: Colors.red)),
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Kode masih kosong !";
        }
      },
    );
  }

  Widget inputNamaMaskapai() {
    return TextFormField(
      initialValue: namaMaskapai ?? "",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      onChanged: ((value) {
        namaMaskapai = value;
      }),
      decoration: const InputDecoration(
        label: Text('Nama Maskapai', style: TextStyle(color: Colors.red)),
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Nama masih kosong !";
        }
      },
    );
  }

  Widget inputUploadFoto() {
    return TextFormField(
      initialValue: fotoMaskapai != "" ? fotoMaskapai : "Pilih",
      readOnly: true,
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
        labelText: 'Upload Foto',
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
    );
  }

  Widget resultFotoMaskapai() {
    if (fotoMaskapaiByte != null) {
      return Image.memory(
        fotoMaskapaiByte,
        width: 150,
      );
    } else {
      if (fotoMaskapai != "") {
        if (fotoMaskapai != null) {
          return Image(
            image: NetworkImage('$urlAddress/uploads/maskapai/$fotoMaskapai'),
            width: 150,
          );
        } else {
          return const Image(
            image: AssetImage('assets/images/pesawat-none.png'),
            width: 150,
          );
        }
      } else {
        return const Image(
          image: AssetImage('assets/images/pesawat-none.png'),
          width: 150,
        );
      }
    }
  }

  getImageMaskapai() async {
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    Uint8List bytes = fileResult.files.first.bytes;
    String encodeFoto = base64.encode(bytes);

    if (fileResult != null) {
      setState(() {
        fotoMaskapai = fileResult.files.first.name;
        fotoMaskapaiByte = fileResult.files.first.bytes;
        fotoMaskapaiBase = encodeFoto;
      });
    }
  }

  fncSaveFoto(context) {
    if (widget.tambah == true) {
      HttpMaskapai.saveFotoMaskapai(
        fotoMaskapaiBase != '' ? fotoMaskapaiBase : 'TIDAK',
      ).then((value) {
        if (value.status == true) {
          fncSaveData(value.foto, context);
        } else {
          print('GAGAL UPLOAD FOTO');
        }
      });
    } else {
      HttpMaskapai.updateFotoMaskapai(
        idMaskapai,
        fotoMaskapaiBase != '' ? fotoMaskapaiBase : 'TIDAK',
        fotoLamaMaskapai,
      ).then((value) {
        if (value.status == true) {
          fncSaveData(value.foto, context);
        } else {
          print('GAGAL UPLOAD FOTO');
        }
      });
    }
  }

  fncSaveData(foto, context) {
    if (widget.tambah == true) {
      HttpMaskapai.saveMaskapai(
        kodeMaskapai,
        namaMaskapai,
        foto,
      ).then((value) {
        if (value.status == true) {
          Navigator.pop(context);

          showDialog(
              context: context, builder: (context) => const ModalSaveSuccess());

          menuController.changeActiveitemTo('Master Maskapai');
          navigationController.navigateTo('/mrkt/maskapai');
        } else {
          showDialog(
              context: context, builder: (context) => const ModalSaveFail());
        }
      });
    } else {
      HttpMaskapai.updateMaskapai(
        idMaskapai,
        kodeMaskapai,
        namaMaskapai,
        foto,
      ).then((value) {
        if (value.status == true) {
          showDialog(
              context: context, builder: (context) => const ModalSaveSuccess());

          menuController.changeActiveitemTo('Master Maskapai');
          navigationController.navigateTo('/mrkt/maskapai');
        } else {
          showDialog(
              context: context, builder: (context) => const ModalSaveFail());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.5,
            height: 500,
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
                      Text(
                          widget.tambah == true
                              ? "Tambah Data Maskapai"
                              : "Ubah Data Maskapai",
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    children: [
                      inputKodeMaskapai(),
                      const SizedBox(height: 8),
                      inputNamaMaskapai(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [resultFotoMaskapai()],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: SizedBox(child: inputUploadFoto())),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                getImageMaskapai();
                              },
                              icon: const Icon(Icons.image_outlined),
                              label:
                                  fncLabelButtonStyle('Upload Foto', context),
                              style: fncButtonRegulerStyle(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            fncSaveFoto(context);
                          } else {
                            return null;
                          }
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
