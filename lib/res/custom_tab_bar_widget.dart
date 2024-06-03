import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../exports.dart';
import '../../packages/animated_counter/animated_counter.dart';
import '../data/model/common/tab_bar_model.dart';

class CustomTabBar extends StatefulWidget {
  final RxList<Rx<TabBarModel>> tabList;
  final Function(int, String)? onTap;
  final EdgeInsetsGeometry? padding;
  final List<Widget>? screenList;
  final TabController? tabController;
  final ScrollPhysics? physics;

  const CustomTabBar({
    super.key,
    required this.tabList,
    this.onTap,
    this.padding,
    this.screenList,
    this.tabController,
    this.physics,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

late String returnLabel;

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    if (widget.tabController == null) {
      return DefaultTabController(
        length: widget.tabList.length,
        child: tabWidget(),
      );
    } else {
      return tabWidget();
    }
  }

  Widget tabWidget() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 2),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: widget.padding,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              child: TabBar(
                physics: widget.physics,
                controller: widget.tabController,
                labelColor: Theme.of(context).primaryColor,
                labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 10.sp, letterSpacing: 0.5, fontWeight: FontWeight.w600, color: Theme.of(context).cardColor),
                unselectedLabelColor: AppColors.primary.withOpacity(1),
                unselectedLabelStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 10.sp,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w500,
                      // color: Theme.of(context).disabledColor,
                    ),
                automaticIndicatorColorAdjustment: true,
                overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                dividerColor: Colors.transparent,
                indicatorColor: Theme.of(context).colorScheme.primary,
                indicatorPadding: EdgeInsets.zero,
                indicatorWeight: double.minPositive,
                padding: const EdgeInsets.all(5),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius - 5),
                  color: Theme.of(context).colorScheme.primary,
                ),
                labelPadding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.tab,
                onTap: (index) {
                  returnLabel = widget.tabList[index].value.title ?? "";
                  if (widget.onTap != null) widget.onTap!(index, returnLabel);
                },
                tabs: List.generate(
                  widget.tabList.length,
                  (index) => Stack(
                    children: [
                      if (widget.tabList[index].value.showBadge?.value == true)
                        Align(
                          alignment: Alignment.topRight,
                          child: AnimatedSwitcher(
                            duration: defaultDuration,
                            child: widget.tabList[index].value.badgeLabel?.value != 0
                                ? CircleAvatar(
                                    radius: 9.r,
                                    child: Center(
                                      child: AnimatedFlipCounter(
                                        value: widget.tabList[index].value.badgeLabel?.value ?? 0,
                                        textStyle: TextStyle(color: Theme.of(context).scaffoldBackgroundColor, fontSize: 10.sp, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(defaultPadding / 1.5),
                          child: Text(
                            widget.tabList[index].value.title ?? "",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            widget.screenList != null
                ? Expanded(
                    child: TabBarView(
                      controller: widget.tabController,
                      children: widget.screenList ?? [],
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
