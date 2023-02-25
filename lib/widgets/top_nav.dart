import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';

import 'custom_text.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leadingWidth: 200,
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(
                      image:
                          AssetImage('assets/images/logo_craudhah_lands.png'),
                      width: 200),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: myBlue,
                    ),
                    onPressed: () {
                      key.currentState.openDrawer();
                    },
                  ),
                ],
              ),
            ),
      elevation: 0,
      title: Row(
        children: [
          Expanded(child: Container()),
          // IconButton(
          //   icon: Icon(
          //     Icons.settings,
          //     color: myBlue,
          //   ),
          //   onPressed: () {},
          // ),
          // Stack(
          //   children: [
          //     IconButton(
          //       icon: Icon(
          //         Icons.notifications,
          //         color: myBlue,
          //       ),
          //       onPressed: () {
          //         Positioned(
          //             top: 7,
          //             right: 7,
          //             child: Container(
          //               width: 12,
          //               height: 12,
          //               padding: const EdgeInsets.all(4),
          //               decoration: BoxDecoration(
          //                   color: active,
          //                   borderRadius: BorderRadius.circular(30),
          //                   border: Border.all(color: light, width: 2)),
          //             ));
          //       },
          //     )
          //   ],
          // ),
          SizedBox(
            width: !ResponsiveWidget.isSmallScreen(context) ? 24 : 0,
          ),
          // !ResponsiveWidget.isSmallScreen(context)
          //     ? FittedBox(
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           children: [
          //             CustomText(
          //               text: namaUser ?? 'Admin',
          //               color: myGrey,
          //             ),
          //           ],
          //         ),
          //       )
          //     : const FittedBox(),
          // const SizedBox(
          //   width: 16,
          // ),
          // Container(
          //   decoration: BoxDecoration(
          //       color: Colors.white, borderRadius: BorderRadius.circular(30)),
          //   child: fotoUser == null
          //       ? Container(
          //           padding: const EdgeInsets.all(2),
          //           margin: const EdgeInsets.all(2),
          //           child: const CircleAvatar(
          //             backgroundImage:
          //                 AssetImage('assets/images/profile-none.jpg'),
          //           ),
          //         )
          //       : Container(
          //           padding: const EdgeInsets.all(2),
          //           margin: const EdgeInsets.all(2),
          //           child: CircleAvatar(
          //             backgroundImage:
          //                 NetworkImage('$urlAddress/uploads/profil/$fotoUser'),
          //           ),
          //         ),
          // )
        ],
      ),
      iconTheme: IconThemeData(color: myBlue),
      backgroundColor: Colors.white,
      shadowColor: myBlue,
    );
