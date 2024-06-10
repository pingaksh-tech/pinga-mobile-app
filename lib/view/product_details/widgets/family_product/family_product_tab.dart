import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../exports.dart';
import '../../../../widgets/product_tile.dart';
import 'family_product_controller.dart';

class FamilyProductTab extends StatelessWidget {
  FamilyProductTab({super.key});

  final FamilyProductController con = Get.put(FamilyProductController());

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const RangeMaintainingScrollPhysics(),
      padding: EdgeInsets.all(defaultPadding / 2).copyWith(top: 52, bottom: defaultPadding * 5),
      children: [
        Wrap(
          children: List.generate(
            2,
            (index) => ProductTile(
              productTileType: ProductTileType.grid,
              onTap: () {},
              categorySlug: "ring",
              isLike: false.obs,
              imageUrl: "https://kisna.com/cdn/shop/files/KFLR11133-Y-1_1800x1800.jpg?v=1715687553",
              productName: "PKSHUDN#&",
              productPrice: 32345.toString(),
              productQuantity: 0.obs,
              likeOnChanged: (value) {
                /// Add product to wishlist
                // if (!con.wishlistList.contains(con.productsList[index])) {
                //   con.wishlistList.add(con.productsList[index]);
                // } else {
                //   con.wishlistList.remove(con.productsList[index]);
                // }
                // printOkStatus(con.wishlistList);
              },
            ),
          ),
        ),
      ],
    );
  }
}
