import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';

//Warna Aktif
Color light = const Color(0xFFF7F8FC);
Color lightGrey = const Color(0xFFA4A6B3);
Color dark = const Color(0xFF363740);
Color active = const Color(0xFF3C19C0);
Color myBlue = const Color.fromARGB(255, 14, 116, 199);
Color bgBlue = const Color.fromARGB(255, 241, 242, 255);
Color myGrey = Colors.grey[700];
//Token

// String kodeToken = "";
// String namaUser = "";
// String username = "";
// String fotoUser;

String kodeToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InN1cGVyYWRtaW4iLCJpYXQiOjE2ODMxNzIxNjksImV4cCI6MTY4MzI1ODU2OX0.g_lCeqHh1-hWZkbt_YPTtLY7TjmcGl8K5AMLkNIOkJU";
String namaUser = "Superadmin";
String username = "superadmin";
String fotoUser;

// MENU CODE
String menuKode = "";

// AUTH PERMISSION
dynamic authAddx = '0';
dynamic authEdit = '0';
dynamic authDelt = '0';
dynamic authInqu = '0';
dynamic authPrnt = '0';
dynamic authExpt = '0';

bool enableForm = false;

//Url Aplikasi
String urlAddress = "http://localhost:3000";
// String urlAddress = "http://202.78.195.175:4000";

// STYLE WIDGET
const styleColumn = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontFamily: 'Gilroy',
    fontSize: 16);

final styleRowReguler =
    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]);

final styleRowPencapaian = TextStyle(
    fontWeight: FontWeight.bold, color: Colors.grey[800], fontSize: 16);

final styleHeaderSmall = TextStyle(
    fontFamily: 'Gilroy',
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: myBlue);

fncHeightTableWithCard(context) {
  final screenHeight = MediaQuery.of(context).size.height;

  return ResponsiveWidget.isSmallScreen(context)
      ? screenHeight * 0.57
      : screenHeight * 0.41;
}

fncHeightTableWithCardWithoutTambah(context) {
  final screenHeight = MediaQuery.of(context).size.height;

  return ResponsiveWidget.isSmallScreen(context)
      ? screenHeight * 0.62
      : screenHeight * 0.5;
}

fncHeightFormWithCard(context) {
  final screenHeight = MediaQuery.of(context).size.height;

  return ResponsiveWidget.isSmallScreen(context)
      ? screenHeight * 0.6
      : screenHeight * 0.47;
}

fncWidthModalForm(context) {
  final screenWidth = MediaQuery.of(context).size.width;

  return ResponsiveWidget.isSmallScreen(context)
      ? screenWidth * 0.95
      : screenWidth * 0.81;
}

fncWidthModalKeberangkatan(context) {
  final screenWidth = MediaQuery.of(context).size.width;

  return ResponsiveWidget.isSmallScreen(context)
      ? screenWidth * 0.95
      : screenWidth * 0.9;
}

fncTextHeaderFormStyle(context) {
  return TextStyle(
      fontFamily: 'Gilroy',
      fontWeight: FontWeight.bold,
      fontSize: ResponsiveWidget.isSmallScreen(context) ? 12 : 20,
      color: myBlue);
}

fncTextHeaderModalStyle(context) {
  return TextStyle(
    color: myGrey,
    fontWeight: FontWeight.bold,
    fontSize: ResponsiveWidget.isSmallScreen(context) ? 12 : 16,
  );
}

fncButtonAuthStyle(auth, context) {
  return ElevatedButton.styleFrom(
    backgroundColor: auth == '1' ? myBlue : Colors.blue[200],
    minimumSize: ResponsiveWidget.isSmallScreen(context)
        ? const Size(60, 40)
        : const Size(100, 40),
    shadowColor: Colors.grey,
    elevation: 5,
  );
}

fncButtonAuthPelangganStyle(auth, context) {
  return ElevatedButton.styleFrom(
    backgroundColor: auth == '1' ? myBlue : Colors.blue[200],
    minimumSize: ResponsiveWidget.isSmallScreen(context)
        ? const Size(100, 40)
        : const Size(280, 40),
    shadowColor: Colors.grey,
    elevation: 5,
  );
}

fncButtonRegulerStyle(context) {
  return ElevatedButton.styleFrom(
    backgroundColor: myBlue,
    minimumSize: ResponsiveWidget.isSmallScreen(context)
        ? const Size(60, 40)
        : const Size(100, 40),
    shadowColor: Colors.grey,
    elevation: 5,
  );
}

fncLabelButtonStyle(text, context) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'Gilroy',
      fontSize: ResponsiveWidget.isSmallScreen(context) ? 11 : 14,
    ),
  );
}

fncWidthColumnForm(context) {
  return ResponsiveWidget.isSmallScreen(context) ? 355 : 520;
}

fncWidthInputForm(context) {
  return ResponsiveWidget.isSmallScreen(context) ? 200 : 370;
}

fncWidthColumnModal(context) {
  return ResponsiveWidget.isSmallScreen(context) ? 310 : 530;
}

fncWidthColumnModalDet(context) {
  return ResponsiveWidget.isSmallScreen(context) ? 320 : 455;
}

fncWidthInputModal(context) {
  return ResponsiveWidget.isSmallScreen(context) ? 150 : 370;
}

fncWidthSearchBox(context) {
  return ResponsiveWidget.isSmallScreen(context) ? 180 : 250;
}

loadStart() {
  EasyLoading.show(status: 'Loading...');
}

loadEnd() {
  EasyLoading.showSuccess('Done!');
  EasyLoading.dismiss();
}
