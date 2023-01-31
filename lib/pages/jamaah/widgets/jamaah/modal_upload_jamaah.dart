import 'package:flutter/material.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_delete_fail.dart';
// import 'package:flutter_web_course/comp/modal_delete_success.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_web_course/models/http_controller.dart';

class ModalUploadJamaah extends StatefulWidget {
  // final String idAgency;

  const ModalUploadJamaah({Key key}) : super(key: key);

  @override
  State<ModalUploadJamaah> createState() => _ModalUploadJamaahState();
}

class _ModalUploadJamaahState extends State<ModalUploadJamaah> {
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
          width: 400,
          height: 400,
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 220,
                        height: 220,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/images/profile.jpg'),
                              fit: BoxFit.fill),
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
