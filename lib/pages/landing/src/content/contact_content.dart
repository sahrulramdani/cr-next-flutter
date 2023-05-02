// ignore: undefined_prefixed_name
// ignore_for_file: unused_import

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/responsive_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

const address =
    'https://www.google.com/maps/place/PT.+Cahaya+Raudhah+Tours+%26+Travel/@-6.5620616,107.7216619,12478m/data=!3m1!1e3!4m10!1m2!2m1!1scahaya+raudhah+di+dekat+Subang,+Kabupaten+Subang,+Jawa+Barat!3m6!1s0x2e693c82c81e499d:0xed4994a98c819f67!8m2!3d-6.5620626!4d107.7623609!15sCjxjYWhheWEgcmF1ZGhhaCBkaSBkZWthdCBTdWJhbmcsIEthYnVwYXRlbiBTdWJhbmcsIEphd2EgQmFyYXSSARBjb3Jwb3JhdGVfb2ZmaWNl4AEA!16s%2Fg%2F11dxdkp57x';

class ContactContent extends ResponsiveWidget {
  ContactContent({Key key}) : super(key: key) {
    // ui.platformViewRegistry.registerViewFactory(
    //     'google-maps',
    //     (int viewId) => IFrameElement()
    //       ..src = address
    //       ..style.border = 'none');
  }

  @override
  Widget buildDesktop(BuildContext context) => const DesktopContactContent();

  @override
  Widget buildMobile(BuildContext context) => const DesktopContactContent();
}

class DesktopContactContent extends StatefulWidget {
  const DesktopContactContent({Key key}) : super(key: key);

  @override
  State<DesktopContactContent> createState() => _DesktopContactContentState();
}

class _DesktopContactContentState extends State<DesktopContactContent> {
  final youtubeVideo = 'https://www.youtube.com/watch?v=OBqxFMtiJ8I';

  YoutubePlayerController ytController;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(youtubeVideo);
    ytController = YoutubePlayerController(
        initialVideoId: videoID,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ));
    // MAPS
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Cahaya Raudhah",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth < 500 ? 17 : 30),
                ),
                Text(
                  " Tour And Travel",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth < 500 ? 17 : 30,
                      color: Colors.red),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    "Yang Jujur Dan ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth < 500 ? 17 : 30),
                  ),
                ),
                FittedBox(
                  child: Text(
                    "Amanah",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth < 500 ? 17 : 30,
                        color: myBlue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            screenWidth < 500
                ? Container(
                    width: screenWidth * 0.7,
                    color: Colors.green,
                    child: Column(children: [
                      YoutubePlayer(
                        controller: ytController,
                        showVideoProgressIndicator: true,
                      )
                    ]),
                  )
                : const SizedBox(height: 0),
            const SizedBox(),
            const SizedBox(height: 24),
            screenWidth < 500
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Legalitas",
                          style: TextStyle(
                              color: myGrey,
                              fontSize: 20,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.bold)),
                      Text("PT. Cahaya Raudhah",
                          style: TextStyle(
                              color: myBlue,
                              fontSize: 25,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 30),
                      const Text(
                          "PT. Cahaya Raudhah merupakan perusahaan travel umroh dan haji resmi yang memiliki perizinan legalitas oleh Kementrian Agama RI No 817 tahun 2019. Kami juga memiliki kantor sendiri dan puluhan cabang di Jawa Barat dan luar Jawa Barat yang bisa dikunjungi untuk konsultasi dan pendaftaran umroh & haji. Bergabung dalam ASITA (Association of The Indonesian Tours and Travel Agencies), dan juga merupakan bagian dari KESTHURI (Kesatuan Tour Travel Haji Umroh Republik Indonesia).",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Gilroy',
                          )),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        width: screenWidth * 0.7,
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(
                              'assets/images/legalitas.png',
                            )),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Legalitas",
                                  style: TextStyle(
                                      color: myGrey,
                                      fontSize: 20,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.bold)),
                              Text("PT. Cahaya Raudhah",
                                  style: TextStyle(
                                      color: myBlue,
                                      fontSize: 25,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 30),
                              const Text(
                                  "PT. Cahaya Raudhah merupakan perusahaan travel umroh dan haji resmi yang memiliki perizinan legalitas oleh Kementrian Agama RI No 817 tahun 2019. Kami juga memiliki kantor sendiri dan puluhan cabang di Jawa Barat dan luar Jawa Barat yang bisa dikunjungi untuk konsultasi dan pendaftaran umroh & haji. Bergabung dalam ASITA (Association of The Indonesian Tours and Travel Agencies), dan juga merupakan bagian dari KESTHURI (Kesatuan Tour Travel Haji Umroh Republik Indonesia).",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'Gilroy',
                                  )),
                            ]),
                      )),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        width: screenWidth * 0.5,
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(
                              'assets/images/legalitas.png',
                            )),
                      ),
                    ],
                  ),
            const SizedBox(height: 30),
            SizedBox(
              width: screenWidth * .7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "PT. Cahaya Raudhah",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Jangan ragu untuk menghubungi kami dan dapatkan paket terbaik untuk ibadah umrah atau haji Anda. Jangan ragu untuk mengkonsultasikan paket perjalanan anda bersama kami secara online ataupun datang ke kantor pusat atau cabang terdekat!',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => launch(address),
              child: Container(
                width:
                    screenWidth < 500 ? screenWidth * 0.8 : screenWidth * 0.6,
                height: screenWidth < 500 ? 200 : 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/maps-location.png')),
                ),
                child: const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class MobileContactContent extends StatelessWidget {
//   const MobileContactContent({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.blue,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               "Contact Information Section",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
//             ),
//             const SizedBox(height: 25),
//             const Text(
//               'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
//             ),
//             const SizedBox(height: 24),
//             SizedBox(
//               height: 400,
//               width: 400,
//               child: HtmlElementView(viewType: 'google-maps', key: UniqueKey()),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
