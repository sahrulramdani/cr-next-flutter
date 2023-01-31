import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';

class DetailModalInfo extends StatelessWidget {
  final String deskripsi;

  const DetailModalInfo({Key key, @required this.deskripsi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: 300,
          height: 140,
          child: Column(
            children: [
              SizedBox(
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.amber[900],
                    ),
                    const SizedBox(width: 10),
                    Text('Info',
                        style: TextStyle(
                            color: myGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FittedBox(
                child: Text(deskripsi,
                    style: const TextStyle(fontSize: 13, color: Colors.black)),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
