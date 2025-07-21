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
    this.behavior,
    this.isShowCheckBox = true,
  });

  final double? scale;
  final void Function(bool?)? onChanged;
  final String? title;
  final TextStyle? titleStyle;
  final RxBool isSelected;
  final double? borderWidth;
  final HitTestBehavior? behavior;
  final bool? isShowCheckBox;

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
          onChanged: isShowCheckBox == true
              ? (val) {
                  onTap();
                }
              : null,
        ),
      ),
    );

    if (!isValEmpty(title)) {
      return GestureDetector(
        behavior: behavior ?? HitTestBehavior.translucent,
        onTap: isShowCheckBox == true ? onTap : null,
        child: Row(
          children: [
            if (isShowCheckBox ?? true) myCheckbox,
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  title ?? "",
                  style: titleStyle,
                ),
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
