import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../exports.dart';

class CustomCheckboxTile extends StatelessWidget {
  const CustomCheckboxTile({
    super.key,
    this.scale,
    this.onChanged,
    this.title,
    this.titleStyle,
    required this.isSelected,
    this.borderWidth,
  });

  final double? scale;
  final void Function(bool?)? onChanged;
  final String? title;
  final TextStyle? titleStyle;
  final RxBool isSelected;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    Widget myCheckbox = Obx(
      () => Transform.scale(
        scale: scale ?? 1.2,
        child: Checkbox(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
          side: BorderSide(color: AppColors.primary, width: borderWidth ?? 1),
          value: isSelected.value,
          onChanged: (val) {
            onTap();
          },
        ),
      ),
    );

    if (!isValEmpty(title)) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Row(
          children: [
            myCheckbox,
            Flexible(
              child: Text(
                title ?? "",
                style: titleStyle,
              ),
            ),
          ],
        ),
      );
    } else {
      return myCheckbox;
    }
  }

  VoidCallback get onTap => () {
        isSelected.value = !isSelected.value;
        onChanged != null ? onChanged!(isSelected.value) : null;
      };
}
