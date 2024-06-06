import 'package:flutter/material.dart';

import '../exports.dart';

class AppPopUpMenuButton extends StatelessWidget {
  final List<String> menuList;
  final Widget? child;
  final Function(String)? onSelect;

  const AppPopUpMenuButton({super.key, required this.menuList, required this.child, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: PopupMenuButton(
        splashRadius: defaultRadius,
        position: PopupMenuPosition.under,
        itemBuilder: (context) => menuList
            .map(
              (e) => PopupMenuItem(
                value: e.toString().toLowerCase(),
                child: Text(
                  e,
                  style: Theme.of(context).textTheme.titleMedium,
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
