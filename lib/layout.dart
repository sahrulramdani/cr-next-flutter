import 'package:flutter/material.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/widgets/drawer_submenu.dart';
import 'package:flutter_web_course/widgets/large_screen.dart';
import 'package:flutter_web_course/widgets/side_menu.dart';
import 'package:flutter_web_course/widgets/small_screen.dart';
import 'package:flutter_web_course/widgets/top_nav.dart';

class SiteLayout extends StatefulWidget {
  const SiteLayout({Key key}) : super(key: key);

  @override
  State<SiteLayout> createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: topNavigationBar(context, scaffoldKey),
        drawer: const Drawer(
          child: SideMenu(),
        ),
        endDrawer: const DrawerSubMenu(),
        body: const ResponsiveWidget(
          largeScreen: LargeScreen(),
          smallScreen: SmallScreen(),
        ));
  }
}
