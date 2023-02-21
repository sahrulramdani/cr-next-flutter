import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/public_variable.dart';
import 'dart:convert';

class ModalUploadKtpAgency extends StatefulWidget {
  const ModalUploadKtpAgency({Key key}) : super(key: key);

  @override
  State<ModalUploadKtpAgency> createState() => _ModalUploadKtpAgencyState();
}

class _ModalUploadKtpAgencyState extends State<ModalUploadKtpAgency> {
  getImage() async {
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    Uint8List bytes = fileResult.files.first.bytes;
    String encodeFoto = base64.encode(bytes);

    if (fileResult != null) {
      setState(() {
        fotoKtpAgency = fileResult.files.first.name;
        fotoKtpAgencyByte = fileResult.files.first.bytes;
        fotoKtpAgencyBase = encodeFoto;
      });
    }
  }

  Widget resultKtp() {
    if (fotoKtpAgencyByte != null) {
      return Image.memory(
        fotoKtpAgencyByte,
        width: 220,
      );
    } else {
      if (ktpCalonAgen != "") {
        return Image(
          image: NetworkImage('$urlAddress/uploads/ktp/$ktpCalonAgen'),
          width: 220,
        );
      } else {
        return const Image(
          image: AssetImage('assets/images/NO_IMAGE.jpg'),
          width: 220,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: 500,
          height: 400,
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      resultKtp(),
                      const SizedBox(height: 15),
                      ElevatedButton.icon(
                        onPressed: () async {
                          getImage();
                        },
                        icon: const Icon(Icons.image),
                        label: const Text(
                          'Pilih Foto',
                          style: TextStyle(fontFamily: 'Gilroy'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myBlue,
                          shadowColor: Colors.grey,
                          elevation: 5,
                        ),
                      ),
                    ],
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
                        Navigator.pop(context);
                        setState(() {});
                      },
                      icon: const Icon(Icons.save),
                      label: const Text(
                        'Simpan Foto',
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
                          setState(() {});
                        },
                        child: const Text('Kembali'))
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
