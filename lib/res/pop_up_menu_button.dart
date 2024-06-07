import 'package:flutter/material.dart';

import '../exports.dart';

class AppPopUpMenuButton extends StatelessWidget {
  final List<String> menuList;
  final Widget? child;
  final Function(String)? onSelect;
  final ShapeBorder? shape;
  final TextStyle? style;
  final PopupMenuPosition? position;

  const AppPopUpMenuButton({
    super.key,
    required this.menuList,
    required this.child,
    this.onSelect,
    this.shape,
    this.style,
    this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      color: Colors.transparent,
      child: PopupMenuButton(
        splashRadius: defaultRadius,
        offset: const Offset(1, 1),
        shadowColor: AppColors.lightGrey.withOpacity(1),
        elevation: 2,
        shape: shape,
        position: position ?? PopupMenuPosition.under,
        itemBuilder: (context) => menuList
            .map(
              (e) => PopupMenuItem(
                value: e.toString().toLowerCase(),
                child: Text(
                  e,
                  style: style ?? Theme.of(context).textTheme.titleMedium,
                ),
              ),
            )
            .toList(),
        onSelected: onSelect,
        child: child,
      ),
    );
  }
}
