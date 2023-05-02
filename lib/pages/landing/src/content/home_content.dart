// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/responsive_widget.dart';
import 'package:url_launcher/url_launcher.dart';

const facebookUrl = 'https://www.facebook.com/cahayaraudhah.id';
const youtubeUrl = 'https://www.youtube.com/@CahayaRaudhahTVofficial/featured';
const instagramUrl =
    'https://instagram.com/cahayaraudhah.id?igshid=YmMyMTA2M2Y=';

class HomeContent extends ResponsiveWidget {
  const HomeContent({Key key}) : super(key: key);

  @override
  Widget buildDesktop(BuildContext context) => const DesktopHomeContent();

  @override
  Widget buildMobile(BuildContext context) => const MobileHomeContent();
}

class DesktopHomeContent extends StatelessWidget {
  const DesktopHomeContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height * .85,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Apa Yang Kami Tawarkan ?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.red),
                  ),
                  Text(
                    "Kami Memiliki Produk Haji Dan Umroh Untuk Kamu",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: myBlue),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Nikmati kemudahan dan keamanan perjalanan dengan paket umroh dan haji terbaik yang kami tawarkan. Mari menggapai umroh dan haji yang mabrur, meraih pahala yang banyak serta ampunan Allah Subhanahu Wata’ala.',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => launch(facebookUrl),
                        child: Image.asset(
                          'assets/icons/facebook-icon.png',
                          height: 50,
                          width: 50,
                        ),
                      ),
                      const SizedBox(width: 100),
                      GestureDetector(
                        onTap: () => launch(instagramUrl),
                        child: Image.asset(
                          'assets/icons/instagram-icon.png',
                          height: 50,
                          width: 50,
                        ),
                      ),
                      const SizedBox(width: 100),
                      GestureDetector(
                        onTap: () => launch(youtubeUrl),
                        child: Image.asset(
                          'assets/icons/youtube-icon.png',
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 24),
          Container(
            padding: const EdgeInsets.only(top: 10),
            width: width * 0.5,
            child: Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'assets/images/header-content.png',
                )),
          ),
        ],
      ),
    );
  }
}

class MobileHomeContent extends StatelessWidget {
  const MobileHomeContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Apa Yang Kami Tawarkan ?",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.red),
          ),
          Text(
            "Kami Memiliki Produk Haji Dan Umroh Untuk Kamu",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 40, color: myBlue),
          ),
          const SizedBox(height: 30),
          const Text(
            'Nikmati kemudahan dan keamanan perjalanan dengan paket umroh dan haji terbaik yang kami tawarkan. Mari menggapai umroh dan haji yang mabrur, meraih pahala yang banyak serta ampunan Allah Subhanahu Wata’ala.',
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => launch(facebookUrl),
                child: Image.asset(
                  'assets/icons/facebook-icon.png',
                  height: 50,
                  width: 50,
                ),
              ),
              const SizedBox(width: 50),
              GestureDetector(
                onTap: () => launch(instagramUrl),
                child: Image.asset(
                  'assets/icons/instagram-icon.png',
                  height: 50,
                  width: 50,
                ),
              ),
              const SizedBox(width: 50),
              GestureDetector(
                onTap: () => launch(youtubeUrl),
                child: Image.asset(
                  'assets/icons/youtube-icon.png',
                  height: 50,
                  width: 50,
                ),
              ),
            ],
          ),
          const SizedBox(height: 0),
          Image.asset(
            'assets/images/header-content.png',
            height: 350,
          ),
        ],
      ),
    );
  }
}
