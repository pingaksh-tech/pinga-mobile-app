import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import '../../../../res/empty_element.dart';
import '../../../../widgets/product_tile.dart';
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
        return con.productsList.isNotEmpty
            ? ListView(
                children: [
                  /// PRODUCTS
                  Wrap(
                    children: List.generate(
                      con.productsList.length,
                      (index) => ProductTile(
                        inventoryId: con.productsList[index].inventory?.id ?? "",
                        productsListTypeType: ProductsListType.wishlist,
                        categorySlug: "ring",
                        productTileType: ProductTileType.grid,
                        onTap: () => Get.toNamed(AppRoutes.productDetailsScreen, arguments: {
                          "category": con.category.value.name ?? '',
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
              )
            : const EmptyElement(title: "Wishlist not available");
      }),
    );
  }
}
