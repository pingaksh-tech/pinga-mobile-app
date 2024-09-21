import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../exports.dart';

class AppButton extends StatefulWidget {
  final ButtonType? buttonType;
  final ImageAlign? imageAlign;
  final BoxConstraints? constraints;
  final String? title;
  final TextStyle? titleStyle;
  final double? height;
  final bool? flexibleHeight;
  final double? width;
  final bool? flexibleWidth;
  final IconData? icon;
  final Color? loaderColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? highlightColor;
  final Gradient? gradient;
  final String? image;
  final Color? imageColor;
  final double? imageSize;
  final double? imageSpacing;
  final double? fontSize;
  final Widget? child;
  final bool? disableButton;
  final bool? loader;
  final bool? enableFeedback;
  final bool? showInternetWarning;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Duration? duration;

  final Function(bool)? onHighlightChanged;

  const AppButton(
      {super.key,
      this.constraints,
      this.title,
      this.titleStyle,
      this.buttonType = ButtonType.elevated,
      this.imageAlign = ImageAlign.startTitle,
      this.height,
      this.flexibleHeight = false,
      this.width,
      this.flexibleWidth = false,
      this.icon,
      this.loaderColor,
      this.backgroundColor,
      this.borderColor,
      this.gradient,
      this.image,
      this.imageColor,
      this.imageSize,
      this.imageSpacing,
      this.fontSize,
      this.child,
      this.enableFeedback = true,
      this.showInternetWarning = false,
      this.disableButton = false,
      this.loader = false,
      this.borderRadius,
      this.onPressed,
      this.onLongPress,
      this.padding,
      this.margin,
      this.duration,
      this.onHighlightChanged,
      this.highlightColor});

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  RxBool buttonPress = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TweenAnimationBuilder(
        duration: const Duration(milliseconds: 1200),
        curve: Curves.elasticOut,
        tween: widget.loader == true || buttonPress.value == true ? Tween(begin: 0.9, end: 0.97) : Tween(begin: 1.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: AnimatedContainer(
              duration: widget.duration ?? defaultDuration,
              width: widget.flexibleWidth == false ? (widget.width?.w ?? Get.width + (widget.margin?.horizontal ?? 0)) : null,
              height: widget.flexibleHeight == false ? (widget.height?.w ?? appButtonHeight + (widget.margin?.vertical ?? 0)) : null,
              margin: widget.padding ?? EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius ?? commonBorderRadius,
                color: widget.backgroundColor ?? (widget.buttonType == ButtonType.outline ? null : Theme.of(context).primaryColor.withOpacity(withMyOpacity)),
                border: widget.buttonType == ButtonType.outline ? Border.all(color: widget.borderColor ?? AppColors.outlineButtonBorder) : null,
                gradient: loadingOrDisableStatus
                    ? (widget.buttonType == ButtonType.gradient
                        ? (widget.gradient ??
                            LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                Theme.of(context).primaryColor.withOpacity(.2),
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColor.withOpacity(.2),
                              ],
                            ))
                        : null)
                    : null,
              ),
              child: RawMaterialButton(
                // constraints: widget.constraints ?? const BoxConstraints(minWidth: widget.flexibleWidth == false ? (widget.width?.w ?? Get.width + (widget.margin?.horizontal ?? 0)) : appButtonHight, minHeight: widget.flexibleHeight == false ? (widget.height?.w ?? appButtonHight + (widget.margin?.vertical ?? 0)) : appButtonHight),
                splashColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(widget.loader == false ? .1 : 0),
                highlightColor: widget.highlightColor ?? Theme.of(context).primaryColor.withOpacity(widget.buttonType == ButtonType.outline ? .1 : .0),
                shape: RoundedRectangleBorder(borderRadius: widget.borderRadius ?? commonBorderRadius),
                hoverElevation: widget.loader == false ? 4.0 : 0.0,
                elevation: widget.loader == false ? 2.0 : 0.0,
                disabledElevation: 0,
                highlightElevation: widget.loader == false ? 8.0 : 0.0,
                onPressed: loadingOrDisableStatus
                    ? () async {
                        if (widget.enableFeedback == true) {
                          HapticFeedback.lightImpact();
                        }
                        if (widget.showInternetWarning == true) {
                          if (await getConnectivityResult()) {
                            widget.onPressed != null ? widget.onPressed!() : null;
                          }
                        } else {
                          widget.onPressed != null ? widget.onPressed!() : null;
                        }
                      }
                    : null,
                onLongPress: loadingOrDisableStatus ? widget.onLongPress : null,
                onHighlightChanged: loadingOrDisableStatus
                    ? (press) {
                        setState(
                          () {
                            buttonPress.value = press;
                            widget.onHighlightChanged != null ? widget.onHighlightChanged!(press) : null;
                          },
                        );
                      }
                    : null,
                child: widget.loader == false
                    ? Padding(
                        padding: widget.margin ?? EdgeInsets.zero,
                        child: IntrinsicWidth(
                          child: (widget.child ??
                              Row(
                                mainAxisAlignment: titleMainAxisAlignment(imageAlign: widget.imageAlign),
                                children: [
                                  //** Icon Widget */
                                  if (!isValEmpty(widget.icon) && isValEmpty(widget.image)) ...[
                                    Icon(widget.icon, color: Colors.white, size: 24),
                                    // SizedBox(width: widget.imageSpacing ?? 5),
                                  ],

                                  //** Image widget */
                                  if (widget.imageAlign == ImageAlign.start || widget.imageAlign == ImageAlign.startTitle) imageWidget(),

                                  //** Title Widget */
                                  if (!isValEmpty(widget.title))
                                    Flexible(
                                      child: UiUtils.fadeSwitcherWidget(
                                        alignment: Alignment.center,
                                        child: Text(
                                          widget.title!,
                                          key: ValueKey<String>(widget.title!),
                                          overflow: TextOverflow.ellipsis,
                                          style: widget.titleStyle ?? AppTextStyle.appButtonStyle(context).copyWith(color: titleColor, fontSize: widget.fontSize),
                                        ),
                                      ),
                                    )
                                  else
                                    const SizedBox(),
                                  //** Image widget */
                                  if (widget.imageAlign == ImageAlign.end || widget.imageAlign == ImageAlign.endTitle) imageWidget(),
                                ],
                              )),
                        ),
                      )
                    : CircularLoader(
                        color: widget.loaderColor ?? (widget.buttonType == ButtonType.outline ? Theme.of(context).primaryColor.withOpacity(.7) : AppColors.getColorOnBackground(Theme.of(context).primaryColor)).withOpacity(.9),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  //** Image widget */
  Widget imageWidget() {
    if (!isValEmpty(widget.image)) {
      return IntrinsicWidth(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if ((widget.imageAlign == ImageAlign.end || widget.imageAlign == ImageAlign.endTitle) && !isValEmpty(widget.title)) SizedBox(width: widget.imageSpacing ?? 5),
            GetUtils.isVector(widget.image!)
                ? SvgPicture.asset(
                    widget.image!,
                    height: widget.imageSize ?? 22,
                    color: widget.imageColor, // ignore: deprecated_member_use
                    alignment: Alignment.bottomLeft,
                  )
                : Image.asset(
                    widget.image!,
                    height: widget.imageSize ?? 22,
                    color: widget.imageColor,
                    alignment: Alignment.bottomLeft,
                  ),
            if ((widget.imageAlign == ImageAlign.start || widget.imageAlign == ImageAlign.startTitle) && !isValEmpty(widget.title)) SizedBox(width: widget.imageSpacing ?? 5),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  MainAxisAlignment titleMainAxisAlignment({required ImageAlign? imageAlign}) {
    switch (imageAlign) {
      case ImageAlign.start:
        return MainAxisAlignment.spaceBetween;
      case ImageAlign.end:
        return MainAxisAlignment.spaceBetween;
      default:
        return MainAxisAlignment.center;
    }
  }

  Color? get titleColor {
    if (widget.buttonType == ButtonType.outline) {
      return Theme.of(context).colorScheme.primary.withOpacity(disableOpacity);
    } else {
      return AppColors.getColorOnBackground(Theme.of(context).primaryColor).withOpacity(disableOpacity);
    }
  }

  BorderRadius get commonBorderRadius {
    return BorderRadius.circular(defaultRadius);
  }

  bool get loadingOrDisableStatus {
    return widget.disableButton == false ? (widget.loader == false ? true : false) : false;
  }

  double get withMyOpacity {
    return widget.loader == false ? (widget.disableButton == true ? .2 : 1.0) : .4;
  }

  double get disableOpacity {
    return widget.disableButton == true ? (Get.isDarkMode ? .6 : .9) : 1;
  }
}
