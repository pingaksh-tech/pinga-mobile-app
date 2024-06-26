import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/model/common/splash_model.dart';
import '../../../exports.dart';

class UnderMaintenanceScreen extends StatelessWidget {
  const UnderMaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Center(
            child: Scrollbar(
              child: ListView(
                shrinkWrap: true,
                physics: const RangeMaintainingScrollPhysics(),
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  imageWidget,
                  defaultPadding.verticalSpace,
                  titleWidget,
                  (defaultPadding / 2).verticalSpace,
                  subTitleWidget,
                  // const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppMaintenanceModel? get appMaintenanceModel => (!isValEmpty(Get.arguments) && (Get.arguments['appMaintenanceModel'].runtimeType == AppMaintenanceModel)) ? Get.arguments['appMaintenanceModel'] : null;

  bool get isWholeAppUnderMaintenance => appMaintenanceModel?.underMaintenance ?? false;

  Widget get imageWidget {
    return Image.asset(
      AppAssets.underMaintenancePNG,
      width: Get.width,
      height: Get.width / 1.5,
    );
  }

  Widget get titleWidget {
    return Text(
      appMaintenanceModel?.title ?? "App is under maintenance",
      textAlign: TextAlign.center,
      style: Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }

  Widget get subTitleWidget {
    return Text(
      appMaintenanceModel?.message ?? "We're currently under maintenance to improve the app experience. Be back soon!",
      textAlign: TextAlign.center,
      style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: Theme.of(Get.context!).textTheme.bodyMedium?.color?.withOpacity(0.8),
          ),
    );
  }
}
