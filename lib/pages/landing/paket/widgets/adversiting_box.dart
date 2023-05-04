import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';

class AdversitingBoxWidget extends StatefulWidget {
  const AdversitingBoxWidget({
    Key key,
  }) : super(key: key);

  @override
  State<AdversitingBoxWidget> createState() => _AdversitingBoxWidgetState();
}

class _AdversitingBoxWidgetState extends State<AdversitingBoxWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          screenWidth <= mediumScreenSize
              ? Column(
                  children: [
                    SizedBox(
                      width: screenWidth,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/jamaah-1.png')),
                              ),
                              child: const SizedBox(),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/jamaah-2.png')),
                              ),
                              child: const SizedBox(),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/jamaah-3.png')),
                              ),
                              child: const SizedBox(),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/jamaah-4.png')),
                              ),
                              child: const SizedBox(),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/jamaah-5.png')),
                              ),
                              child: const SizedBox(),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: screenWidth,
                      child: Column(children: const [
                        Text(
                          'Sudah lebih dari 5000 orang mempercayakan PT. Cahaya Raudhah sebagai Partner Perjalanan Umroh dan Haji Mereka',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 50),
                        Text(
                          'Segeralah Mendaftar dan Menjadi Bagian Dari Jamaah Cahaya Raudhah !!!',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ]),
                    )
                  ],
                )
              : Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.35,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/jamaah-1.png')),
                              ),
                              child: const SizedBox(),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/jamaah-2.png')),
                              ),
                              child: const SizedBox(),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/jamaah-3.png')),
                              ),
                              child: const SizedBox(),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/jamaah-4.png')),
                              ),
                              child: const SizedBox(),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/jamaah-5.png')),
                              ),
                              child: const SizedBox(),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                        child: SizedBox(
                      child: Column(children: const [
                        Text(
                          'Sudah lebih dari 5000 orang mempercayakan PT. Cahaya Raudhah sebagai Partner Perjalanan Umroh dan Haji Mereka',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 50),
                        Text(
                          'Segeralah Mendaftar dan Menjadi Bagian Dari Jamaah Cahaya Raudhah !!!',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ))
                  ],
                )
        ],
      ),
    );
  }
}
