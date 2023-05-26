// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/landing/src/widgets/responsive_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavbarPendaftaran extends ResponsiveWidget {
  const NavbarPendaftaran({Key key}) : super(key: key);

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
              height: 40.0,
            ),
            const SizedBox(width: 10.0),
            Expanded(child: Container()),
            Text(
              "Form Pendaftaran Online",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: myBlue,
                fontSize: 15,
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
    const navBarColor = Colors.white;
    return Stack(
      children: [
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
                  height: 30.0,
                ),
                Expanded(
                  child: Container(),
                ),
                Text(
                  "Form Pendaftaran Online",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: myBlue, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
