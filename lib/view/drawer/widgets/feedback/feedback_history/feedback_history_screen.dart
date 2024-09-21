import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../exports.dart';
import '../../../../../res/app_bar.dart';
import '../../../../../res/empty_element.dart';
import 'feedback_history_controller.dart';

class FeedbackHistoryScreen extends StatelessWidget {
  FeedbackHistoryScreen({super.key});

  final FeedbackHistoryController con = Get.put(FeedbackHistoryController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(
          title: "Feedback History",
        ),
        body: con.feedbackHistory.isNotEmpty
            ? ListView.separated(
                padding: EdgeInsets.all(defaultPadding),
                physics: const RangeMaintainingScrollPhysics(),
                itemCount: con.feedbackHistory.length,
                separatorBuilder: (context, index) => SizedBox(height: defaultPadding),
                itemBuilder: (context, index) => historyDetailTile(
                  context,
                  feedbackType: con.feedbackHistory[index].feedbackType ?? '',
                  category: con.feedbackHistory[index].category ?? '',
                  oldDesign: con.feedbackHistory[index].oldDesign,
                  newDesign: con.feedbackHistory[index].newDesign,
                  details: con.feedbackHistory[index].details,
                ),
              )
            : const EmptyElement(
                title: "History is empty",
                imagePath: AppAssets.emptyData,
              ),
      );
    });
  }

  Widget historyDetailTile(
    BuildContext context, {
    required String feedbackType,
    String? category,
    String? oldDesign,
    String? newDesign,
    String? details,
  }) {
    return Container(
      padding: EdgeInsets.all(defaultPadding / 1.5),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(defaultRadius),
        boxShadow: defaultShadowAllSide,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                FeedbackType.fromSlug(feedbackType).label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
              ),

              /// Category in Area of implement
              if (FeedbackType.fromSlug(feedbackType) == FeedbackType.areaImprovement)
                Text(
                  category?.capitalizeFirst ?? '',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.font.withOpacity(.6),
                      ),
                ),
            ],
          ),
          if (FeedbackType.fromSlug(feedbackType) == FeedbackType.newDesign) ...[
            const Divider(),

            /// satisfy with old design
            if (!isValEmpty(oldDesign)) ...[
              Text(
                "Are you satisfied with the existing set of design?",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 12.8.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.font,
                    ),
              ),
              Text(
                "-> ${oldDesign?.capitalizeFirst}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.font,
                    ),
              ),
            ],

            /// looking for new design
            if (!isValEmpty(newDesign)) ...[
              Text(
                "Are you still looking for new innovation designs?",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 12.8.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.font,
                    ),
              ),
              Text(
                "-> ${newDesign?.capitalizeFirst}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.font,
                    ),
              ),
            ]
          ],
          const Divider(),
          if (!isValEmpty(details)) ...[
            Text(
              FeedbackType.fromSlug(feedbackType) == FeedbackType.newDesign ? "Design Detail :" : "Suggestion / Solution  :",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 12.8.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.font,
                  ),
            ),
            Text(
              "$details",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.font,
                  ),
            )
          ]
        ],
      ),
    );
  }
}
