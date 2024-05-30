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
                "title": "Apple iPhone 13",
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
                  {"_id": "img1", "image": "https://example.com/iphone13_1.jpg"},
                  {"_id": "img2", "image": "https://example.com/iphone13_2.jpg"}
                ]
              },
              "quantity": 1,
              "price": 999,
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
                "title": "Sony WH-1000XM4",
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
              "price": 698,
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
                "title": "Nike Air Max 270",
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
              "price": 149,
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
                "title": "Logitech MX Master 3",
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
              "price": 297,
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
                "title": "Bose QuietComfort 35 II",
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
              "price": 598,
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
  ///                                    GET ALL ORDERS
  /// ***********************************************************************************

  static Future<void> getAllOrdersAPI({bool isInitial = true}) async {
    final OrdersController con = Get.find<OrdersController>();

    /// TEMP DATA
    GetOrderListModel orderProductModel = GetOrderListModel.fromJson(ordersMap);
    con.orderProductList.value = orderProductModel.data?.results ?? [];
    con.page.value++;

    printData(key: "Home product list length", value: con.orderProductList.length);
    printData(key: "Home total products", value: orderProductModel.data?.totalResults ?? 0);

    if (con.orderProductList.length.toString() == orderProductModel.data?.totalResults.toString()) {
      con.nextPageStop.value = false;
    }

    /// ----  END TAMP DATA
    /* if (await getConnectivityResult()) {
      try {
        if (isInitial) {
          con.orderProductList.clear();
          con.page.value = 1;
          con.isLoading.value = true;
          con.nextPageStop.value = true;
        }

        if (con.nextPageStop.isTrue) {
          await APIFunction.getApiCall(
            apiUrl: ApiUrls.orderProductUrl,
            isLoading: con.isLoading,
            params: {
              "status": con.selectedType.value.toLowerCase(),

              //!
              "limit": "${50}",
            },
          ).then(
            (response) async {
              GetOrderListModel orderProductModel = GetOrderListModel.fromJson(response);
              con.orderProductList.value = orderProductModel.data?.results ?? [];
              con.page.value++;

              printData(key: "Home product list length", value: con.orderProductList.length);
              printData(key: "Home total products", value: orderProductModel.data?.totalResults ?? 0);

              if (con.orderProductList.length.toString() == orderProductModel.data?.totalResults.toString()) {
                con.nextPageStop.value = false;
              }
            },
          );
        }
      } catch (e) {
        printErrors(type: "orderProductApi Function", errText: "$e");
      } finally {
        con.isLoading.value = false;
        con.paginationLoading.value = false;
      }
    }*/
  }
}
