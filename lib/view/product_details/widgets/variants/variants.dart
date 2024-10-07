import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../widgets/product_tile.dart';
import 'variants_tab_controller.dart';

class VariantsTab extends StatelessWidget {
  final String productCategory;
  final bool isSize;

  VariantsTab({super.key, required this.productCategory, this.isSize = true});

  final VariantsTabController con = Get.put(VariantsTabController());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 48, bottom: defaultPadding * 5),
      itemCount: con.variantList.length,
      itemBuilder: (context, index) => ProductTile(
        onTap: () => Get.toNamed(AppRoutes.productDetailsScreen,
            arguments: {
              "category": /* AppStrings.cartIdPrefixSlug +*/ productCategory,
              'isSize': isSize,
            },
            preventDuplicates: false),
        // subCategoryId: productCategory,
        isSizeAvailable: isSize,
        productTileType: ProductTileType.variant,
        imageUrl: con.variantList[index].image ?? "",
        productName: con.variantList[index].name ?? "",
        productPrice: con.variantList[index].price.toString(),
        productQuantity: con.variantList[index].quantity,
        screenType: "isVariantsTab",
      ),
    );
  }
}
