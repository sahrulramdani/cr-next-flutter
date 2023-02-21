import 'package:flutter/material.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:flutter_web_course/comp/modal_delete_fail.dart';
// import 'package:flutter_web_course/comp/modal_delete_success.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_web_course/models/http_controller.dart';

class ModalUploadJamaah extends StatefulWidget {
  final String idJamaah;

  const ModalUploadJamaah({Key key, @required this.idJamaah}) : super(key: key);

  @override
  State<ModalUploadJamaah> createState() => _ModalUploadJamaahState();
}

class _ModalUploadJamaahState extends State<ModalUploadJamaah> {
  String fotoJamaah;
  String nik;
  String nama = ' ';

  void getDetail() async {
    String id = widget.idJamaah;
    var response = await http
        .get(Uri.parse("$urlAddress/jamaah/jamaah/detail/$id"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    setState(() {
      fotoJamaah = dataStatus[0]['FOTO_JMAH'];
      nik = widget.idJamaah;
      nama = dataStatus[0]['NAMA_LGKP'];
    });
  }

  @override
  void initState() {
    super.initState();
    getDetail();
  }

  fncSaveData() {
    showDialog(
        context: context, builder: (context) => const ModalSaveSuccess());

    menuController.changeActiveitemTo('Data Jamaah');
    navigationController.navigateTo('/jamaah/master');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: 500,
          height: 500,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: 340,
                  height: 350,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: myBlue,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Divider(thickness: 3, color: Colors.white),
                      const SizedBox(height: 15),
                      fotoJamaah == ''
                          ? Container(
                              width: 220,
                              height: 220,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/NO_IMAGE.jpg'),
                                    fit: BoxFit.fill),
                              ),
                            )
                          : Container(
                              width: 220,
                              height: 220,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          '$urlAddress/uploads/foto/$fotoJamaah'),
                                      fit: BoxFit.cover)),
                            ),
                      const SizedBox(height: 15),
                      const Divider(
                        thickness: 3,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 15),
                      Text(nik ?? '',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white)),
                      const SizedBox(height: 5),
                      Text(nama,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          )),
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
                    // ElevatedButton.icon(
                    //   onPressed: () {
                    //     fncSaveData();
                    //   },
                    //   icon: const Icon(Icons.save),
                    //   label: const Text(
                    //     'Simpan Data',
                    //     style: TextStyle(fontFamily: 'Gilroy'),
                    //   ),
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: myBlue,
                    //     shadowColor: Colors.grey,
                    //     elevation: 5,
                    //   ),
                    // ),
                    // const SizedBox(width: 10),
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
