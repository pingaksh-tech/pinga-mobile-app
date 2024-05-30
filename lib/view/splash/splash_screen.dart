import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController con = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: const [
          // AspectRatio(
          //   aspectRatio: 1,
          //   child: Center(
          //     child: Text("Splash"),
          //   ),
          // ),
        ],
      ),
    );
  }
}
