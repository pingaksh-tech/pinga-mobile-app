import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/wishlist/wishlist_repository.dart';
import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import '../../../../res/empty_element.dart';
import '../../../../widgets/product_tile.dart';
import '../../../../widgets/pull_to_refresh_indicator.dart';
import '../../../products/components/cart_icon_button.dart';
import 'wishlist_controller.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({super.key});

  final WishlistController con = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    return PullToRefreshIndicator(
      onRefresh: () => WishlistRepository.getWishlistAPI(isPullToRefresh: true),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(
          title: "My Wishlist",
          actions: [
            CartIconButton(
              onPressed: () {},
            )
          ],
        ),
        body: Obx(
          () {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2)
                  .copyWith(bottom: defaultPadding),
              children: [
                /// PRODUCTS
                con.loader.isFalse
                    ? con.productsList.isNotEmpty
                        ? Wrap(
                            children: List.generate(
                              con.productsList.length,
                              (index) => Column(
                                children: [
                                  ProductTile(
                                    category: RxString(con.productsList[index]
                                            .inventory?.subCategoryId ??
                                        ""),
                                    inventoryId:
                                        con.productsList[index].inventory?.id ??
                                            "",
                                    productsListTypeType:
                                        ProductsListType.wishlist,
                                    selectSize: (con.productsList[index]
                                                .inventory?.sizeId ??
                                            "")
                                        .obs,
                                    productTileType: ProductTileType.grid,
                                    isFancy: con.productsList[index].inventory
                                            ?.isDiamondMultiple ??
                                        false,
                                    onTap: () => Get.toNamed(
                                      AppRoutes.productDetailsScreen,
                                      arguments: {
                                        "category": /*AppStrings.cartIdPrefixSlug +*/
                                            (con.productsList[index].inventory
                                                    ?.subCategoryId ??
                                                ''),
                                        'inventoryId': /*AppStrings.productIdPrefixSlug +*/
                                            (con.productsList[index].inventory
                                                    ?.id ??
                                                ""),
                                        'name': con.productsList[index]
                                                .inventory?.name ??
                                            "",
                                        "productsListTypeType":
                                            ProductsListType.wishlist
                                      },
                                    ),
                                    isLike: true.obs,
                                    diamondList: RxList(con.productsList[index]
                                            .inventory?.diamonds ??
                                        []),
                                    diamonds: con.productsList[index].inventory
                                            ?.diamonds ??
                                        [],
                                    imageUrl: con.productsList[index].inventory
                                            ?.singleInvImage ??
                                        "",
                                    productName: con.productsList[index]
                                            .inventory?.name ??
                                        "",
                                    productPrice: con.productsList[index]
                                            .inventory?.inventoryTotalPrice
                                            .toString() ??
                                        "",
                                    productQuantity: con.productsList[index]
                                        .inventory?.quantity,
                                    likeOnChanged: (value) {},
                                  ),
                                  if (con.paginationLoader.value &&
                                      index + 1 == con.productsList.length)
                                    productShimmer(context)
                                ],
                              ),
                            ),
                          )
                        : EmptyElement(
                            title: "Wishlist not available",
                            padding:
                                EdgeInsets.symmetric(vertical: Get.width / 2.5),
                          )
                    : productShimmer(context, length: 6),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget productShimmer(BuildContext context, {int length = 2}) {
    return Padding(
      padding: EdgeInsets.all(defaultPadding / 2),
      child: Wrap(
        spacing: defaultPadding,
        runSpacing: defaultPadding,
        direction: Axis.horizontal,
        children: List.generate(
          length,
          (index) => ShimmerUtils.productGridShimmer(context),
        ),
      ),
    );
  }
}
