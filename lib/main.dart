import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/comp/scroll_behaviors.dart';
import 'package:flutter_web_course/controllers/menu_controller.dart';
import 'package:flutter_web_course/controllers/navigation_controller.dart';
import 'package:flutter_web_course/layout.dart';
import 'package:flutter_web_course/pages/404/error_page.dart';
import 'package:flutter_web_course/pages/authentication/authentication.dart';
import 'package:flutter_web_course/routing/routes.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  Get.put(MenuControler());
  Get.put(NavigationController());
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Color.fromARGB(255, 50, 136, 207)
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      initialRoute: authenticationPageRoute,
      unknownRoute: GetPage(
          name: "/not-found",
          page: () => const PageNotFound(),
          transition: Transition.fadeIn),
      getPages: [
        GetPage(name: rootRoute, page: () => const SiteLayout()),
        GetPage(
            name: authenticationPageRoute,
            page: () => const AuthenticationPage()),
        GetPage(name: "/not-found", page: () => const PageNotFound())
      ],
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      title: "Cahaya-Raudhah",
      theme: ThemeData(
          fontFamily: 'Gilroy',
          scaffoldBackgroundColor: light,
          // textTheme:
          //     GoogleFonts.mulishTextTheme().apply(bodyColor: Colors.black),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          })),
    );
  }
}
