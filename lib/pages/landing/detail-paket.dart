import 'package:flutter/material.dart';
import 'package:flutter_web_course/pages/landing/paket/content/product_detail_content.dart';
import 'package:flutter_web_course/pages/landing/paket/navigation/nav_bar_paket.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPaketPage extends StatefulWidget {
  const DetailPaketPage({Key key}) : super(key: key);

  @override
  State<DetailPaketPage> createState() => _DetailPaketPageState();
}

class _DetailPaketPageState extends State<DetailPaketPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    const whatsapp =
        'https://api.whatsapp.com/send/?phone=6281294142056&text=+Assalamualaikum%2C+saya+tertarik+untuk+mendaftar+paket+umroh+dari+Cahaya+Raudhah&type=phone_number&app_absent=0';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SizedBox(
        width: width,
        child: Column(
          children: [
            const NavbarPaket(),
            Expanded(
              child: Stack(
                children: [
                  const Image(
                    fit: BoxFit.cover,
                    image: AssetImage('images/background-landing-page.png'),
                    opacity: AlwaysStoppedAnimation(0.7),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductDetailContent(
                          idPaket: Get.parameters['id'],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: width,
                    height: height,
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () => launch(whatsapp),
                          child: Image.asset(
                            'assets/icons/whatsapp-icon.png',
                            width: 70,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
