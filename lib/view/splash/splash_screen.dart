import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../exports.dart';
import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController con = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutCubic,
          tween: Tween(begin: 20.0, end: 1.0),
          builder: (context, value, child) {
            return Align(
              alignment: Alignment.center,
              child: AnimatedOpacity(
                opacity: value == 20 ? 0 : 1,
                duration: const Duration(milliseconds: 700),
                child: SvgPicture.asset(
                  width: Get.width / 1.8,
                  AppAssets.pingakshFillLogo,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
