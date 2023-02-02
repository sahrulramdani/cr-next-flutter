import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/public_variable.dart';
import 'dart:convert';

class ModalUploadFotoJamaah extends StatefulWidget {
  const ModalUploadFotoJamaah({Key key}) : super(key: key);

  @override
  State<ModalUploadFotoJamaah> createState() => _ModalUploadFotoJamaahState();
}

class _ModalUploadFotoJamaahState extends State<ModalUploadFotoJamaah> {
  getImage() async {
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    Uint8List bytes = fileResult.files.first.bytes;
    String encodeFoto = base64.encode(bytes);

    if (fileResult != null) {
      setState(() {
        fotoJamaah = fileResult.files.first.name;
        fotoJamaahByte = fileResult.files.first.bytes;
        fotoJamaahBase = encodeFoto;
      });
    }

    print(fotoJamaah);
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
                      fotoJamaah.isEmpty
                          ? Container(
                              height: 220,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/NO_IMAGE.jpg'),
                                    fit: BoxFit.fill),
                              ),
                            )
                          : SizedBox(
                              height: 220,
                              child: Image.memory(
                                fotoJamaahByte,
                                fit: BoxFit.cover,
                              ),
                            ),
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
