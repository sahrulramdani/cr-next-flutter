// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavBarButton extends HookConsumerWidget {
  final VoidCallback onTap;
  final String text;

  const NavBarButton({
    Key key,
    @required this.onTap,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor = useState<Color>(Colors.black);

    return MouseRegion(
      onEnter: (value) {
        textColor.value = myBlue;
      },
      onExit: (value) {
        textColor.value = Colors.grey[800];
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 50,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor.value,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
