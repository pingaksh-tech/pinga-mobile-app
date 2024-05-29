import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/utils.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double? elevation;
  final double? toolbarHeight;
  final TextStyle? titleStyle;
  final VoidCallback? onTap;
  final List<Widget>? actions;
  final VoidCallback? titleOnTap;
  final Widget? child;
  @override
  final Size preferredSize;
  final PreferredSizeWidget? bottom;

  MyAppBar({
    super.key,
    this.title,
    this.titleStyle,
    this.elevation,
    this.toolbarHeight,
    this.bottom,
    this.onTap,
    this.actions,
    this.titleOnTap,
    this.child,
  })  : assert(elevation == null || elevation >= 0.0),
        preferredSize = _PreferredAppBarSize(toolbarHeight, bottom?.preferredSize.height);

  static double preferredHeightFor(BuildContext context, Size preferredSize) {
    if (preferredSize is _PreferredAppBarSize && preferredSize.toolbarHeight == null) {
      return (AppBarTheme.of(context).toolbarHeight ?? kToolbarHeight) + (preferredSize.bottomHeight ?? 0);
    }
    return preferredSize.height;
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: Container(
        // decoration: BoxDecoration(
        //   boxShadow: [
        //     BoxShadow(
        //       color: Theme.of(context).primaryColor.withOpacity(.1),
        //       offset: const Offset(0, 2.0),
        //       blurRadius: 4,
        //     )
        //   ],
        // ),
        child: AppBar(
          elevation: elevation ?? 0,
          centerTitle: false,
          foregroundColor: Colors.black,
          automaticallyImplyLeading: true,
          toolbarHeight: toolbarHeight ?? 75,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: GestureDetector(
            onTap: titleOnTap,
            child: child ??
                Text(
                  title ?? "",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 22.sp, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor),
                ),
          ),
          actions: !isValEmpty(actions) ? actions : null,
        ),
      ),
    );
  }
}

class _PreferredAppBarSize extends Size {
  final double? toolbarHeight;
  final double? bottomHeight;

  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight) : super.fromHeight((toolbarHeight ?? 60) + (bottomHeight ?? 0));
}
