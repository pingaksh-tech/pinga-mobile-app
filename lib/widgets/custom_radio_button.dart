import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../exports.dart';

class CustomRadioButton extends StatelessWidget {
  final String? title;
  final RadioButtonType radioButtonType;
  final RxBool isSelected;
  final double? buttonSize;
  final VoidCallback? onPressed;
  final TextStyle? titleStyle;
  final Color? color;

  const CustomRadioButton({
    super.key,
    this.title,
    this.radioButtonType = RadioButtonType.filled,
    required this.isSelected,
    this.buttonSize,
    this.onPressed,
    this.titleStyle,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppRadioButton(
            isSelected: isSelected,
            radioButtonType: radioButtonType,
            buttonSize: buttonSize,
            color: color,
          ),
          8.horizontalSpace,
          AnimatedDefaultTextStyle(
            duration: defaultDuration,
            style: titleStyle ??
                Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: isSelected.isTrue ? FontWeight.w600 : FontWeight.w500,
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(isSelected.isTrue ? 1 : 0.4),
                      fontSize: 14.sp,
                    ),
            child: Text(title ?? ""),
          ),
        ],
      ),
    );
  }
}

class AppRadioButton extends StatelessWidget {
  final RxBool isSelected;
  final double? buttonSize;
  final VoidCallback? onPressed;
  final RadioButtonType radioButtonType;
  final Color? color;

  const AppRadioButton({
    super.key,
    required this.isSelected,
    this.buttonSize,
    this.onPressed,
    this.radioButtonType = RadioButtonType.filled,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (onPressed == null) {
      return newMethod(context);
    }
    return AppIconButton(
      onPressed: onPressed ?? () {},
      size: buttonSize != null ? (buttonSize! * 1.3) : 30,
      icon: newMethod(context),
    );
  }

  Widget newMethod(BuildContext context) {
    switch (radioButtonType) {
      case RadioButtonType.outline:
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: size,
          width: size,
          padding: const EdgeInsets.all(5.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected.isFalse ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).primaryColor,
            border: Border.all(
              color: (isSelected.isFalse ? AppColors.lightGrey : Colors.transparent),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected.isFalse ? Colors.transparent : Colors.white,
            ),
          ),
        );

      case RadioButtonType.filled:
        return Container(
          height: size,
          width: size,
          padding: EdgeInsets.all(2.h),
          decoration: BoxDecoration(border: Border.all(color: isSelected.isTrue ? Theme.of(context).primaryColor : color ?? AppColors.lightGrey, width: 1.3), shape: BoxShape.circle),
          child: CircleAvatar(backgroundColor: isSelected.isTrue ? Theme.of(context).primaryColor : Colors.transparent),
        );

      case RadioButtonType.done:
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: size,
          width: size,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected.isFalse ? Colors.transparent : Theme.of(context).primaryColor,
            border: Border.all(
              color: color ?? (isSelected.isFalse ? AppColors.lightGrey : Colors.transparent),
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              AppAssets.doneSmall,
              color: isSelected.isTrue ? AppColors.getColorOnBackground(Theme.of(context).primaryColor) : Colors.transparent, // ignore: deprecated_member_use
            ),
          ),
        );

      default:
        return const SizedBox();
    }
  }

  double get size => buttonSize ?? 17.h;
}
