// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/landing/src/content/contact_content.dart';
import 'package:flutter_web_course/pages/landing/src/content/feature_content.dart';
import 'package:flutter_web_course/pages/landing/src/content/home_content.dart';
import 'package:flutter_web_course/pages/landing/src/content/screenshots_content.dart';
import 'package:flutter_web_course/pages/landing/src/navigation_bar/nav_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';

final homeKey = GlobalKey();
final featureKey = GlobalKey();
final screenshotKey = GlobalKey();
final contactKey = GlobalKey();

final currentPageProvider = StateProvider<GlobalKey>((_) => homeKey);
final scrolledProvider = StateProvider<bool>((_) => false);

class LandingPage extends HookConsumerWidget {
  const LandingPage({Key key}) : super(key: key);

  void onScroll(ScrollController controller, WidgetRef ref) {
    final isScrolled = ref.read(scrolledProvider);

    if (controller.position.pixels > 5 && !isScrolled) {
      ref.read(scrolledProvider.state).state = true;
    } else if (controller.position.pixels <= 5 && isScrolled) {
      ref.read(scrolledProvider.state).state = false;
    }
  }

  void scrollTo(GlobalKey key) => Scrollable.ensureVisible(key.currentContext,
      duration: const Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollController();

    // How to set a listener: https://stackoverflow.com/a/63832263/3479489
    useEffect(() {
      controller.addListener(() => onScroll(controller, ref));
      return controller.dispose;
    }, [controller]);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double maxWith = width > 1200 ? 1200 : width;
    const whatsapp =
        'https://api.whatsapp.com/send/?phone=6281294142056&text=+Assalamualaikum%2C+saya+tertarik+untuk+mendaftar+paket+umroh+dari+Cahaya+Raudhah&type=phone_number&app_absent=0';

    ref
        .watch(currentPageProvider.state)
        .addListener(scrollTo, fireImmediately: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: width,
          child: Column(
            children: [
              const NavBar(),
              Expanded(
                child: Stack(
                  children: [
                    const Image(
                      fit: BoxFit.cover,
                      image: AssetImage('images/background-landing-page.png'),
                      opacity: AlwaysStoppedAnimation(0.7),
                    ),
                    // GAMBAR
                    SingleChildScrollView(
                      controller: controller,
                      child: Column(
                        children: <Widget>[
                          HomeContent(key: homeKey),
                          FeaturesContent(key: featureKey),
                          ScreenshotsContent(key: screenshotKey),
                          ContactContent(key: contactKey),
                          const SizedBox(height: 50),
                          Container(
                            width: width,
                            height: 50,
                            color: myBlue,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text('Copyright © 2023 - PT.Surya Putra Sukses',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          )
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
        ),
      ),
    );
  }
}
