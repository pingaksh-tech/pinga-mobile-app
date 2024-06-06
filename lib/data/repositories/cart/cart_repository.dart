import 'package:get/get.dart';

import '../../../exports.dart';
import '../../../view/bottombar/bottombar_controller.dart';
import '../../../view/cart/cart_controller.dart';
import '../../../view/cart/widget/cart_stock_controller.dart';
import '../../model/cart/cart_model.dart';
import '../../model/cart/stock_model.dart';

class CartRepository {
  /// ***********************************************************************************
  ///                                       CART LIST
  /// ***********************************************************************************

  static Map<String, dynamic> demoJson = {
    "success": true,
    "message": "Cart fetched successfully",
    "data": {
      "products": [
        {
          "_id": "item1",
          "user": "user123",
          "product": {
            "_id": "prod1",
            "title": "Apple iPhone 13",
            "description": "Latest model of Apple iPhone",
            "price": 999.99,
            "color": "Black",
            "category": "Electronics",
            "rate": "4.8",
            "weight": 0.5,
            "deleted_at": null,
            "createdAt": "2023-01-01T12:00:00Z",
            "updatedAt": "2023-01-05T12:00:00Z",
            "productimages": [
              {"_id": "img1", "image": "https://kisna.com/cdn/shop/files/KFLR11133-Y-1_1800x1800.jpg?v=1715687553"},
              {"_id": "img2", "image": "https://example.com/iphone13_2.jpg"}
            ],
            "brand_name": "Apple"
          },
          "quantity": 1,
          "createdAt": "2023-01-01T12:00:00Z",
          "updatedAt": "2023-01-05T12:00:00Z"
        },
        {
          "_id": "item2",
          "user": "user123",
          "product": {
            "_id": "prod2",
            "title": "Samsung Galaxy S21",
            "description": "New release of Samsung Galaxy series",
            "price": 799.99,
            "color": "Silver",
            "category": "Electronics",
            "rate": "4.6",
            "weight": 0.4,
            "deleted_at": null,
            "createdAt": "2023-02-01T12:00:00Z",
            "updatedAt": "2023-02-05T12:00:00Z",
            "productimages": [
              {"_id": "img3", "image": "https://kisna.com/cdn/shop/files/KFLR11133-Y-wm_1800x1800.jpg?v=1715687553"}
            ],
            "brand_name": "Samsung"
          },
          "quantity": 2,
          "createdAt": "2023-02-01T12:00:00Z",
          "updatedAt": "2023-02-05T12:00:00Z"
        },
        {
          "_id": "item3",
          "user": "user123",
          "product": {
            "_id": "prod3",
            "title": "Sony WH-1000XM4",
            "description": "Noise Cancelling Wireless Headphones",
            "price": 349.99,
            "color": "Black",
            "category": "Accessories",
            "rate": "4.7",
            "weight": 0.3,
            "deleted_at": null,
            "createdAt": "2023-03-01T12:00:00Z",
            "updatedAt": "2023-03-05T12:00:00Z",
            "productimages": [
              {"_id": "img4", "image": "https://kisna.com/cdn/shop/files/KFLR11133-Y-4_1800x1800.jpg?v=1715687553"}
            ],
            "brand_name": "Sony"
          },
          "quantity": 1,
          "createdAt": "2023-03-01T12:00:00Z",
          "updatedAt": "2023-03-05T12:00:00Z"
        },
        {
          "_id": "item4",
          "user": "user123",
          "product": {
            "_id": "prod4",
            "title": "Dell XPS 13",
            "description": "13-inch laptop with stunning display",
            "price": 1299.99,
            "color": "White",
            "category": "Computers",
            "rate": "4.5",
            "weight": 1.2,
            "deleted_at": null,
            "createdAt": "2023-04-01T12:00:00Z",
            "updatedAt": "2023-04-05T12:00:00Z",
            "productimages": [
              {"_id": "img5", "image": "https://kisna.com/cdn/shop/files/KFLR11133-Y-2_1800x1800.jpg?v=1715687553"}
            ],
            "brand_name": "Dell"
          },
          "quantity": 1,
          "createdAt": "2023-04-01T12:00:00Z",
          "updatedAt": "2023-04-05T12:00:00Z"
        },
        {
          "_id": "item5",
          "user": "user123",
          "product": {
            "_id": "prod5",
            "title": "Nike Air Max 270",
            "description": "Comfortable and stylish running shoes",
            "price": 149.99,
            "color": "Blue",
            "category": "Footwear",
            "rate": "4.3",
            "weight": 0.8,
            "deleted_at": null,
            "createdAt": "2023-05-01T12:00:00Z",
            "updatedAt": "2023-05-05T12:00:00Z",
            "productimages": [
              {"_id": "img6", "image": "https://kisna.com/cdn/shop/files/KFLR11133-Y-3_1800x1800.jpg?v=1715687553"}
            ],
            "brand_name": "Nike"
          },
          "quantity": 2,
          "createdAt": "2023-05-01T12:00:00Z",
          "updatedAt": "2023-05-05T12:00:00Z"
        },
        {
          "_id": "item6",
          "user": "user123",
          "product": {
            "_id": "prod6",
            "title": "Adidas Ultraboost 21",
            "description": "High-performance running shoes",
            "price": 179.99,
            "color": "White",
            "category": "Footwear",
            "rate": "4.4",
            "weight": 0.7,
            "deleted_at": null,
            "createdAt": "2023-06-01T12:00:00Z",
            "updatedAt": "2023-06-05T12:00:00Z",
            "productimages": [
              {"_id": "img7", "image": "https://kisna.com/cdn/shop/files/KFLR11133-R-1_1800x1800.jpg?v=1715687553"}
            ],
            "brand_name": "Adidas"
          },
          "quantity": 1,
          "createdAt": "2023-06-01T12:00:00Z",
          "updatedAt": "2023-06-05T12:00:00Z"
        },
        {
          "_id": "item7",
          "user": "user123",
          "product": {
            "_id": "prod7",
            "title": "Logitech MX Master 3",
            "description": "Advanced wireless mouse",
            "price": 99.99,
            "color": "Gray",
            "category": "Accessories",
            "rate": "4.9",
            "weight": 0.2,
            "deleted_at": null,
            "createdAt": "2023-07-01T12:00:00Z",
            "updatedAt": "2023-07-05T12:00:00Z",
            "productimages": [
              {"_id": "img8", "image": "https://kisna.com/cdn/shop/files/KFLR11133-W-1_1800x1800.jpg?v=1715687553"}
            ],
            "brand_name": "Logitech"
          },
          "quantity": 3,
          "createdAt": "2023-07-01T12:00:00Z",
          "updatedAt": "2023-07-05T12:00:00Z"
        },
        {
          "_id": "item8",
          "user": "user123",
          "product": {
            "_id": "prod8",
            "title": "Canon EOS R5",
            "description": "Full-frame mirrorless camera",
            "price": 3899.99,
            "color": "Black",
            "category": "Cameras",
            "rate": "4.8",
            "weight": 1.6,
            "deleted_at": null,
            "createdAt": "2023-08-01T12:00:00Z",
            "updatedAt": "2023-08-05T12:00:00Z",
            "productimages": [
              {"_id": "img9", "image": "https://kisna.com/cdn/shop/files/KFLR11133_1800x1800.jpg?v=1715687513"}
            ],
            "brand_name": "Canon"
          },
          "quantity": 1,
          "createdAt": "2023-08-01T12:00:00Z",
          "updatedAt": "2023-08-05T12:00:00Z"
        },
        {
          "_id": "item9",
          "user": "user123",
          "product": {
            "_id": "prod9",
            "title": "Bose QuietComfort 35 II",
            "description": "Noise Cancelling Wireless Headphones",
            "price": 299.99,
            "color": "Silver",
            "category": "Accessories",
            "rate": "4.7",
            "weight": 0.3,
            "deleted_at": null,
            "createdAt": "2023-09-01T12:00:00Z",
            "updatedAt": "2023-09-05T12:00:00Z",
            "productimages": [
              {"_id": "img10", "image": "https://kisna.com/cdn/shop/files/our-promise-7-Days_adf02756-37a0-41e4-bc54-0a7ca584cfe2_1800x1800.webp?v=1715687519"}
            ],
            "brand_name": "Bose"
          },
          "quantity": 1,
          "createdAt": "2023-09-01T12:00:00Z",
          "updatedAt": "2023-09-05T12:00:00Z"
        },
        {
          "_id": "item10",
          "user": "user123",
          "product": {
            "_id": "prod10",
            "title": "Apple MacBook Pro 16",
            "description": "16-inch MacBook Pro with M1 Pro chip",
            "price": 2499.99,
            "color": "Space Gray",
            "category": "Computers",
            "rate": "4.9",
            "weight": 2.0,
            "deleted_at": null,
            "createdAt": "2023-10-01T12:00:00Z",
            "updatedAt": "2023-10-05T12:00:00Z",
            "productimages": [
              {"_id": "img11", "image": "https://kisna.com/cdn/shop/files/KFLR11133-Y-2_1800x1800.jpg?v=1715687553"},
              {"_id": "img12", "image": "https://example.com/macbookpro16_2.jpg"}
            ],
            "brand_name": "Apple"
          },
          "quantity": 1,
          "createdAt": "2023-10-01T12:00:00Z",
          "updatedAt": "2023-10-05T12:00:00Z"
        }
      ],
      "total": 11278.89
    }
  };

  static Map<String, dynamic> stockList = {
    "success": true,
    "message": "Stock fetched successfully",
    "data": {
      "stocks": [
        {"id": "stock1", "value": "Pear", "stock": "Diamond Type", "image": AppAssets.diamondIcon},
        {"id": "stock2", "value": "0.00 ct", "stock": "Diamond Wt", "image": AppAssets.diamondWeight},
        {"id": "stock3", "value": "2.86 gm", "stock": "Metal Wt", "image": AppAssets.metalWeight},
        {"id": "stock4", "value": "Yellow + White", "stock": "Color", "image": AppAssets.colorIcon},
        {"id": "stock4", "value": "16", "stock": "Size", "image": AppAssets.ringSizeIcon},
        {"id": "stock4", "value": "1", "stock": "Available quantity", "image": AppAssets.stockIcon}
      ]
    }
  };

  List productDetail = [
    {"categoryName": "Metal", "value": "Gold"},
  ];

  static Future<void> cartListApi() async {
    final CartController cartCon = Get.find<CartController>();
    CartDataModel model = CartDataModel.fromJson(demoJson /*response*/);
    cartCon.productsList.value = model.data?.products ?? [];
    cartCon.totalPrice.value = double.tryParse((model.data?.total).toString()) ?? 0;
    // try {
    //   cartCon.isLoading.value = true;
    //   await APIFunction.getApiCall(apiUrl: ApiUrls.cartListGET).then(
    //     (response) async {
    //       CartDataModel model = CartDataModel.fromJson(response);
    //       cartCon.productsList.value = model.data?.products ?? [];
    //       cartCon.totalPrice.value = double.tryParse((model.data?.total).toString()) ?? 0;
    //     },
    //   );
    // } catch (e) {
    //   printErrors(type: "Error", errText: "$e");
    // } finally {
    //   cartCon.isLoading.value = false;
    // }
  }

  /// ***********************************************************************************
  ///                                       UPDATE QUANTITY
  /// ***********************************************************************************

  static Future<void> updateQuantityAPI({required String productId, required bool doIncrease}) async {
    final CartController cartCon = Get.find<CartController>();

    /// TEMP
    cartCon.calculateTotalPrice();

    ///
    try {
      await APIFunction.putApiCall(apiUrl: "${ApiUrls.cartUpdatePUT}$productId", body: {"action": doIncrease ? "+" : "-"}).then(
        (response) async {
          printOkStatus("Cart Updated Successfully");
          cartCon.calculateTotalPrice();
        },
      );
    } catch (e) {
      printErrors(type: "Error", errText: "$e");
    }
  }

  /// ***********************************************************************************
  ///                               ADD or REMOVE PRODUCT IN CART
  /// ***********************************************************************************
  static Future<bool> addOrRemoveProductInCart({required String productID, required bool currentValue, RxBool? isLoading}) async {
    try {
      isLoading?.value = true;
      await APIFunction.putApiCall(apiUrl: "${ApiUrls.addOrRemoveCart}$productID").then(
        (response) async {
          currentValue = !currentValue;
          UiUtils.toast(response["message"]);
        },
      );

      return currentValue;
    } catch (e) {
      printErrors(type: "addOrRemoveProductInCart", errText: "$e");
      return currentValue;
    } finally {
      isLoading?.value = false;
    }
  }

  /// ***********************************************************************************
  ///                                       PLACE ORDER
  /// ***********************************************************************************

  static Future<void> placeOrderAPI() async {
    final CartController cartCon = Get.find<CartController>();
    try {
      cartCon.isLoading.value = true;

      await APIFunction.postApiCall(apiUrl: ApiUrls.placeOrderPOST).then(
        (response) async {
          // if (Get.isRegistered<HomeController>()) {
          //   HomeController homeCon = Get.find<HomeController>();
          //   for (int i = 0; i < homeCon.homeProductList.length; i++) {
          //     homeCon.homeProductList[i].cart = false.obs;
          //   }
          // }
          cartCon.isLoading.value = false;
          UiUtils.toast("Order Placed Successfully");
          Get.find<BottomBarController>().onBottomBarTap(3);
        },
      );
    } catch (e) {
      printErrors(type: "Error", errText: "$e");
      UiUtils.toast("PLease try again");
      cartCon.isLoading.value = false;
    } finally {}
  }

  /// ***********************************************************************************
  ///                                     GET STOCK
  /// **********************************************************************************
  static Future<void> getStockAPI({RxBool? isLoader}) async {
    final CartStockController stockCon = Get.find<CartStockController>();
    GetStockModel model = GetStockModel.fromJson(stockList /*response*/);
    stockCon.stockList.value = model.stockModel?.stocks ?? [];
  }
}
