import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../exports.dart';

class CheckBoxWithTitleTile extends StatelessWidget {
  final String title;
  final RxBool isCheck;
  const CheckBoxWithTitleTile({
    super.key,
    required this.title,
    required this.isCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          isCheck.value = !isCheck.value;
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.r),
              ),
              value: isCheck.value,
              onChanged: (value) {
                isCheck.value = !isCheck.value;
              },
              side: BorderSide(
                color: AppColors.font.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 14.sp, fontWeight: isCheck.isTrue ? FontWeight.w500 : FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
