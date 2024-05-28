import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final DashboardController con = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: const [
          AspectRatio(
            aspectRatio: 1,
            child: Center(
              child: Text("Dashboard"),
            ),
          ),
        ],
      ),
    );
  }
}
