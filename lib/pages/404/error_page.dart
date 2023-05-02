import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:get/get.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RawMaterialButton(
                  onPressed: () {
                    if (kodeToken != "") {
                      menuController.changeActiveitemTo("Dashboard");
                      Get.offAllNamed('/overview');
                    } else {
                      menuController.changeActiveitemTo(" ");
                      Get.offAllNamed('/auth');
                    }
                  },
                  elevation: 2.0,
                  fillColor: Colors.blue[900],
                  padding: const EdgeInsets.all(15.0),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    size: 35.0,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/not-found.png", width: 350),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Halaman Tidak Tersedia",
                      size: 24,
                      weight: FontWeight.bold,
                      color: Colors.blue[900],
                    )
                  ],
                )
              ],
            ),
            const SizedBox(width: 100),
          ],
        ),
      ),
    );
  }
}
