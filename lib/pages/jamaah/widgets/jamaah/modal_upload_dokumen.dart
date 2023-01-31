import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:file_picker/src/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker_web/image_picker_web.dart';
// import 'package:flutter_web_course/comp/modal_delete_fail.dart';
// import 'package:flutter_web_course/comp/modal_delete_success.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_web_course/models/http_controller.dart';

class ModalUploadDokumen extends StatefulWidget {
  // final String idAgency;

  const ModalUploadDokumen({Key key}) : super(key: key);

  @override
  State<ModalUploadDokumen> createState() => _ModalUploadDokumenState();
}

class _ModalUploadDokumenState extends State<ModalUploadDokumen> {
  // int groupValue = 1;
  String selectFile = '';
  XFile file;
  Uint8List selectedImageInBytes;
  // File image;

  getImage() async {
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    if (fileResult != null) {
      setState(() {
        selectFile = fileResult.files.first.name;
        selectedImageInBytes = fileResult.files.first.bytes;
      });
      print(selectFile);
    }
    // return await ImagePicker.pickImage(source: ImageSource.gallery);
    // final ImagePicker picker = ImagePicker();
    // final XFile imagePicked =
    //     await picker.pickImage(source: ImageSource.gallery);
    // image = File(imagePicked.path);
    // final Future<File> imagePicked =
    //     ImagePicker.pickImage(source: ImageSource.gallery);
    // image = File(imagePicked.toString());
    // print(image);

    // if (!kIsWeb) {
    // File xfile  FilePickerResult result = await FilePicker.platform.pickFiles();
    // final file = result.files.first;
    // image = File(file.path);
    // print(image);
    // final ImagePicker picker = ImagePicker();
    // final imagePicked =
    //     await ImagePicker.pickImage(source: ImageSource.gallery);
    // image = File(result.path);
    // setState(() {});
    // }
  }

  fncSaveData() {
    Navigator.pop(context);
  }

  // Future<void> openFile() async {
  //   FilePickerResult result = await FilePicker.platform.pickFiles();
  //   if (result == null) return;

  //   final file = result.files.first;

  //   OpenFile.open(file.path);

  //   print(file.name);
  //   print(file.extension);
  //   print(file.path);

  //   // setState(() {
  //   //   _openResult = "type=${_result.type}  message=${_result.message}";
  //   // });
  // }

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
                      selectFile.isEmpty
                          ? Container(
                              height: 220,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/NO_IMAGE.jpg'),
                                    fit: BoxFit.fill),
                              ),
                            )
                          : Container(
                              height: 220,
                              child: Image.memory(
                                selectedImageInBytes,
                                fit: BoxFit.cover,
                              ),
                            ),
                      // file != null
                      //     ? Container(
                      //         height: 220,
                      //         child: Image.file(
                      //           file,
                      //           fit: BoxFit.cover,
                      //         ),
                      //       )
                      //     : Container(
                      //         height: 220,
                      //         decoration: const BoxDecoration(
                      //           image: DecorationImage(
                      //               image: AssetImage(
                      //                   'assets/images/NO_IMAGE.jpg'),
                      //               fit: BoxFit.fill),
                      //         ),
                      //       ),
                      const SizedBox(height: 15),
                      ElevatedButton.icon(
                        onPressed: () async {
                          // File file = await getImage();
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
        )
      ]),
    );
  }
}
