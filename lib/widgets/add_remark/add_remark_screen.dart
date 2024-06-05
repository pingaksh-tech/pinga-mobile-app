import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import '../../../../widgets/custom_check_box_tile.dart';
import 'add_remark_controller.dart';

class AddRemarkScreen extends StatelessWidget {
  AddRemarkScreen({super.key});

  final AddRemarkController con = Get.put(AddRemarkController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: MyAppBar(
          backgroundColor: AppColors.background,
          title: "Your Remark",
          centerTitle: false,
        ),
        body: Obx(() {
          return ListView.builder(
            physics: const RangeMaintainingScrollPhysics(),
            padding: EdgeInsets.all(defaultPadding).copyWith(bottom: 150.h),
            shrinkWrap: true,
            itemCount: con.remarkList.length,
            itemBuilder: (context, index) => CustomCheckboxTile(
              scale: 1,
              title: con.remarkList[index],
              titleStyle: Theme.of(context).textTheme.titleMedium,
              isSelected: RxBool((con.selectedRemark.value == con.remarkList[index])),
              onChanged: (value) {
                con.selectedRemark.value = con.remarkList[index];

                con.checkDisableButton();
              },
            ),
          );
        }),
        bottomSheet: Obx(() {
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              AppTextField(
                title: "Add Remark",
                hintText: "Enter remark",
                contentPadding: EdgeInsets.all(defaultPadding / 1.2),
                padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(top: defaultPadding),
                textInputAction: TextInputAction.done,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(defaultRadius),
                  ),
                  borderSide: BorderSide.none,
                ),
                controller: con.remarkCon.value,
                validation: con.remarkValidation.value,
                errorMessage: con.remarkError.value,
                onChanged: (value) {
                  con.checkDisableButton();
                },
              ),
              AppButton(
                title: "Add",
                disableButton: con.disableButton.value,
                padding: EdgeInsets.all(defaultPadding).copyWith(bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  // if (con.remarkCon.value.text.trim().isNotEmpty) {

                  // }
                  con.remarkCon.value.clear();
                  Get.back(result: con.selectedRemark);
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
