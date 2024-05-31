import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingaksh_mobile/exports.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text(
              "Watch List",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.watchListScreen);
            },
          )
        ],
      ),
    );
  }
}
