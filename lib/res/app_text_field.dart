import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../exports.dart';

class AppTextField extends StatefulWidget {
  /// Global property
  final EdgeInsetsGeometry? padding;

  /// Title widget
  final String? title;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? titlePadding;

  /// Filed widget
  final TextFieldType? textFieldType;
  final DateTime? selectedDate;

  final TextStyle? style;
  final TextEditingController? controller;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? initialValue;

  final Function(String value)? onChanged;
  final Function(dynamic value)? onDateOrTimeChange;
  final String? Function(String?)? validate;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onFieldSubmitted;

  final Widget? prefixIcon;
  final VoidCallback? prefixOnTap;
  final Widget? suffixIcon;
  final VoidCallback? suffixOnTap;

  final int? maxLines;
  final bool? enabled;
  final bool? readOnly;
  final bool? obscureText;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsets? scrollPadding;

  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;

  final Color? fillColor;
  final Color? cursorColor;
  final bool? autofocus;
  final double? radius;
  final double? cursorHeight;

  final InputBorder? enabledBorder;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;
  final InputBorder? errorBorder;

  final bool? defaultMaxLengthView;

  /// Error widget
  final String? errorMessage;
  final bool? validation;
  final TextStyle? errorStyle;
  final double? errorSpacing;
  final double? errorHeight;

  const AppTextField({
    super.key,

    /// Global property
    this.padding,

    /// Title widget
    this.title,
    this.titleStyle,
    this.titlePadding,

    /// Filed widget
    this.textFieldType = TextFieldType.normal,
    this.autofillHints,
    this.selectedDate,
    this.style,
    this.controller,
    this.hintText,
    this.hintStyle,
    this.initialValue,
    this.onChanged,
    this.onDateOrTimeChange,
    this.validate,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.prefixOnTap,
    this.suffixIcon,
    this.suffixOnTap,
    this.maxLines,
    this.enabled,
    this.readOnly,
    this.obscureText,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
    this.maxLength,
    this.contentPadding,
    this.scrollPadding,
    this.textCapitalization = TextCapitalization.none,
    this.fillColor,
    this.cursorColor,
    this.autofocus,
    this.radius,
    this.cursorHeight,
    this.enabledBorder,
    this.border,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.errorBorder,
    this.defaultMaxLengthView,

    /// Error widget
    this.errorMessage,
    this.validation,
    this.errorStyle,
    this.errorSpacing,
    this.errorHeight,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  // Textfield type date.
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  // Field active.
  final FocusNode _focus = FocusNode();
  bool isFieldActive = false;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      widget.focusNode?.addListener(_onFocusChange);
    } else {
      _focus.addListener(_onFocusChange);
    }
  }

  void removeListener() {
    if (mounted) {
      if (widget.focusNode != null) {
        widget.focusNode?.removeListener(_onFocusChange);
      } else {
        _focus.removeListener(_onFocusChange);
      }
    }
  }

  void _onFocusChange() {
    setState(() {
      if (widget.focusNode != null) {
        isFieldActive = widget.focusNode?.hasFocus ?? false;
      } else {
        isFieldActive = _focus.hasFocus;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    removeListener();
    _focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 13.5.sp / 1.3),
                  child: textFieldWidget(context),
                ),
                if (widget.title != null && widget.title!.isNotEmpty) ...[
                  Container(
                    margin: EdgeInsets.only(left: defaultPadding * 1.2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: FieldTitleWidget(
                      context,
                      title: widget.title ?? "",
                      isFieldActive: widget.readOnly == true ? false : isFieldActive,
                      titleStyle: widget.titleStyle,
                      padding: widget.titlePadding ?? EdgeInsets.symmetric(horizontal: defaultPadding / 3),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (widget.errorMessage != null && widget.errorMessage!.isNotEmpty)
            FieldErrorWidget(
              context,
              errorHeight: widget.errorHeight,
              errorSpacing: widget.errorSpacing,
              validation: widget.validation,
              errorStyle: widget.errorStyle,
              errorMessage: widget.errorMessage,
            ),
        ],
      ),
    );
  }

  TextFormField textFieldWidget(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20),
      focusNode: (widget.focusNode ?? _focus),
      autofillHints: widget.autofillHints,
      autofocus: widget.autofocus ?? false,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: widget.cursorColor ?? Theme.of(context).primaryColor,
      initialValue: widget.initialValue,
      controller: widget.controller,
      enabled: widget.enabled,
      cursorHeight: widget.cursorHeight,
      obscuringCharacter: "*",
      maxLength: widget.validation == true ? (widget.defaultMaxLengthView == true ? (widget.maxLength != 0 ? widget.maxLength : null) : null) : null,
      obscureText: widget.obscureText ?? false,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      onChanged: (String value) {
        widget.onChanged != null ? widget.onChanged!(value) : null;
      },
      maxLines: widget.maxLines ?? 1,
      onFieldSubmitted: widget.onFieldSubmitted,
      style: textFormFieldStyle,
      inputFormatters: widget.inputFormatters ??
          [
            if (widget.maxLength != null) LengthLimitingTextInputFormatter(widget.maxLength),
          ],
      readOnly: readOnly,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.fillColor ?? Theme.of(context).scaffoldBackgroundColor, // Colors.transparent,
        isCollapsed: true,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFFC2C2C2)),
        contentPadding: widget.contentPadding ?? EdgeInsets.symmetric(horizontal: 20.sp, vertical: 18.sp),
        prefixIcon: widget.prefixIcon != null
            ? InkWell(
                overlayColor: WidgetStateProperty.all(Theme.of(context).brightness == Brightness.dark ? null : Colors.white),
                onTap: widget.prefixOnTap,
                child: DefaultTextStyle(style: textFormFieldStyle, child: widget.prefixIcon!),
              )
            : null,
        suffixIcon: getSuffixIcon,
        enabledBorder: widget.enabledBorder ??
            OutlineInputBorder(
              borderRadius: filedBorderRadius,
              borderSide: BorderSide(color: widget.validation == false ? Theme.of(context).colorScheme.error : AppColors.lightGrey),
            ),
        border: widget.border ??
            OutlineInputBorder(
              borderRadius: filedBorderRadius,
              borderSide: const BorderSide(color: AppColors.lightGrey),
            ),
        focusedBorder: widget.focusedBorder ??
            OutlineInputBorder(
              borderRadius: filedBorderRadius,
              borderSide: BorderSide(
                color: widget.readOnly == true || (widget.textFieldType != TextFieldType.normal && widget.textFieldType != TextFieldType.search) ? AppColors.lightGrey : (Theme.of(context).primaryColor),
              ),
            ),
        focusedErrorBorder: widget.focusedErrorBorder ??
            OutlineInputBorder(
              borderRadius: filedBorderRadius,
              borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.4)),
            ),
        disabledBorder: widget.disabledBorder ??
            OutlineInputBorder(
              borderRadius: filedBorderRadius,
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
        errorBorder: widget.errorBorder ??
            OutlineInputBorder(
              borderRadius: filedBorderRadius,
              borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
            ),
      ),
    );
  }

  BorderRadius get filedBorderRadius {
    return BorderRadius.all(Radius.circular(defaultRadius));
  }

  TextStyle get textFormFieldStyle {
    return widget.style ?? AppTextStyle.textFieldStyle(context);
  }

  Widget? get getSuffixIcon {
    Widget? onTapWrapWidget({Widget? child}) {
      return Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.only(right: 5),
        child: Center(
          child: widget.suffixOnTap != null && child != null
              ? AppIconButton(
                  size: 50,
                  onPressed: widget.suffixOnTap!,
                  icon: child,
                )
              : child,
        ),
      );
    }

    switch (widget.textFieldType!) {
      case TextFieldType.normal:
        return onTapWrapWidget(
          child: widget.suffixIcon,
        );

      case TextFieldType.date:
        return onTapWrapWidget(
          child: widget.suffixIcon /*SvgPicture.asset(
                AppAssets.calenderIcon,
                color: isFieldActive ? Theme.of(context).primaryColor : null, // ignore: deprecated_member_use
              )*/
          ,
        );

      case TextFieldType.time:
        return onTapWrapWidget(
          child: widget.suffixIcon ?? const Icon(Icons.watch_later_outlined),
        );

      case TextFieldType.search:
        return onTapWrapWidget(
          child: widget.suffixIcon ??
              SvgPicture.asset(
                AppAssets.search,
                height: 24,
                width: 24,
                color: isFieldActive ? Theme.of(context).primaryColor : Colors.grey.shade400, // ignore: deprecated_member_use
              ),
        );
    }
  }

  bool get readOnly {
    if (widget.readOnly == null) {
      switch (widget.textFieldType) {
        case TextFieldType.normal:
          return widget.readOnly ?? false;
        case TextFieldType.date:
          return true;
        case TextFieldType.time:
          return true;
        default:
          return widget.readOnly ?? false;
      }
    } else {
      return widget.readOnly ?? false;
    }
  }

  VoidCallback? get onTap {
    selectedDate = widget.selectedDate ?? DateTime.now();
    switch (widget.textFieldType) {
      case TextFieldType.normal:
        return widget.onTap;
      case TextFieldType.date:
        if (widget.onTap == null) {
          return () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(1880),
              lastDate: DateTime.now(),
            );
            if (picked != null && picked != selectedDate) {
              selectedDate = picked;
              if (!isValEmpty(selectedDate)) {
                widget.onDateOrTimeChange != null ? widget.onDateOrTimeChange!(selectedDate) : null;
                removeListener();
              }
            }
          };
        } else {
          return widget.onTap;
        }

      case TextFieldType.time:
        if (widget.onTap == null) {
          printOkStatus("text");
          return () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: selectedTime,
              builder: (BuildContext context, Widget? child) {
                return
                    // Theme(
                    //   data: Theme.of(context).copyWith(
                    //     colorScheme: Theme.of(context).colorScheme.copyWith(
                    //           tertiary: Colors.purple,
                    //         ),
                    //   ),
                    //   child:
                    MediaQuery(
                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                  child: child!,
                  // ),
                );
              },
            );
            if (picked != null && picked != selectedTime) {
              selectedTime = picked;
              if (!isValEmpty(selectedTime)) {
                widget.onDateOrTimeChange != null ? widget.onDateOrTimeChange!(selectedTime) : null;
              }
            }
          };
        } else {
          return widget.onTap;
        }

      default:
        return widget.onTap;
    }
  }
}

/// [FieldTitleWidget] You can also use the widget globally in a way where you have created your own custom TextField
class FieldTitleWidget extends StatelessWidget {
  final BuildContext mainContext;
  final String title;
  final TextStyle? titleStyle;
  final bool? isFieldActive;
  final EdgeInsetsGeometry? padding;

  const FieldTitleWidget(
    this.mainContext, {
    super.key,
    required this.title,
    this.titleStyle,
    this.isFieldActive = false,
    this.padding,
  });

  @override
  Widget build(context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 150),
        style: titleStyle ??
            Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 13.5.sp,
                  fontFamily: AppTheme.fontFamilyName,
                  color: isFieldActive == true ? Theme.of(mainContext).primaryColor : Theme.of(context).textTheme.titleMedium?.color,
                ),
        child: Text(title),
      ),
    );
  }
}

/// [FieldErrorWidget] You can also use the widget globally in a way where you have created your own custom TextField
class FieldErrorWidget extends StatelessWidget {
  final double? errorHeight;
  final double? errorSpacing;
  final bool? validation;
  final String? errorMessage;
  final TextStyle? errorStyle;
  final BuildContext? mainContext;

  const FieldErrorWidget(
    this.mainContext, {
    super.key,
    this.errorHeight,
    this.errorSpacing,
    this.validation = true,
    required this.errorMessage,
    this.errorStyle,
  });

  @override
  Widget build(context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      tween: validation == false ? Tween(begin: 0.0, end: (errorHeight ?? 17) + (errorSpacing ?? 5)) : Tween(begin: 0.0, end: 0.0),
      builder: (context, value, child) {
        return Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(top: errorSpacing ?? 5, left: 10),
          height: value * 1,
          child: Text(
            errorMessage ?? "",
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: errorStyle ??
                TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        );
      },
    );
  }
}
