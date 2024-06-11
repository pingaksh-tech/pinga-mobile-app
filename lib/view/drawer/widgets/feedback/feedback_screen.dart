import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../packages/cached_network_image/cached_network_image.dart';
import '../../../../res/app_bar.dart';
import '../../../../res/app_dialog.dart';
import '../../../../widgets/custom_radio_button.dart';
import 'feedback_controller.dart';

class FeedbackScreen extends StatelessWidget {
  FeedbackScreen({super.key});

  final FeedbackController con = Get.put(FeedbackController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        title: "Add Feedback",
      ),
      body: Obx(() {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          physics: const RangeMaintainingScrollPhysics(),
          children: [
            AppNetworkImage(imageUrl: con.vectorImageLink),
            Text(
              "Tell us what can be improved?",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font),
            ),
            (defaultPadding / 2).verticalSpace,
            Wrap(
              direction: Axis.horizontal,
              children: List.generate(
                FeedbackType.values.length,
                (index) => Obx(() {
                  return AppButton(
                    title: FeedbackType.values[index].label,
                    flexibleWidth: true,
                    height: 30.h,
                    borderColor: con.feedbackType.value == FeedbackType.values[index] ? Theme.of(context).primaryColor : Colors.transparent,
                    backgroundColor: con.feedbackType.value == FeedbackType.values[index] ? Theme.of(context).primaryColor.withOpacity(.1) : const Color(0x1EB4B4B4),
                    padding: EdgeInsets.only(right: defaultPadding / 1.5, bottom: defaultPadding / 1.5),
                    margin: EdgeInsets.symmetric(horizontal: defaultPadding / 1.7),
                    buttonType: ButtonType.outline,
                    titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: con.feedbackType.value == FeedbackType.values[index] ? Theme.of(context).primaryColor : AppColors.font.withOpacity(.6),
                        ),
                    onPressed: () {
                      con.feedbackType.value = FeedbackType.values[index];
                    },
                  );
                }),
              ),
            ),
            (defaultPadding / 3).verticalSpace,
            addFeedbackTile(context, feedbackType: con.feedbackType.value),
            (defaultPadding / 3).verticalSpace,

            /// Attachment
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Attachment",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14.5.sp, color: AppColors.font),
                      ),
                      Text(
                        "(Note : File size must not be greater than 2MB)",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 10.5.sp, color: AppColors.subText),
                      ),
                    ],
                  ),
                ),
                AppButton(
                  height: 28.h,
                  flexibleWidth: true,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        height: 15.h,
                        AppAssets.addDocumentSVG,
                        colorFilter: const ColorFilter.mode(AppColors.background, BlendMode.srcIn),
                      ),
                      8.horizontalSpace,
                      Text(
                        "ADD",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.background, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  onPressed: () {
                    pickImages(
                      context,
                      croppedFileChange: (cropper) {
                        if (cropper != null) {
                          con.attachmentList.add(cropper.path);
                        }
                      },
                    );
                  },
                )
              ],
            ),
            10.verticalSpace,
            if (con.attachmentList.isEmpty)
              Container(
                padding: EdgeInsets.all(defaultPadding * 1.4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  border: Border.all(color: AppColors.lightGrey),
                ),
                width: Get.width,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      AppAssets.noDocumentSVG,
                      colorFilter: ColorFilter.mode(
                        AppColors.font.withOpacity(.5),
                        BlendMode.srcIn,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      "No attachment found",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 12.6.sp,
                            color: AppColors.font.withOpacity(.7),
                          ),
                    ),
                  ],
                ),
              ),
            if (con.attachmentList.isNotEmpty)
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: con.attachmentList.length,
                separatorBuilder: (context, index) => SizedBox(height: defaultPadding / 1.3),
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.only(left: defaultPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultRadius / 2),
                    border: Border.all(color: AppColors.lightGrey),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        height: 16.h,
                        AppAssets.pictureIcon,
                        colorFilter: ColorFilter.mode(AppColors.font.withOpacity(.7), BlendMode.srcIn),
                      ),
                      6.horizontalSpace,
                      Expanded(
                        child: Text(
                          con.attachmentList[index].split("/").last,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.font.withOpacity(.7),
                              ),
                        ),
                      ),
                      AppIconButton(
                        icon: SvgPicture.asset(AppAssets.deleteIcon),
                        onPressed: () {
                          AppDialogs.cartDialog(
                            context,
                            dialogTitle: "Alert",
                            contentText: "Do you want to remove attachment?",
                            onPressed: () {
                              con.attachmentList.removeAt(index);
                              Get.back();
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            AppButton(
              padding: EdgeInsets.symmetric(vertical: defaultPadding * 2),
              title: "Submit",
              onPressed: () {
                Get.back();
              },
            )
          ],
        );
      }),
    );
  }

  Widget addFeedbackTile(BuildContext context, {required FeedbackType feedbackType}) {
    switch (feedbackType) {
      case FeedbackType.newDesign:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Satisfied with existing design
            Text(
              "Are you satisfied with the existing set of design?",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font),
            ),
            Wrap(
              direction: Axis.horizontal,
              children: List.generate(
                con.satisfyNewOrOldDesignList.length,
                (index) => CustomRadioButton(
                  title: con.satisfyNewOrOldDesignList[index],
                  isSelected: (con.isSatisfiedDesign.value == con.satisfyNewOrOldDesignList[index]).obs,
                  titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font),
                  color: AppColors.font,
                  onPressed: () {
                    con.isSatisfiedDesign.value = con.satisfyNewOrOldDesignList[index];
                  },
                ),
              ),
            ),
            AppTextField(
              hintText: "Enter design detail",
              controller: con.existingDesignCon.value,
              maxLines: 2,
              textInputAction: TextInputAction.done,
              contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 1.5, horizontal: defaultPadding / 1.5),
              padding: EdgeInsets.only(bottom: defaultPadding / 1.4),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(defaultRadius),
                ),
                borderSide: BorderSide.none,
              ),
            ),

            /// Looking new design
            Text(
              "Are you still looking for new innovation designs?",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font),
            ),
            Wrap(
              direction: Axis.horizontal,
              children: List.generate(
                con.satisfyNewOrOldDesignList.length,
                (index) => CustomRadioButton(
                  title: con.satisfyNewOrOldDesignList[index],
                  isSelected: (con.isNewDesign.value == con.satisfyNewOrOldDesignList[index]).obs,
                  titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font),
                  color: AppColors.font,
                  onPressed: () {
                    con.isNewDesign.value = con.satisfyNewOrOldDesignList[index];
                  },
                ),
              ),
            ),
          ],
        );
      case FeedbackType.appImprovement:
        return commonTextField(context, controller: con.appImprovementCon.value);
      case FeedbackType.orderProcessing:
        return commonTextField(context, controller: con.orderProcessingCon.value);
      case FeedbackType.areaImprovement:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Area Of Improvement",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font),
            ),
            (defaultPadding / 2).verticalSpace,
            Wrap(
              direction: Axis.horizontal,
              children: List.generate(
                con.areaImprovementList.length,
                (index) => Obx(() {
                  return AppButton(
                    title: con.areaImprovementList[index],
                    flexibleWidth: true,
                    height: 26.h,
                    borderColor: con.selectedArea.value == con.areaImprovementList[index] ? Theme.of(context).primaryColor : Colors.transparent,
                    backgroundColor: con.selectedArea.value == con.areaImprovementList[index] ? Theme.of(context).primaryColor.withOpacity(.1) : const Color(0x1EB4B4B4),
                    padding: EdgeInsets.only(right: defaultPadding / 1.5, bottom: defaultPadding / 1.5),
                    margin: EdgeInsets.symmetric(horizontal: defaultPadding / 1.7),
                    buttonType: ButtonType.outline,
                    titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: con.selectedArea.value == con.areaImprovementList[index] ? Theme.of(context).primaryColor : AppColors.font.withOpacity(.6),
                        ),
                    onPressed: () {
                      con.selectedArea.value = con.areaImprovementList[index];
                    },
                  );
                }),
              ),
            ),
            commonTextField(context, controller: con.areaImprovementCon.value)
          ],
        );
    }
  }

  Widget commonTextField(BuildContext context, {required TextEditingController controller}) {
    return AppTextField(
      title: "Suggestion / Solution",
      hintText: "Enter suggestion / solution",
      titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.font),
      controller: controller,
      maxLines: 4,
      textInputAction: TextInputAction.done,
      contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 1.5, horizontal: defaultPadding / 1.5),
      padding: EdgeInsets.only(bottom: defaultPadding / 1.4),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(defaultRadius),
        ),
        borderSide: BorderSide.none,
      ),
    );
  }
}
