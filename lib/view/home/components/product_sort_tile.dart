import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../exports.dart';

class ProductSortTile extends StatelessWidget {
  final String title;
  final RxBool isCheck;
  const ProductSortTile({
    super.key,
    required this.title,
    required this.isCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
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
          ),
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
