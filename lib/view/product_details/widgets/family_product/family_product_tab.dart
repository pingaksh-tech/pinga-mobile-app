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
            padding: EdgeInsets.all(defaultPadding / 2)
                .copyWith(top: 52, bottom: defaultPadding * 5),
            children: [
              Wrap(
                children: List.generate(
                  productList.length,
                  (index) => Obx(
                    () => ProductTile(
                        category: (productList[index].subCategoryId ?? "").obs,
                        selectSize: productList[index].sizeId!.value.obs,
                        inventoryId: productList[index].id ?? "",
                        productTileType: ProductTileType.grid,
                        screenType: 'isFamilyProduct',
                        isFancy: productList[index].isDiamondMultiple ?? false,
                        onTap: () {
                          navigateToProductDetailsScreen(
                            productDetails: {
                              "productId": productList[index].id ?? "",
                              "diamondClarity":
                                  productList[index].isDiamondMultiple == false
                                      ? productList[index]
                                              .diamonds
                                              ?.first
                                              .diamondClarity
                                              ?.value ??
                                          ""
                                      : "",
                              "metalId": productList[index].metalId!.value,
                              "sizeId": productList[index].sizeId!.value,
                              "diamonds":
                                  productList[index].isDiamondMultiple == true
                                      ? productList[index].diamonds!
                                      : [],
                              "type": GlobalProductPrefixType.productDetails,
                            },
                            type: GlobalProductPrefixType.productDetails,
                            arguments: {
                              "category": /*AppStrings.cartIdPrefixSlug +*/
                                  (productList[index].subCategoryId ?? ''),
                              'isSize': !isValEmpty(productList[index].sizeId),
                              'isFancy':
                                  productList[index].isDiamondMultiple ?? false,
                              'inventoryId': /*AppStrings.productIdPrefixSlug +*/
                                  (productList[index].id ?? ""),
                              'name': productList[index].name,
                              "productsListTypeType": ProductsListType.normal,
                              // 'like': productList[index].isWishlist,
                              "sizeId": productList[index].sizeId!.value,
                              "remark": productList[index].remark!.value,
                              "quantity": productList[index].quantity!.value,

                              "diamondClarity":
                                  productList[index].isDiamondMultiple == false
                                      ? productList[index]
                                              .diamonds
                                              ?.first
                                              .diamondClarity
                                              ?.value ??
                                          ""
                                      : "",

                              "metalId": productList[index].metalId!.value,
                              "diamonds":
                                  productList[index].isDiamondMultiple == true
                                      ? productList[index].diamonds
                                      : [],
                            },
                            whenComplete: () {
                              // removeLastProductIdFromGlobalList();
                            },
                          );
                        },
                        diamondOnChanged: (value) {
                          printData(value: value);
                          productList[index]
                              .diamonds
                              ?.first
                              .diamondClarity
                              ?.value = value;
                        },
                        sizeOnChanged: (value) {
                          productList[index].sizeId!.value = value;
                        },
                        metalOnChanged: (value) {
                          productList[index].metalId!.value = value;
                        },
                        remarkOnChanged: (value) {
                          productList[index].remark!.value = value;
                        },
                        isLike: productList[index].isWishlist,
                        imageUrl: productList[index].singleInvImage ?? "",
                        productName: productList[index].name ?? "",
                        productPrice:
                            productList[index].inventoryTotalPrice.toString(),
                        productQuantity: productList[index].quantity,
                        selectDiamondCart:
                            (productList[index].diamonds != null &&
                                    productList[index].diamonds!.isNotEmpty)
                                ? (productList[index]
                                            .diamonds
                                            ?.first
                                            .diamondClarity
                                            ?.value ??
                                        "")
                                    .obs
                                : "".obs,
                        diamonds: productList[index].diamonds),
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
