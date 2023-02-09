// ignore_for_file: must_be_immutable
import 'package:http/http.dart' as http;
import 'package:flutter_web_course/constants/style.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class DetailKTPAgency extends StatefulWidget {
  String idAgency;
  DetailKTPAgency({Key key, @required this.idAgency}) : super(key: key);

  @override
  State<DetailKTPAgency> createState() => _DetailKTPAgencyState();
}

class _DetailKTPAgencyState extends State<DetailKTPAgency> {
  String fotoKtp;

  void getDetail() async {
    String id = widget.idAgency;
    var response = await http
        .get(Uri.parse("$urlAddress/marketing/agency/detail/$id"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataAgen =
        List.from(json.decode(response.body) as List);

    setState(() {
      fotoKtp =
          dataAgen[0]['FOTO_KTPX'] == '' ? null : dataAgen[0]['FOTO_KTPX'];
    });

    print(fotoKtp);
  }

  @override
  void initState() {
    getDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            fotoKtp != null
                ? Image(
                    image: NetworkImage('$urlAddress/uploads/$fotoKtp'),
                    width: 450,
                  )
                : const Image(
                    image: AssetImage('assets/images/NO_IMAGE.jpg'),
                    width: 450,
                  )
          ],
        ));
  }
}
