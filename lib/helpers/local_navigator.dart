import 'package:flutter/widgets.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/routing/router.dart';
import 'package:flutter_web_course/routing/routes.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: overViewPageRoute,
      onGenerateRoute: generateRoute,
    );
