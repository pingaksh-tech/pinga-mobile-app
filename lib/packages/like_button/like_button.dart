import 'dart:async';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class MFLikeButton extends StatefulWidget {
  final Color? likeColor;
  final Color? startIconColor;
  final Function(bool)? onChange;
  final double? buttonSize;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final BoxShape? shape;
  final LikeButtonTapCallback? onTap;
  final bool? isLiked;
  final Widget? selectedIcon;
  final Widget? unSelectedIcon;

  const MFLikeButton({
    super.key,
    this.onChange,
    this.likeColor,
    this.startIconColor,
    this.buttonSize,
    this.iconSize,
    this.padding,
    this.borderColor,
    this.backgroundColor,
    this.borderRadius,
    this.shape,
    this.onTap,
    this.isLiked,
    this.selectedIcon,
    this.unSelectedIcon,
  });

  @override
  State<MFLikeButton> createState() => _MFLikeButtonState();
}

class _MFLikeButtonState extends State<MFLikeButton> {
  bool tempBool = false;
  late Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget.buttonSize ?? 20) + 12.0,
      width: (widget.buttonSize ?? 20) + 12.0,
      margin: widget.padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: widget.shape != BoxShape.circle ? (widget.borderRadius ?? BorderRadius.circular(8)) : null,
        shape: widget.shape ?? BoxShape.rectangle,
        color: widget.backgroundColor,
        border: (widget.borderColor == const Color(0xFF000000) || widget.borderColor != null) ? Border.all(color: widget.borderColor ?? Theme.of(context).primaryColor, width: 2) : null,
      ),
      child: Center(
        child: LikeButton(
          isLiked: widget.isLiked ?? false,
          size: widget.buttonSize ?? 20,
          animationDuration: const Duration(milliseconds: 1000),
          circleColor: CircleColor(
            start: (widget.likeColor ?? Colors.red),
            end: (widget.likeColor?.withOpacity(0.5) ?? Colors.red.withOpacity(0.5)),
          ),
          bubblesColor: BubblesColor(
            dotPrimaryColor: (widget.likeColor ?? Colors.red),
            dotSecondaryColor: (widget.likeColor?.withOpacity(0.5) ?? Colors.red.withOpacity(0.5)),
          ),
          onTap: widget.onTap,
          likeBuilder: (bool isLiked) {
            widget.onChange != null ? widget.onChange!(isLiked) : null;
            return Padding(padding: const EdgeInsets.only(left: 3), child: Center(child: isLiked ? (widget.selectedIcon ?? buttonIcon(isLiked)) : (widget.unSelectedIcon ?? buttonIcon(isLiked))));
          },
        ),
      ),
    );
  }

  Widget buttonIcon(bool isLiked) {
    return Icon(
      isLiked ? Icons.favorite : Icons.favorite_border,
      size: widget.iconSize ?? 20,
      // color: startIconColor == null ? (isLiked ? Colors.grey : (startIconColor ?? likeColor)) : (likeColor ?? (isLiked ? Colors.red : Colors.grey)),
      color: (isLiked ? (widget.likeColor ?? Colors.red) : ((widget.startIconColor ?? widget.likeColor) ?? Colors.grey)),
    );
  }
}
