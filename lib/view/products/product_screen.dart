import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../exports.dart';
import '../../res/app_bar.dart';
import '../../res/app_dialog.dart';
import '../../widgets/product_tile.dart';
import 'components/cart_icon_button.dart';
import 'components/sort_filter_button.dart';
import 'product_controller.dart';
import 'widgets/sort/sorting_bottomsheet.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  final ProductController con = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shadowColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
          title: con.categoryName.isNotEmpty ? con.categoryName.value : con.category.value.name,

          actions: const [
            CartIconButton(),
          ],

          /// SORTING AND FILTERS
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Row(
                children: [
                  SortAndFilterButton(
                    title: "Sort",
                    isFilterButton: false,
                    image: AppAssets.sortIcon,
                    iconSize: 16.5.sp,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => SortingBottomSheet(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                    child: const VerticalDivider(
                      thickness: 1.5,
                    ),
                  ),
                  SortAndFilterButton(
                    title: "Filter",
                    image: AppAssets.filter,
                    onTap: () => Get.toNamed(AppRoutes.filterScreen),
                  ),
                  SizedBox(
                    height: 20.h,
                    child: const VerticalDivider(
                      thickness: 1.5,
                    ),
                  ),
                  AppIconButton(
                    icon: SvgPicture.asset(
                      con.isProductViewChange.isFalse ? AppAssets.appIcon : AppAssets.listIcon,
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.55), // ignore: deprecated_member_use
                      height: 18.sp,
                    ),
                    onPressed: () {
                      con.isProductViewChange.value = !con.isProductViewChange.value;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2, vertical: defaultPadding).copyWith(top: 0, bottom: defaultPadding * 5),
          children: [
            Divider(
              height: 2.h,
              thickness: 1.5,
              indent: defaultPadding / 2,
              endIndent: defaultPadding / 2,
            ),
            Text(
              "Total Products 4150",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.subText),
              textAlign: TextAlign.center,
            ).paddingOnly(top: defaultPadding / 3),

            /// PRODUCTS
            Wrap(
              children: List.generate(
                con.productsList.length,
                (index) => ProductTile(
                  categorySlug: con.category.value.id ?? "ring" /*Product Category*/,
                  productTileType: con.isProductViewChange.isTrue ? ProductTileType.grid : ProductTileType.list,
                  onTap: () => Get.toNamed(AppRoutes.productDetailsScreen, arguments: {
                    "category": con.category.value.id ?? '',
                    'isSize': con.isSizeAvailable.value,
                  }),
                  isLike: (con.wishlistList.contains(con.productsList[index])).obs,
                  imageUrl: con.productsList[index].product?.productImage ?? "",
                  productName: con.productsList[index].product?.title ?? "",
                  productPrice: con.productsList[index].product?.price.toString() ?? "",
                  productQuantity: con.productsList[index].quantity,
                  isSizeAvailable: con.isSizeAvailable.value,
                  likeOnChanged: (value) {
                    /// Add product to wishlist
                    if (!con.wishlistList.contains(con.productsList[index])) {
                      con.wishlistList.add(con.productsList[index]);
                    } else {
                      con.wishlistList.remove(con.productsList[index]);
                    }
                    printOkStatus(con.wishlistList);
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: SvgPicture.asset(
            AppAssets.productDownload,
            height: 22.h,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.surface,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () {
            AppDialogs.productDownloadDialog(context);
          },
        ),
      ),
    );
  }
}
