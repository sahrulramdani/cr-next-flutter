// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/models/http_musim.dart';

class ModalUpdateMusim extends StatelessWidget {
  String idMusim;

  ModalUpdateMusim({Key key, @required this.idMusim}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: 300,
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.edit_calendar_outlined,
                color: Colors.green,
                size: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              const FittedBox(
                child: Text('Apakah Kamu Yakin Ingin Mengubah Musim Berjalan?',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        HttpMusim.updateMusim(idMusim).then((value) {
                          if (value.status == true) {
                            showDialog(
                                context: context,
                                builder: (context) => const ModalSaveSuccess());

                            menuController
                                .changeActiveitemTo('Pengaturan Musim');
                            navigationController
                                .navigateTo('/setting/pengaturan-musim');
                          }
                        });
                      },
                      child: const Text('Yakin')),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Kembali')),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
