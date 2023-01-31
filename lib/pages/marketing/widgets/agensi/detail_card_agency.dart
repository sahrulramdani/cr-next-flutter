import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class DetailCardAgency extends StatelessWidget {
  const DetailCardAgency({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: const [
            Image(
              image: AssetImage('assets/images/nametag.png'),
              width: 450,
            )
          ],
        ));
  }
}
