import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../exports.dart';

class SliderWithTitle extends StatelessWidget {
  final RxDouble maxValue;
  final RxDouble minValue;
  final String title;
  const SliderWithTitle({
    super.key,
    required this.maxValue,
    required this.minValue,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ).paddingOnly(bottom: defaultPadding / 5),
        Text(
          "${minValue.toStringAsFixed(2)} - ${maxValue.toStringAsFixed(2)}",
          style: AppTextStyle.titleStyle(context).copyWith(fontSize: 13.sp),
        ),
        Theme(
          data: ThemeData(
            sliderTheme: const SliderThemeData(trackHeight: 2),
          ),
          child: RangeSlider(
            values: RangeValues(minValue.value, maxValue.value),
            activeColor: Theme.of(context).primaryColor,
            max: maxValue.value,
            min: minValue.value,
            onChanged: (value) {
              minValue.value = value.start;
              maxValue.value = value.end;
            },
          ),
        ),
      ],
    );
  }
}
