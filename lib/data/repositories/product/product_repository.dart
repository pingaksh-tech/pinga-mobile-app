import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../controller/predefine_value_controller.dart';
import '../../../exports.dart';
import '../../../view/drawer/widgets/wishlist/wishlist_controller.dart';
import '../../../view/product_details/product_details_controller.dart';
import '../../../view/product_details/widgets/variants/variants_tab_controller.dart';
import '../../../view/products/products_controller.dart';
import '../../../view/products/widgets/variant/variant_controller.dart';
import '../../model/product/product_price_model.dart';
import '../../model/product/products_model.dart';
import '../../model/product/single_product_model.dart';
import '../../model/product/variant_product_model.dart';
import '../../model/watchlist/single_watchlist_model.dart';

class ProductRepository {
  /// ***********************************************************************************
  ///                                       PRODUCT VARIANT LIST
  /// ***********************************************************************************
  static Map<String, dynamic> variantList = {
    "success": true,
    "message": "variants fetched successfully",
    "data": {
      "products": [
        {
          "id": "p1",
          "image":
              "https://media.istockphoto.com/id/1651974076/photo/golden-wedding-rings-on-trendy-white-podium-aesthetic-still-life-art-photography.webp?b=1&s=170667a&w=0&k=20&c=JYqzNrZjGH5c4OxWrjhvebI5_6rBCJ9JRZPe9cj_-rM=",
          "name": "Solitaire Ring",
          "price": 2344,
          "color_id": "P",
          "size_id": "50",
          "quantity": 0,
          "diamond": "ds"
        },
        {
          "id": "p2",
          "image":
              "https://media.istockphoto.com/id/1651942696/photo/diamond-ring-isolated-on-white-background.webp?b=1&s=170667a&w=0&k=20&c=sOaX2vYuPtkuJce37Umflp_Vwn-F4cd7ryx0ltEexsE=",
          "name": "Diamond Necklace",
          "price": 3999,
          "color_id": "BK",
          "size_id": "14",
          "quantity": 0,
          "diamond": "ds"
        },
        {
          "id": "p3",
          "image":
              "https://media.istockphoto.com/id/1651974076/photo/golden-wedding-rings-on-trendy-white-podium-aesthetic-still-life-art-photography.webp?b=1&s=170667a&w=0&k=20&c=JYqzNrZjGH5c4OxWrjhvebI5_6rBCJ9JRZPe9cj_-rM=",
          "name": "Gold Bracelet",
          "price": 799,
          "color_id": "C",
          "size_id": "17",
          "quantity": 0,
          "diamond": "ds"
        },
        {
          "id": "p4",
          "image":
              "https://media.istockphoto.com/id/1318401740/photo/indian-gold-jewellery-stock-photo.webp?b=1&s=170667a&w=0&k=20&c=xbkn3_S5igjnfBDOHkuGCfg4BmGj8U2djQSvdDuccC8=",
          "name": "Silver Earrings",
          "price": 299,
          "color_id": "D",
          "size_id": "32",
          "quantity": 0,
          "diamond": "ds"
        },
        {
          "id": "p5",
          "image":
              "https://media.istockphoto.com/id/1651974076/photo/golden-wedding-rings-on-trendy-white-podium-aesthetic-still-life-art-photography.webp?b=1&s=170667a&w=0&k=20&c=JYqzNrZjGH5c4OxWrjhvebI5_6rBCJ9JRZPe9cj_-rM=",
          "name": "Platinum Band",
          "price": 1799,
          "color_id": "T",
          "size_id": "45",
          "quantity": 0,
          "diamond": "ds"
        },
        {
          "id": "p6",
          "image":
              "https://media.istockphoto.com/id/1318401740/photo/indian-gold-jewellery-stock-photo.webp?b=1&s=170667a&w=0&k=20&c=xbkn3_S5igjnfBDOHkuGCfg4BmGj8U2djQSvdDuccC8=",
          "name": "Emerald Bracelet",
          "price": 899,
          "color_id": "R",
          "size_id": "22",
          "quantity": 0,
          "diamond": "ds"
        },
        {
          "id": "p7",
          "image":
              "https://media.istockphoto.com/id/1318401740/photo/indian-gold-jewellery-stock-photo.webp?b=1&s=170667a&w=0&k=20&c=xbkn3_S5igjnfBDOHkuGCfg4BmGj8U2djQSvdDuccC8=",
          "name": "Pearl Necklace",
          "price": 599,
          "color_id": "W",
          "size_id": "27",
          "quantity": 0,
          "diamond": "ds"
        },
      ],
    }
  };

  /// ***********************************************************************************
  ///                                     GET PRODUCTS LIST
  /// ***********************************************************************************

  static Future<void> getFilterProductsListAPI({
    String? watchListId,
    required ProductsListType productsListType,
    required String categoryId,
    required String subCategoryId,
    List<String>? sortBy,
    double? minMetal,
    double? maxMetal,
    double? minDiamond,
    double? maxDiamond,
    bool? inStock,
    int? minMrp,
    int? maxMrp,
    List<dynamic>? genderList,
    List<dynamic>? diamondList,
    List<dynamic>? ktList,
    List<dynamic>? deliveryList,
    List<dynamic>? productionNameList,
    List<dynamic>? collectionList,
    bool isInitial = true,
    bool isPullToRefresh = false,
    RxBool? loader,
  }) async {
    final ProductsController con = Get.find<ProductsController>();

    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        if (isInitial) {
          if (!isPullToRefresh) {
            con.inventoryProductList.clear();
          }
          con.page.value = 1;
          con.nextPageAvailable.value;
        }

        /// API
        await APIFunction.postApiCall(
          apiUrl: productsListType == ProductsListType.normal
              ? ApiUrls.getAllProductsPOST
              : ApiUrls.getSingleWatchListAPI(watchListId: watchListId ?? ""),
          body: {
            if (!isValEmpty(categoryId)) "category_id": categoryId,
            if (!isValEmpty(subCategoryId)) "sub_category_id": subCategoryId,
            "page": con.page.value.toString(),
            "limit": con.itemLimit.value.toString(),
            if (!isValEmpty(sortBy)) "sortBy": sortBy,
            if ((!isValEmpty(minMetal) && !isValEmpty(maxMetal)))
              "range": {
                if ((!isValEmpty(minMetal) && !isValEmpty(maxMetal)))
                  "metal_wt": {"min": minMetal, "max": maxMetal},
                if ((!isValEmpty(minDiamond) && !isValEmpty(maxDiamond)))
                  "diamond_wt": {"min": minDiamond, "max": maxDiamond}
              },
            if ((!isValEmpty(minMrp) && !isValEmpty(maxMrp)))
              "mrp": {"min": minMrp, "max": maxMrp},
            if (inStock != null)
              "available": {
                "in_stock": inStock,
              },
            if (genderList != null && genderList.isNotEmpty)
              "gender": genderList,
            if (diamondList != null && diamondList.isNotEmpty)
              "diamond": diamondList,
            if (ktList != null && ktList.isNotEmpty) "metal_ids": ktList,
            if (deliveryList != null && deliveryList.isNotEmpty)
              "delivery": deliveryList,
            if (productionNameList != null && productionNameList.isNotEmpty)
              "production_name": productionNameList,
            if (collectionList != null && collectionList.isNotEmpty)
              "collection": collectionList,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              if (productsListType == ProductsListType.normal) {
                GetProductsModel model = GetProductsModel.fromJson(response);

                if (model.data != null) {
                  if (isPullToRefresh) {
                    con.inventoryProductList.value =
                        model.data?.inventories ?? [];
                  } else {
                    con.inventoryProductList
                        .addAll(model.data?.inventories ?? []);
                  }

                  int currentPage = (model.data!.page ?? 1);
                  con.nextPageAvailable.value =
                      currentPage < (model.data!.totalPages ?? 0);
                  con.page.value += currentPage;
                }
              } else {
                GetSingleWatchlistModel model =
                    GetSingleWatchlistModel.fromJson(response);

                if (model.data != null) {
                  if (isPullToRefresh) {
                    con.inventoryProductList.value =
                        model.data?.inventories ?? [];
                  } else {
                    con.inventoryProductList
                        .addAll(model.data?.inventories ?? []);
                  }

                  int currentPage = (model.data!.page ?? 1);
                  con.nextPageAvailable.value =
                      currentPage < (model.data!.totalPages ?? 0);
                  con.page.value += currentPage;
                }
              }
              loader?.value = false;
            } else {
              loader?.value = false;
            }

            return response;
          },
        );
      } catch (e) {
        loader?.value = false;
        printErrors(type: "getProductsListAPI", errText: e);
      }
    } else {}
  }

  /// ***********************************************************************************
  ///                                     GET PRODUCTS PRICE
  /// ***********************************************************************************

  static Future<GetProductPriceModel?> getProductPriceAPI({
    ProductsListType? productListType,
    required String inventoryId,
    required String metalId,
    String? sizeId,
    String? diamondClarity,
    List<Map<String, dynamic>>? diamonds,
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        /// API
        return await APIFunction.postApiCall(
          apiUrl: ApiUrls.getProductPricePOST,
          body: {
            "inventory_id": inventoryId,
            "metal_id": metalId,
            if (!isValEmpty(sizeId)) "size_id": sizeId,
            if (!isValEmpty(diamondClarity)) "diamond_clarity": diamondClarity,
            if (diamonds != null && diamonds.isNotEmpty) "diamonds": diamonds,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetProductPriceModel model =
                  GetProductPriceModel.fromJson(response);

              if (model.data != null) {
                switch (productListType) {
                  case ProductsListType.normal:
                    final ProductsController con =
                        Get.find<ProductsController>();
                    int index = con.inventoryProductList
                        .indexWhere((element) => element.id == inventoryId);
                    if (index != -1) {
                      con.inventoryProductList[index].inventoryTotalPrice
                          ?.value = model.data?.inventoryTotalPrice?.value ?? 0;
                      con.inventoryProductList[index].quantity?.value =
                          model.data?.cartQty?.quantity ?? 0;

                      printOkStatus(
                          con.inventoryProductList[index].quantity?.value);
                    }
                    break;

                  case ProductsListType.wishlist:
                    final WishlistController con =
                        Get.find<WishlistController>();
                    int index = con.productsList.indexWhere(
                        (element) => element.inventoryId == inventoryId);
                    if (index != -1) {
                      con.productsList[index].inventory?.inventoryTotalPrice
                          ?.value = model.data?.inventoryTotalPrice?.value ?? 0;
                      con.productsList[index].inventory?.quantity?.value =
                          model.data?.cartQty?.quantity ?? 0;
                    }
                    break;

                  case ProductsListType.watchlist:
                    break;

                  case ProductsListType.cart:
                    break;
                  default:
                    break;
                }

                /// Price Breaking value store in product detail
                if (Get.isRegistered<ProductDetailsController>()) {
                  final ProductDetailsController con =
                      Get.find<ProductDetailsController>();
                  con.productDetailModel.value.priceBreaking?.total?.value =
                      model.data?.inventoryTotalPrice?.value ?? 0;
                  con.productDetailModel.value.priceBreaking?.metal
                          ?.metalPrice =
                      model.data?.priceBreaking?.metal?.metalPrice ?? 0;
                  con.productDetailModel.value.priceBreaking?.metal
                          ?.pricePerGram =
                      model.data?.priceBreaking?.metal?.pricePerGram ?? 0;
                  con.productDetailModel.value.priceBreaking?.metal
                          ?.metalWeight =
                      model.data?.priceBreaking?.metal?.metalWeight ?? 0;
                  con.productDetailModel.value.priceBreaking?.diamond
                          ?.diamondWeight =
                      model.data?.priceBreaking?.diamond?.diamondWeight ?? 0;
                  con.productDetailModel.value.priceBreaking?.diamond
                          ?.diamondPrice =
                      model.data?.priceBreaking?.diamond?.diamondPrice ?? 0;
                  con.productDetailModel.value.priceBreaking?.other
                          ?.manufacturingPrice =
                      model.data?.priceBreaking?.other?.manufacturingPrice ?? 0;
                  if (con.productDetailModel.value.familyProducts != null) {
                    int index = con.productDetailModel.value.familyProducts!
                        .indexWhere((element) => element.id == inventoryId);
                    if (index != -1) {
                      con
                          .productDetailModel
                          .value
                          .familyProducts![index]
                          .inventoryTotalPrice
                          ?.value = model.data?.inventoryTotalPrice?.value ?? 0;
                      con.productDetailModel.value.familyProducts![index]
                          .quantity?.value = model.data?.cartQty?.quantity ?? 0;
                    }
                  }
                }
              }

              loader?.value = false;
              return model;
            } else {
              loader?.value = false;
              return response;
            }
          },
        );
      } catch (e) {
        loader?.value = false;
        printErrors(type: "getProductPriceAPI", errText: e);
      }
    } else {}
    return null;
  }

  /// ***********************************************************************************
  ///                                 GET PRODUCT DETAIL
  /// ***********************************************************************************

  static Future<dynamic> getSingleProductAPI(
      {RxBool? loader,
      required String inventoryId,
      required String sizeId,
      required String metalId,
      required String diamondClarity}) async {
    ///
    if (await getConnectivityResult() &&
        isRegistered<ProductDetailsController>()) {
      final ProductDetailsController con = Get.find<ProductDetailsController>();

      try {
        loader?.value = true;
        if (kDebugMode) {
          print(
            {
              "inventory_id": inventoryId,
              "metal_id": metalId, // Platinum Metal
              "diamond_clarity": diamondClarity,
              "size_id": sizeId
            },
          );
        }

        /// API
        await APIFunction.postApiCall(
          apiUrl: ApiUrls.getSingleProductDetailPOST,
          body: {
            "inventory_id": inventoryId,
            "metal_id": metalId, // Platinum Metal
            "diamond_clarity": diamondClarity,
            "size_id": sizeId
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetSingleProductModel model =
                  GetSingleProductModel.fromJson(response);

              if (model.data != null) {
                con.productDetailModel.value = model.data!;
                // con.isSizeAvailable.value = con.productDetailModel.value.sizeId != null;
                con.inventoryId.value =
                    con.productDetailModel.value.inventoryId ?? "";

                con.productDetailModel.value.cartQuantity = con.quantity.value;
                // con.isFancy=con.productDetailModel.value.productInfo.

                // productsController.inventoryProductList.value
              }
              loader?.value = false;
            } else {
              loader?.value = false;
            }
            return response;
          },
        );
      } catch (e) {
        loader?.value = false;
        printErrors(type: "getSingleProductAPI", errText: e);
      }
    } else {}
  }
  // static Future<dynamic> getSingleProductAPI({RxBool? loader, required String inventoryId}) async {
  //   ///
  //   if (await getConnectivityResult() && isRegistered<ProductDetailsController>()) {
  //     final ProductDetailsController con = Get.find<ProductDetailsController>();

  //     try {
  //       loader?.value = true;

  //       /// API
  //       await APIFunction.getApiCall(
  //         apiUrl: ApiUrls.getSingleProductDetailGET(inventoryId: inventoryId),
  //         loader: loader,
  //       ).then(
  //         (response) async {
  //           if (response != null) {
  //             GetSingleProductModel model = GetSingleProductModel.fromJson(response);

  //             if (model.data != null) {
  //               con.productDetailModel.value = model.data!;
  //               // con.isSizeAvailable.value = con.productDetailModel.value.sizeId != null;
  //               con.inventoryId.value = con.productDetailModel.value.inventoryId ?? "";
  //               // con.isFancy=con.productDetailModel.value.productInfo.

  //               // productsController.inventoryProductList.value
  //             }
  //             loader?.value = false;
  //           } else {
  //             loader?.value = false;
  //           }
  //           return response;
  //         },
  //       );
  //     } catch (e) {
  //       loader?.value = false;
  //       printErrors(type: "getSingleProductAPI", errText: e);
  //     }
  //   } else {}
  // }

  /// ***********************************************************************************
  ///                                       GET PRODUCT VARIANT
  /// ***********************************************************************************
  static Future<void> getProductVariantAPI(
      {RxBool? isLoader, isProductFlow = false}) async {
    if (isProductFlow) {
      final VariantController variantsCon = Get.find<VariantController>();
      GetVariantProductModel model =
          GetVariantProductModel.fromJson(variantList /*response*/);
      variantsCon.variantList.value = model.data?.products ?? [];
    } else {
      final VariantsTabController variantsTabCon =
          Get.find<VariantsTabController>();
      GetVariantProductModel model =
          GetVariantProductModel.fromJson(variantList /*response*/);
      variantsTabCon.variantList.value = model.data?.products ?? [];
    }
  }

  static Future<dynamic> getPredefineValueAPI() async {
    final PreDefinedValueController preValueCon =
        Get.find<PreDefinedValueController>();
    preValueCon.predefineResponse.value = {
      "success": true,
      "message": "predefined fetched successfully",
      "data": {
        "ring": {
          "diamond": [
            {"id": "VVS-EF", "value": "VVS-EF", "label": "VVS-EF"},
            {"id": "VS-SI-GH", "value": "VS-SI-GH", "label": "VS-SI-GH"},
            {"id": "VS-SI-HI", "value": "VS-SI-HI", "label": "VS-SI-HI"},
            {"id": "SI-HI", "value": "SI-HI", "label": "SI-HI"},
          ],
          "colors": [
            {"id": "Y", "value": "Y", "label": "Y (Yellow)"},
            {"id": "W", "value": "W", "label": "W (White)"},
            {"id": "P", "value": "P", "label": "P (Pink)"}
          ],
          "size": [
            {"id": "4", "value": "4", "label": "4 (S4 | CP-6 | P-04)"},
            {"id": "4.5", "value": "4.5", "label": "4.5 (S4.5 CP-7 | P-05)"},
            {"id": "5", "value": "5", "label": "5 (S5 P-5)"},
            {"id": "5.5", "value": "5.5", "label": "5.5 (S5.5 | P-5)"},
            {
              "id": "6",
              "value": "6",
              "label": "6 (S6 | CP-8 | P-6 | 45.9 (mm))"
            },
            {"id": "6.5", "value": "6.5", "label": "6.5 (S6.5 | P-6.5)"},
            {
              "id": "7",
              "value": "7",
              "label": "7 (S7 CP-9 | P-6.5 | 47.1 (mm))"
            },
            {"id": "7.5", "value": "7.5", "label": "7.5 (S7.5 P-7)"},
            {
              "id": "8",
              "value": "8",
              "label": "8 (S8 CP-10 | P-7.5 48.1 (mm))"
            },
            {"id": "8.5", "value": "8.5", "label": "8.5 (S8.5 | P-8)"},
            {
              "id": "9",
              "value": "9",
              "label": "9 (S9 CP-11 | P-8.5 | 49.0 (mm))"
            },
            {"id": "9.5", "value": "9.5", "label": "9.5 (S9.5 | P-9)"},
            {
              "id": "10",
              "value": "10",
              "label": "10 (S10 | CP-12 | P-9.5 | 50.0 (mm))"
            },
            {
              "id": "10.5",
              "value": "10.5",
              "label": "10.5 (S10.5 | CP-12 | P-10)"
            },
            {
              "id": "11",
              "value": "11",
              "label": "11 (S11 CP-13 | P-10 | 50.9 (mm))"
            },
            {"id": "11.5", "value": "11.5", "label": "11.5 (S11.5 | P10.5)"},
            {
              "id": "12",
              "value": "12",
              "label": "12 (S12 | CP-14 | P-10.5 | 51.8 (mm))"
            },
            {"id": "12.5", "value": "12.5", "label": "12.5 (S12.5 P-11)"},
            {
              "id": "13",
              "value": "13",
              "label": "13 (S13 CP-15 | P11.5 | 52.8 (mm))"
            },
            {"id": "13.5", "value": "13.5", "label": "13.5 (S13.5 P-12)"},
            {
              "id": "14",
              "value": "14",
              "label": "14 (S14 | CP-16 | P12.5 | 54.0 (mm))"
            },
            {"id": "14.5", "value": "14.5", "label": "14.5 (S14.5 P-13)"},
            {
              "id": "15",
              "value": "15",
              "label": "15 (S15 CP-17 | P13.5 | 55.0 (mm))"
            },
            {"id": "15.5", "value": "15.5", "label": "15.5 (S15.5 P-14)"},
            {
              "id": "16",
              "value": "16",
              "label": "16 (S16 | CP-18 | P14.5 | 55.9 (mm))"
            },
            {"id": "16.5", "value": "16.5", "label": "16.5 (S16.5 | P-15)"},
            {
              "id": "17",
              "value": "17",
              "label": "17 (S17 CP-19 | P15.5 | 56.9 (mm))"
            },
            {"id": "17.5", "value": "17.5", "label": "17.5 (S17.5 P-16)"},
            {
              "id": "18",
              "value": "18",
              "label": "18 (S18 | CP-20 | P16.5 | 57.8 (mm))"
            },
            {"id": "18.5", "value": "18.5", "label": "18.5 (S18.5 | P-17)"},
            {
              "id": "19",
              "value": "19",
              "label": "19 (S19 CP-21 | P17.5 | 59.1 (mm))"
            },
            {"id": "19.5", "value": "19.5", "label": "19.5 (S19.5 | P-18)"},
            {
              "id": "20",
              "value": "20",
              "label": "20 (S20 | CP-22 | P18.5 | 60.0 (mm))"
            },
            {"id": "20.5", "value": "20.5", "label": "20.5 (S20.5 | P-19)"},
            {
              "id": "21",
              "value": "21",
              "label": "21 (S21 CP-22.5 | P-19.5 | 60.9 (mm))"
            },
            {"id": "21.5", "value": "21.5", "label": "21.5 (S21.5 | P-20)"},
            {
              "id": "22",
              "value": "22",
              "label": "22 (S22 | CP-23 | P20.5 | 61.9 (mm))"
            },
            {
              "id": "22.5",
              "value": "22.5",
              "label": "22.5 (S22.5 | S-24 | P-20.5)"
            },
            {
              "id": "23",
              "value": "23",
              "label": "23 (S23 | CP-24 | P-20.5 | 62.8 (mm))"
            },
            {"id": "23.5", "value": "23.5", "label": "23.5 (S23.5 | P-21)"},
            {
              "id": "24",
              "value": "24",
              "label": "24 (S24 CP-25 | P21.5 63.8 (mm))"
            },
            {"id": "24.5", "value": "24.5", "label": "24.5 (S24.5 | P-22)"},
            {
              "id": "25",
              "value": "25",
              "label": "25 (S25 CP-26 | P22.5 | 64.7 (mm))"
            },
            {"id": "25.5", "value": "25.5", "label": "25.5 (S25.5 | P-23)"},
            {
              "id": "26",
              "value": "26",
              "label": "26 (S26 | CP-27 | P23.5 | 66.0 (mm))"
            },
            {"id": "26.5", "value": "26.5", "label": "26.5 (S26.5 | P-24)"},
            {
              "id": "27",
              "value": "27",
              "label": "27 (S27 CP-27.5 | P-24.5 | 66.9 (mm))"
            },
            {"id": "27.5", "value": "27.5", "label": "27.5 (S27.5 | P-25)"},
            {
              "id": "28",
              "value": "28",
              "label": "28 (S28 | CP-28 | P-25.5 | 67.9 (mm))"
            },
            {
              "id": "28.5",
              "value": "28.5",
              "label": "28.5 (S28.5 | CP-29 | P-26)"
            },
            {
              "id": "29",
              "value": "29",
              "label": "29 (S29 | CP-30 | P-26.5 | 69.1 (mm))"
            },
            {"id": "29.5", "value": "29.5", "label": "29.5 (S29.5 | P-27)"},
            {
              "id": "30",
              "value": "30",
              "label": "30 (S30 | CP-30.5 | P-27.5 | 70.1 (mm))"
            },
            {"id": "31", "value": "31", "label": "31 (S31)"},
            {"id": "32", "value": "32", "label": "32 (S32)"},
            {"id": "33", "value": "33", "label": "33 (S33)"}
          ],
        },
        "ear_ring": {
          "diamond": [
            {"id": "VVS-EF", "value": "VVS-EF", "label": "VVS-EF"},
            {"id": "VS-SI-GH", "value": "VS-SI-GH", "label": "VS-SI-GH"},
            {"id": "VS-SI-HI", "value": "VS-SI-HI", "label": "VS-SI-HI"},
            {"id": "SI-HI", "value": "SI-HI", "label": "SI-HI"},
          ],
          "colors": [
            {"id": "Y", "value": "Y", "label": "Y (Yellow)"},
            {"id": "W", "value": "W", "label": "W (White)"},
            {"id": "P", "value": "P", "label": "P (Pink)"}
          ],
          "size": [
            {"id": "RS", "value": "RS", "label": "RS (RS | Regular Screw)"},
            {"id": "SS", "value": "SS", "label": "SS (SS | South Screw)"}
          ],
        },
        "bangles": {
          "diamond": [
            {"id": "VVS-EF", "value": "VVS-EF", "label": "VVS-EF"},
            {"id": "VS-SI-GH", "value": "VS-SI-GH", "label": "VS-SI-GH"},
            {"id": "VS-SI-HI", "value": "VS-SI-HI", "label": "VS-SI-HI"},
            {"id": "SI-HI", "value": "SI-HI", "label": "SI-HI"},
          ],
          "colors": [
            {"id": "Y", "value": "Y", "label": "Y (Yellow)"},
            {"id": "W", "value": "W", "label": "W (White)"},
            {"id": "P", "value": "P", "label": "P (Pink)"}
          ],
          "size": [
            {
              "id": "2.0",
              "value": "2.0",
              "label": "2.0 (B2 | 50.8 (mm) Bangle Size - Diameter)"
            },
            {
              "id": "2.1",
              "value": "2.1",
              "label": "2.1 (B2.1 | 52.4 (mm) Bangle Size - Diameter)"
            },
            {
              "id": "2.2",
              "value": "2.2",
              "label": "2.2 (B2.2 | 54.0 (mm) Bangle Size - Diameter)"
            },
            {
              "id": "2.3",
              "value": "2.3",
              "label": "2.3 (B2.3 | 55.6 (mm) Bangle Size - Diameter)"
            },
            {
              "id": "2.4",
              "value": "2.4",
              "label": "2.4 (B2.4 | 57.2 (mm) Bangle Size - Diameter)"
            },
            {
              "id": "2.5",
              "value": "2.5",
              "label": "2.5 (B2.5 | 58.7 (mm) Bangle Size - Diameter)"
            },
            {
              "id": "2.6",
              "value": "2.6",
              "label": "2.6 (B2.6 | 60.3 (mm) Bangle Size - Diameter)"
            },
            {
              "id": "2.7",
              "value": "2.7",
              "label": "2.7 (B2.7 | 61.9 (mm) Bangle Size - Diameter)"
            },
            {
              "id": "2.8",
              "value": "2.8",
              "label": "2.8 (B2.8 | 63.5 (mm) Bangle Size - Diameter)"
            },
            {
              "id": "2.9",
              "value": "2.9",
              "label": "2.9 (B2.9 | 65.1 (mm) Bangle Size - Diameter)"
            }
          ],
        },
        "nose_pin": {
          "diamond": [
            {"id": "VVS-EF", "value": "VVS-EF", "label": "VVS-EF"},
            {"id": "VS-SI-GH", "value": "VS-SI-GH", "label": "VS-SI-GH"},
            {"id": "VS-SI-HI", "value": "VS-SI-HI", "label": "VS-SI-HI"},
            {"id": "SI-HI", "value": "SI-HI", "label": "SI-HI"},
          ],
          "colors": [
            {"id": "Y", "value": "Y", "label": "Y (Yellow)"},
            {"id": "W", "value": "W", "label": "W (White)"},
            {"id": "P", "value": "P", "label": "P (Pink)"}
          ],
          "size": [
            {"id": "RS", "value": "RS", "label": "RS (RS | Regular Screw)"},
            {
              "id": "RSWB",
              "value": "RSWB",
              "label": "RSWB (RSWB | Regular Screw - WB)"
            },
            {
              "id": "RSWB6",
              "value": "RSWB6",
              "label": "RSWB6 (RSWB6 | Regular Screw - WB 6.0 (mm))"
            },
            {"id": "SS", "value": "SS", "label": "SS (SS South Screw)"},
            {
              "id": "SSWB6",
              "value": "SSWB6",
              "label": "SSWB6 (SSWB9 | South Screw - WB 6.0 (mm))"
            },
            {
              "id": "SSWB7",
              "value": "SSWB7",
              "label": "SSWB7 (SSWB7 | South Screw - WB 7.0 (mm))"
            },
            {
              "id": "SSWB8",
              "value": "SSWB8",
              "label": "SSWB8 (SSWB8 | South Screw - WB 8.0 (mm))"
            },
            {
              "id": "SSWB9",
              "value": "SSWB9",
              "label": "SSWB9 (SSWB9 | South Screw - WB 9.0 (mm))"
            }
          ],
        },
        "bracelet": {
          "diamond": [
            {"id": "VVS-EF", "value": "VVS-EF", "label": "VVS-EF"},
            {"id": "VS-SI-GH", "value": "VS-SI-GH", "label": "VS-SI-GH"},
            {"id": "VS-SI-HI", "value": "VS-SI-HI", "label": "VS-SI-HI"},
            {"id": "SI-HI", "value": "SI-HI", "label": "SI-HI"},
          ],
          "colors": [
            {"id": "Y", "value": "Y", "label": "Y (Yellow)"},
            {"id": "W", "value": "W", "label": "W (White)"},
            {"id": "P", "value": "P", "label": "P (Pink)"}
          ],
          "size": [
            {"id": "6", "value": "6", "label": "6 (B6 (152.4 MM ))"},
            {
              "id": "6.25",
              "value": "6.25",
              "label": "6.25 (B6.25 (158.75 MM))"
            },
            {"id": "6.5", "value": "6.5", "label": "6.5 (B6.50 (165.1 MM ))"},
            {
              "id": "6.75",
              "value": "6.75",
              "label": "6.75 (B6.75 (171.45 MM))"
            },
            {"id": "7", "value": "7", "label": "7 (B7 (177.8 MM ))"},
            {
              "id": "7.25",
              "value": "7.25",
              "label": "7.25 (B7.25 (184.15 MM))"
            },
            {"id": "7.5", "value": "7.5", "label": "7.5 (B7.50 (190.5 MM))"},
            {"id": "8", "value": "8", "label": "8 (B8 (203.2 MM ))"},
            {
              "id": "8.25",
              "value": "8.25",
              "label": "8.25 (Β8.25 (209.55 MM))"
            },
            {"id": "8.5", "value": "8.5", "label": "8.5 (B8.50)"},
            {"id": "5.5", "value": "5.5", "label": "5.5 (B5.5 (139.7 MM))"},
            {"id": "5", "value": "5", "label": "5 (B5 (127 MM ))"}
          ],
        },
        "pendants": {
          "diamond": [
            {"id": "VVS-EF", "value": "VVS-EF", "label": "VVS-EF"},
            {"id": "VS-SI-GH", "value": "VS-SI-GH", "label": "VS-SI-GH"},
            {"id": "VS-SI-HI", "value": "VS-SI-HI", "label": "VS-SI-HI"},
            {"id": "SI-HI", "value": "SI-HI", "label": "SI-HI"},
          ],
          "colors": [
            {"id": "Y", "value": "Y", "label": "Y (Yellow)"},
            {"id": "W", "value": "W", "label": "W (White)"},
            {"id": "P", "value": "P", "label": "P (Pink)"}
          ],
          "size": [],
        },
        "necklace": {
          "diamond": [
            {"id": "VVS-EF", "value": "VVS-EF", "label": "VVS-EF"},
            {"id": "VS-SI-GH", "value": "VS-SI-GH", "label": "VS-SI-GH"},
            {"id": "VS-SI-HI", "value": "VS-SI-HI", "label": "VS-SI-HI"},
            {"id": "SI-HI", "value": "SI-HI", "label": "SI-HI"},
          ],
          "colors": [
            {"id": "Y", "value": "Y", "label": "Y (Yellow)"},
            {"id": "W", "value": "W", "label": "W (White)"},
            {"id": "P", "value": "P", "label": "P (Pink)"}
          ],
          "size": [],
        },
      }
    };

    return preValueCon.predefineResponse;
  }
}
