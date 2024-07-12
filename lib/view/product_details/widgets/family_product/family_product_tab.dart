import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/model/product/products_model.dart';
import '../../../../exports.dart';
import '../../../../res/empty_element.dart';
import '../../../../widgets/product_tile.dart';
import 'family_product_controller.dart';

class FamilyProductTab extends StatelessWidget {
  final List<InventoryModel> productList;
  final String? category;

  FamilyProductTab({super.key, required this.productList, this.category});

  final FamilyProductController con = Get.put(FamilyProductController());

  @override
  Widget build(BuildContext context) {
    return productList.isNotEmpty
        ? ListView(
            physics: const RangeMaintainingScrollPhysics(),
            padding: EdgeInsets.all(defaultPadding / 2).copyWith(top: 52, bottom: defaultPadding * 5),
            children: [
              Wrap(
                children: List.generate(
                  productList.length,
                  (index) => Obx(
                    () => ProductTile(
                      category: (productList[index].subCategoryId ?? "").obs,
                      selectSize: (productList[index].sizeId ?? "").obs,
                      inventoryId: productList[index].id ?? "",
                      productTileType: ProductTileType.grid,
                      onTap: () {
                        printYellow(productList[index].id);
                        navigateToProductDetailsScreen(
                          productId: productList[index].id ?? "",
                          type: GlobalProductPrefixType.productDetails,
                          whenComplete: () {
                            // removeLastProductIdFromGlobalList();
                          },
                        );
                      },
                      isLike: productList[index].isWishlist,
                      imageUrl: productList[index].singleInvImage ?? "",
                      productName: productList[index].name ?? "",
                      productPrice: productList[index].inventoryTotalPrice.toString(),
                      productQuantity: productList[index].quantity,
                    ),
                  ),
                ),
              ),
            ],
          )
        : const Center(
            child: EmptyElement(title: "Family product not available"),
          );
  }
}
