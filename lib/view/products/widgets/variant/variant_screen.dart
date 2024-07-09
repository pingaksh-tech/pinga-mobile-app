import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import '../../../../widgets/product_tile.dart';
import '../../components/cart_icon_button.dart';
import 'variant_controller.dart';

class VariantScreen extends StatelessWidget {
  VariantScreen({super.key});

  final VariantController con = Get.put(VariantController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        title: "Variants",
        actions:  [CartIconButton(onPressed: () {
          
        },)],
      ),
      body: Obx(() {
        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: defaultPadding).copyWith(top: 0),
          itemCount: con.variantList.length,
          itemBuilder: (context, index) => ProductTile(
            onTap: () => Get.toNamed(AppRoutes.productDetailsScreen, arguments: {
              "category": con.category.value,
              'isSize': con.isSize.value,
            }),
            // subCategoryId: con.category.value,
            isSizeAvailable: con.isSize.value,
            productTileType: ProductTileType.variant,
            imageUrl: con.variantList[index].image ?? "",
            productName: con.variantList[index].name ?? "",
            productPrice: con.variantList[index].price.toString(),
            productQuantity: con.variantList[index].quantity,
          ),
        );
      }),
    );
  }
}
