// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/pages/landing/landing.dart';
import 'package:flutter_web_course/pages/landing/src/navigation_bar/nav_bar_button.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/responsive_widget.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavBar extends ResponsiveWidget {
  const NavBar({Key key}) : super(key: key);

  @override
  Widget buildDesktop(BuildContext context) {
    return const DesktopNavBar();
  }

  @override
  Widget buildMobile(BuildContext context) {
    return const MobileNavBar();
  }
}

class DesktopNavBar extends HookConsumerWidget {
  const DesktopNavBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isScrolled = ref.watch(scrolledProvider);
    const navBarColor = Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: navBarColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 7,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
        child: Row(
          children: <Widget>[
            Image.asset(
              "assets/images/logo_craudhah_lands.png",
              height: 60.0,
            ),
            const SizedBox(width: 10.0),
            // const Text(
            //   "Cahaya Raudhah",
            //   style: TextStyle(
            //     fontWeight: FontWeight.w700,
            //     color: Colors.black87,
            //     fontSize: 32,
            //   ),
            // ),
            Expanded(child: Container()),
            NavBarButton(
              onTap: () => ref.read(currentPageProvider.state).state = homeKey,
              text: "Beranda",
            ),
            NavBarButton(
              onTap: () =>
                  ref.read(currentPageProvider.state).state = featureKey,
              text: "Tentang",
            ),
            NavBarButton(
              onTap: () =>
                  ref.read(currentPageProvider.state).state = screenshotKey,
              text: "Produk",
            ),
            NavBarButton(
              onTap: () =>
                  ref.read(currentPageProvider.state).state = contactKey,
              text: "Kontak",
            ),
            ElevatedButton(
              onPressed: () {
                menuController.changeActiveitemTo(" ");
                Get.offAllNamed('/auth');
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 100,
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MobileNavBar extends HookConsumerWidget {
  const MobileNavBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final containerHeight = useState<double>(0.0);
    // final isScrolled = ref.watch(scrolledProvider);

    const navBarColor = Colors.white;
    return Stack(
      children: [
        AnimatedContainer(
          margin: const EdgeInsets.only(top: 70.0),
          duration: const Duration(milliseconds: 350),
          curve: Curves.ease,
          height: containerHeight.value,
          child: SingleChildScrollView(
            child: Column(
              children: [
                NavBarButton(
                  text: "Beranda",
                  onTap: () {
                    ref.read(currentPageProvider.state).state = homeKey;
                    containerHeight.value = 0;
                  },
                ),
                NavBarButton(
                  text: "Tentang",
                  onTap: () {
                    ref.read(currentPageProvider.state).state = featureKey;
                    containerHeight.value = 0;
                  },
                ),
                NavBarButton(
                  text: "Produk",
                  onTap: () {
                    ref.read(currentPageProvider.state).state = screenshotKey;
                    containerHeight.value = 0;
                  },
                ),
                NavBarButton(
                  text: "Kontak",
                  onTap: () {
                    ref.read(currentPageProvider.state).state = contactKey;
                    containerHeight.value = 0;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    menuController.changeActiveitemTo(" ");
                    Get.offAllNamed('/auth');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 100,
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: navBarColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 7,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 5, 14, 5),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "assets/images/logo_craudhah_lands.png",
                  height: 60.0,
                ),
                // const SizedBox(width: 10.0),
                // const Text(
                //   "Company Name",
                //   style: TextStyle(
                //       fontWeight: FontWeight.w700,
                //       color: Colors.black87,
                //       fontSize: 32),
                // ),
                Expanded(
                  child: Container(),
                ),
                const SizedBox(height: 20),
                Material(
                  child: InkWell(
                    splashColor: Colors.white60,
                    onTap: () {
                      final height = containerHeight.value > 0 ? 0.0 : 240.0;
                      containerHeight.value = height;
                    },
                    child: const Icon(
                      Icons.menu,
                      color: Colors.black54,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
