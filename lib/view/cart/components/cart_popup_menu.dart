import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/repositories/cart/cart_repository.dart';
import '../../../exports.dart';
import '../../../res/app_dialog.dart';
import '../../../res/pop_up_menu_button.dart';
import '../cart_controller.dart';

// ignore: must_be_immutable
class CartPopUpMenu extends StatelessWidget {
  CartPopUpMenu({super.key});

  CartController con = Get.find<CartController>();
  Rx<TextEditingController> nameCon = TextEditingController().obs;

  RxBool nameValidation = true.obs;
  RxString nameError = ''.obs;
  bool validation() {
    if (nameCon.value.text.trim().isEmpty) {
      nameError.value = "Please enter watchList name";
      nameValidation.value = false;
    } else {
      nameValidation.value = true;
    }
    return nameValidation.isTrue;
  }

  @override
  Widget build(BuildContext context) {
    return AppPopUpMenuButton(
      position: PopupMenuPosition.over,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 15.sp),
      menuList: const [
        "Download cart items",
        "Add to watchList",
        "Clear cart",
      ],
      child: Icon(
        Icons.more_vert_rounded,
        color: Theme.of(context).primaryColor,
      ).paddingOnly(right: defaultPadding / 5),
      onSelect: (value) {
        switch (value) {
          case "download cart items":
            break;
          case "add to watchlist":
            AppDialogs.cartDialog(
              context,
              buttonTitle2: "ADD",
              dialogTitle: "Add to watchList",
              buttonTitle: "CANCEL",
              content: SizedBox(
                width: Get.width,
                child: Obx(
                  () => AppTextField(
                    controller: nameCon.value,
                    title: "Add WatchList Name",
                    validation: nameValidation.value,
                    errorMessage: nameError.value,
                    errorStyle: const TextStyle(color: Colors.red),
                    titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 12.sp,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    padding: EdgeInsets.only(top: defaultPadding / 2),
                    hintText: "Enter new watchList Name",
                    contentPadding: EdgeInsets.symmetric(
                      vertical: defaultPadding / 1.4,
                      horizontal: defaultPadding / 1.7,
                    ),
                    onChanged: (value) {
                      nameValidation.value = true;
                    },
                  ),
                ),
              ),
              onPressed: () {
                if (validation()) {
                  Get.back();
                  AppDialogs.cartAlertDialog(
                    context,
                    isCancelButtonShow: true,
                    contentText: "Do you want to empty cart after items are added in watchList",
                    onPressed: () {},
                  );
                }
              },
            );
            break;
          case "clear cart":
            AppDialogs.cartDialog(
              context,
              contentText: "Are you sure,\nyou want to clear cart?",
              dialogTitle: "Alert",
              buttonTitle2: "YES",
              buttonTitle: "NO",
              onPressed: () {
                Get.back();
                CartRepository.deleteCartAPi(isLoader: con.cartLoader);
              },
            );
            break;
          default:
        }
      },
    );
  }
}
