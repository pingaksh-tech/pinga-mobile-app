import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
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
        return ListView(
          children: [
            /// PRODUCTS
            Wrap(
              children: List.generate(
                con.productsList.length,
                (index) => ProductTile(
                  categorySlug: con.category.value.slug ?? "ring" /*Product Category*/,
                  productTileType: ProductTileType.grid,
                  onTap: () => Get.toNamed(AppRoutes.productDetailsScreen, arguments: {
                    "category": con.category.value.slug ?? '',
                    // 'isSize': con.isSizeAvailable.value, /*if product does not have size*/
                  }),
                  isLike: true.obs,
                  imageUrl: con.productsList[index].product?.productImage ?? "",
                  productName: con.productsList[index].product?.title ?? "",
                  productPrice: con.productsList[index].product?.price.toString() ?? "",
                  productQuantity: con.productsList[index].quantity,
                  // isSizeAvailable: con.isSizeAvailable.value, /*if product does not have size*/
                  likeOnChanged: (value) {},
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
