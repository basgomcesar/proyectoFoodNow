import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoWidget extends StatelessWidget {
  final bool isVisible;

  const LogoWidget({Key? key, required this.isVisible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? const SizedBox.shrink()
        : SvgPicture.asset(
            'assets/loginIcon.svg',
            width: 200,
            height: 200,
          );
  }
}
