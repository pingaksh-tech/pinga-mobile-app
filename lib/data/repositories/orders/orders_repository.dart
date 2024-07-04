import 'package:get/get.dart';

import '../../../exports.dart';
import '../../../view/orders/orders_controller.dart';
import '../../model/order/order_list_model.dart';

class OrdersRepository {
  static Map<String, dynamic> ordersMap = {
    "success": true,
    "message": "Order list fetched successfully",
    "data": {
      "results": [
        {
          "_id": "order1",
          "products": [
            {
              "product": {
                "_id": "prod1",
                "title": "Hari Ambe Jewellers",
                "description": "Latest model of Apple iPhone",
                "price": 999,
                "color": "Black",
                "category": "Electronics",
                "rate": "4.8",
                "weight": 500,
                "deleted_at": null,
                "createdAt": "2023-01-01T12:00:00Z",
                "updatedAt": "2023-01-05T12:00:00Z",
                "productimages": [
                  {"_id": "img1", "image": "https://kisna.com/cdn/shop/files/KFLR11133-Y-2_1800x1800.jpg?v=1715687553"},
                  {"_id": "img2", "image": "https://example.com/iphone13_2.jpg"}
                ]
              },
              "quantity": 1,
              "price": 10420,
              "_id": "item1"
            },
            {
              "product": {
                "_id": "prod2",
                "title": "Samsung Galaxy S21",
                "description": "New release of Samsung Galaxy series",
                "price": 799,
                "color": "Silver",
                "category": "Electronics",
                "rate": "4.6",
                "weight": 400,
                "deleted_at": null,
                "createdAt": "2023-02-01T12:00:00Z",
                "updatedAt": "2023-02-05T12:00:00Z",
                "productimages": [
                  {"_id": "img3", "image": "https://example.com/galaxys21_1.jpg"}
                ]
              },
              "quantity": 1,
              "price": 799,
              "_id": "item2"
            }
          ],
          "total_amount": 1798,
          "user": "user123",
          "status": "Pending",
          "createdAt": "2023-04-01T12:00:00Z"
        },
        {
          "_id": "order2",
          "products": [
            {
              "product": {
                "_id": "prod3",
                "title": "Golden Jewellers",
                "description": "Noise Cancelling Wireless Headphones",
                "price": 349,
                "color": "Black",
                "category": "Accessories",
                "rate": "4.7",
                "weight": 300,
                "deleted_at": null,
                "createdAt": "2023-03-01T12:00:00Z",
                "updatedAt": "2023-03-05T12:00:00Z",
                "productimages": [
                  {"_id": "img4", "image": "https://example.com/sony_headphones_1.jpg"}
                ]
              },
              "quantity": 2,
              "price": 68560,
              "_id": "item3"
            },
            {
              "product": {
                "_id": "prod4",
                "title": "Dell XPS 13",
                "description": "13-inch laptop with stunning display",
                "price": 1299,
                "color": "White",
                "category": "Computers",
                "rate": "4.5",
                "weight": 1200,
                "deleted_at": null,
                "createdAt": "2023-04-01T12:00:00Z",
                "updatedAt": "2023-04-05T12:00:00Z",
                "productimages": [
                  {"_id": "img5", "image": "https://example.com/dell_xps13_1.jpg"}
                ]
              },
              "quantity": 1,
              "price": 1299,
              "_id": "item4"
            }
          ],
          "total_amount": 1997,
          "user": "user456",
          "status": "Rejected",
          "createdAt": "2023-05-01T12:00:00Z"
        },
        {
          "_id": "order3",
          "products": [
            {
              "product": {
                "_id": "prod5",
                "title": "Riv Jewellers",
                "description": "Comfortable and stylish running shoes",
                "price": 149,
                "color": "Blue",
                "category": "Footwear",
                "rate": "4.3",
                "weight": 800,
                "deleted_at": null,
                "createdAt": "2023-05-01T12:00:00Z",
                "updatedAt": "2023-05-05T12:00:00Z",
                "productimages": [
                  {"_id": "img6", "image": "https://example.com/nike_airmax270_1.jpg"}
                ]
              },
              "quantity": 1,
              "price": 145811,
              "_id": "item5"
            },
            {
              "product": {
                "_id": "prod6",
                "title": "Adidas Ultraboost 21",
                "description": "High-performance running shoes",
                "price": 179,
                "color": "White",
                "category": "Footwear",
                "rate": "4.4",
                "weight": 700,
                "deleted_at": null,
                "createdAt": "2023-06-01T12:00:00Z",
                "updatedAt": "2023-06-05T12:00:00Z",
                "productimages": [
                  {"_id": "img7", "image": "https://example.com/adidas_ultraboost21_1.jpg"}
                ]
              },
              "quantity": 2,
              "price": 358,
              "_id": "item6"
            }
          ],
          "total_amount": 507,
          "user": "user789",
          "status": "Accepted",
          "createdAt": "2023-06-01T12:00:00Z"
        },
        {
          "_id": "order4",
          "products": [
            {
              "product": {
                "_id": "prod7",
                "title": "Hari Om Jewellers",
                "description": "Advanced wireless mouse",
                "price": 99,
                "color": "Gray",
                "category": "Accessories",
                "rate": "4.9",
                "weight": 200,
                "deleted_at": null,
                "createdAt": "2023-07-01T12:00:00Z",
                "updatedAt": "2023-07-05T12:00:00Z",
                "productimages": [
                  {"_id": "img8", "image": "https://example.com/logitech_mxmaster3_1.jpg"}
                ]
              },
              "quantity": 3,
              "price": 28127,
              "_id": "item7"
            },
            {
              "product": {
                "_id": "prod8",
                "title": "Canon EOS R5",
                "description": "Full-frame mirrorless camera",
                "price": 3899,
                "color": "Black",
                "category": "Cameras",
                "rate": "4.8",
                "weight": 1600,
                "deleted_at": null,
                "createdAt": "2023-08-01T12:00:00Z",
                "updatedAt": "2023-08-05T12:00:00Z",
                "productimages": [
                  {"_id": "img9", "image": "https://example.com/canon_eosr5_1.jpg"}
                ]
              },
              "quantity": 1,
              "price": 3899,
              "_id": "item8"
            }
          ],
          "total_amount": 4196,
          "user": "user101",
          "status": "Completed",
          "createdAt": "2023-07-01T12:00:00Z"
        },
        {
          "_id": "order5",
          "products": [
            {
              "product": {
                "_id": "prod9",
                "title": "Suvarn Jewellers",
                "description": "Noise Cancelling Wireless Headphones",
                "price": 299,
                "color": "Silver",
                "category": "Accessories",
                "rate": "4.7",
                "weight": 300,
                "deleted_at": null,
                "createdAt": "2023-09-01T12:00:00Z",
                "updatedAt": "2023-09-05T12:00:00Z",
                "productimages": [
                  {"_id": "img10", "image": "https://example.com/bose_qc35ii_1.jpg"}
                ]
              },
              "quantity": 2,
              "price": 12088,
              "_id": "item9"
            },
            {
              "product": {
                "_id": "prod10",
                "title": "Apple MacBook Pro 16",
                "description": "16-inch MacBook Pro with M1 Pro chip",
                "price": 2499,
                "color": "Space Gray",
                "category": "Computers",
                "rate": "4.9",
                "weight": 2000,
                "deleted_at": null,
                "createdAt": "2023-10-01T12:00:00Z",
                "updatedAt": "2023-10-05T12:00:00Z",
                "productimages": [
                  {"_id": "img11", "image": "https://example.com/macbookpro16_1.jpg"},
                  {"_id": "img12", "image": "https://example.com/macbookpro16_2.jpg"}
                ]
              },
              "quantity": 1,
              "price": 2499,
              "_id": "item10"
            }
          ],
          "total_amount": 3097,
          "user": "user202",
          "status": "Completed",
          "createdAt": "2023-09-01T12:00:00Z"
        }
      ],
      "totalResults": 5,
      "page": 1,
      "limit": 10,
      "totalPages": 1
    }
  };

  /// ***********************************************************************************
  ///                                CREATE ORDER API
  /// ***********************************************************************************
  static Future<void> createOrder({
    required String retailerId,
    required String orderType,
    required int quantity,
    required String subTotal,
    required List<Map<String, dynamic>> cartItems,
    RxBool? loader,
  }) async {
    if (await getConnectivityResult()) {
      try {
        loader?.value = true;

        /// API
        await APIFunction.postApiCall(
          apiUrl: ApiUrls.createOrGetOrder,
          body: {
            "retailer_id": retailerId,
            "order_type": orderType,
            "qty": quantity,
            "sub_total": subTotal,
            "orderItems": cartItems,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              loader?.value = false;
            } else {
              loader?.value = false;
            }

            return response;
          },
        );
      } catch (e) {
        loader?.value = false;
        printErrors(type: "createOrderApi", errText: e);
      }
    }
  }

  /// ***********************************************************************************
  ///                                    GET ALL ORDERS
  /// ***********************************************************************************

  static Future<dynamic> getAllOrdersAPI({
    bool isInitial = true,
    RxBool? loader,
    bool isPullToRefresh = false,
    DateTime? startDate,
    DateTime? endDate,
    String? retailerId,
  }) async {
    ///
    if (await getConnectivityResult() && isRegistered<OrdersController>()) {
      final OrdersController con = Get.find<OrdersController>();

      try {
        loader?.value = true;

        if (isInitial) {
          if (!isPullToRefresh) {
            con.orderList.clear();
          }
          con.page.value = 1;
          con.nextPageAvailable.value = true;
        }

        /// API
        await APIFunction.getApiCall(
          apiUrl: ApiUrls.createOrGetOrder,
          params: {
            "page": con.page.value,
            "limit": con.itemLimit.value,
            if (!isValEmpty(startDate)) "start_date": startDate?.toIso8601String(),
            if (!isValEmpty(endDate)) "end_date": endDate?.toIso8601String(),
            if (!isValEmpty(retailerId)) "retailer_id": retailerId,
          },
          loader: loader,
        ).then(
          (response) async {
            if (response != null) {
              GetOrderModel model = GetOrderModel.fromJson(response);

              if (model.data != null) {
                if (isPullToRefresh) {
                  con.orderList.value = model.data?.orders ?? [];
                } else {
                  con.orderList.addAll(model.data?.orders ?? []);
                }
                con.orderCounts.value = model.data?.orderCounts ?? OrderCounts();
                int currentPage = (model.data!.page ?? 1);
                con.nextPageAvailable.value = currentPage < (model.data!.totalPages ?? 0);
                con.page.value += currentPage;
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
        printErrors(type: "getCartList", errText: e);
      }
    }
  }
}
