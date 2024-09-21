import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../exports.dart';

class CheckBoxWithTitleTile extends StatelessWidget {
  final String title;
  final RxBool isCheck;
  final VoidCallback? onTap;
  final void Function(bool?)? onChanged;
  final bool isMultiSelection;
  const CheckBoxWithTitleTile({
    super.key,
    required this.title,
    required this.isCheck,
    this.onTap,
    this.onChanged,
    this.isMultiSelection = true,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: isMultiSelection ? () => isCheck.value = !isCheck.value : onTap,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Checkbox(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
              ),
              value: isCheck.value,
              onChanged: isMultiSelection
                  ? (value) {
                      isCheck.value = !isCheck.value;
                    }
                  : onChanged,
              side: BorderSide(
                color: AppColors.font.withOpacity(0.5),
              ),
            ),
            if (!isValEmpty(title))
              Text(
                title,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight:
                        isCheck.isTrue ? FontWeight.w500 : FontWeight.w400),
              )
          ],
        ),
      ),
    );
  }
}
