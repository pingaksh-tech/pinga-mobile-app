import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import 'settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final SettingsController con = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        title: "Settings",
      ),
      body: ListView(
        physics: const RangeMaintainingScrollPhysics(),
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const RangeMaintainingScrollPhysics(),
            itemCount: con.settingMenu.length,
            separatorBuilder: (context, index) => const Divider(height: 0),
            itemBuilder: (context, index) => Obx(() {
              return SwitchListTile(
                value: con.settingMenu[index]['isTrue'].value,
                secondary: SvgPicture.asset(
                  con.settingMenu[index]['icon'],
                  height: con.settingMenu[index]['icon_height'],
                ),
                title: Text(con.settingMenu[index]['title'], style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font)),
                subtitle: Text(con.settingMenu[index]['subtitle'], style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400, fontSize: 10.4.sp)),
                activeColor: Theme.of(context).colorScheme.primary.withOpacity(.3),
                overlayColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                  return Theme.of(context).colorScheme.primary.withOpacity(.0);
                }),
                trackOutlineColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                  return Theme.of(context).colorScheme.primary.withOpacity(.4);
                }),
                thumbColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.background;
                  }
                  return Theme.of(context).colorScheme.primary.withOpacity(.8);
                }),
                onChanged: (value) {
                  con.settingMenu[index]['isTrue'].value = value;
                },
              );
            }),
          ),
          const Divider(
            height: 0,
          ),
          4.verticalSpace,
          ListTile(
            leading: SvgPicture.asset(AppAssets.changePasswordSVG),
            title: Text("Change password", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font)),
            trailing: SvgPicture.asset(
              height: 16,
              AppAssets.forwardIcon,
              colorFilter: const ColorFilter.mode(AppColors.font, BlendMode.srcIn),
            ),
            onTap: () {},
          ),
          const Divider(height: 0),
          ListTile(
            leading: SvgPicture.asset(AppAssets.clearDataSVG),
            title: Text("Clear all cache data", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font)),
            trailing: SvgPicture.asset(
              height: 16,
              AppAssets.forwardIcon,
              colorFilter: const ColorFilter.mode(AppColors.font, BlendMode.srcIn),
            ),
            onTap: () {},
          ),
          const Divider(height: 0),
        ],
      ),
    );
  }
}
