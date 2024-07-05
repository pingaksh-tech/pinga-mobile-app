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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        title: "My Wishlist",
        actions: const [CartIconButton()],
      ),
      body: Obx(() {
        return con.loader.isFalse
            ? con.productsList.isNotEmpty
                ? PullToRefreshIndicator(
                    onRefresh: () => WishlistRepository.getWishlistAPI(isPullToRefresh: true),
                    child: ListView(
                      children: [
                        /// PRODUCTS
                        Wrap(
                          children: List.generate(
                            con.productsList.length,
                            (index) => ProductTile(
                              category: RxString(con.productsList[index].inventory?.subCategoryId ?? ""),
                              inventoryId: con.productsList[index].inventory?.id ?? "",
                              productsListTypeType: ProductsListType.wishlist,
                              // category: con.productsList[index].inventory.subCategoryId ?? "",
                              selectSize: (con.productsList[index].inventory?.sizeId ?? "").obs,
                              productTileType: ProductTileType.grid,
                              onTap: () => Get.toNamed(AppRoutes.productDetailsScreen, arguments: {
                                "category": /* con.category.value.name ?? */ 'ring',
                                // 'isSize': con.isSizeAvailable.value,
                                // 'isFancy': con.isFancyDiamond.value,
                                'inventoryId': con.productsList[index].inventory?.id ?? "",
                                'name': con.productsList[index].inventory?.name ?? "",
                              }),
                              isLike: true.obs,
                              imageUrl: con.productsList[index].inventory?.singleInvImage ?? "",
                              productName: con.productsList[index].inventory?.name ?? "",
                              productPrice: con.productsList[index].inventory?.inventoryTotalPrice.toString() ?? "",
                              productQuantity: con.productsList[index].inventory?.quantity,
                              // isSizeAvailable: con.isSizeAvailable.value, /*if product does not have size*/
                              likeOnChanged: (value) {},
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const EmptyElement(title: "Wishlist not available")
            : ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(defaultPadding),
                children: [
                  Wrap(
                    spacing: defaultPadding,
                    runSpacing: defaultPadding,
                    direction: Axis.horizontal,
                    children: List.generate(
                      6,
                      (index) => ShimmerUtils.productsListShimmer(context),
                    ),
                  ),
                ],
              );
      }),
    );
  }
}
