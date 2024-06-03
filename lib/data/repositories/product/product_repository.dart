import 'package:get/get.dart';
import 'package:pingaksh_mobile/view/product/product_controller.dart';

import '../../model/product/product_model.dart';

class ProductRepository {
  static Map<String, dynamic> productList = {
    "success": true,
    "message": "Product fetched successfully",
    "data": {
      "products": [
        {
          "_id": "item1",
          "user": "user123",
          "product": {
            "_id": "prod1",
            "title": "PLKMR7423746",
            "description": "Latest model of Apple iPhone",
            "price": 50000,
            "color": "Black",
            "category": "Electronics",
            "rate": "4.8",
            "weight": 0.5,
            "deleted_at": null,
            "createdAt": "2023-01-01T12:00:00Z",
            "updatedAt": "2023-01-05T12:00:00Z",
            "productImages": "https://media.istockphoto.com/id/1318401740/photo/indian-gold-jewellery-stock-photo.webp?b=1&s=170667a&w=0&k=20&c=xbkn3_S5igjnfBDOHkuGCfg4BmGj8U2djQSvdDuccC8=",
            "brand_name": "Apple",
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
            "title": "PLKMR7423750",
            "description": "New release of Samsung Galaxy series",
            "price": 108045,
            "color": "Silver",
            "category": "Electronics",
            "rate": "4.6",
            "weight": 0.4,
            "deleted_at": null,
            "createdAt": "2023-02-01T12:00:00Z",
            "updatedAt": "2023-02-05T12:00:00Z",
            "productImages": "https://media.istockphoto.com/id/502711544/photo/rings.webp?b=1&s=170667a&w=0&k=20&c=UnC1U08uujF6Weh3Cz1u8duHbG-0luKf_U9_GfRo2Bc=",
            "brand_name": "Samsung",
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
            "title": "PLKMR7428666",
            "description": "Noise Cancelling Wireless Headphones",
            "price": 50730,
            "color": "Black",
            "category": "Accessories",
            "rate": "4.7",
            "weight": 0.3,
            "deleted_at": null,
            "createdAt": "2023-03-01T12:00:00Z",
            "updatedAt": "2023-03-05T12:00:00Z",
            "productImages": "https://media.istockphoto.com/id/1132212394/photo/artificial-golden-bangles-close-up-on-a-textured-background.webp?b=1&s=170667a&w=0&k=20&c=A5kc3t0SNznsnJN6Numvt23avS2K_FrRwOBgmgpSY-o=",
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
            "title": "PLKMR74234542",
            "description": "13-inch laptop with stunning display",
            "price": 102540,
            "color": "White",
            "category": "Computers",
            "rate": "4.5",
            "weight": 1.2,
            "deleted_at": null,
            "createdAt": "2023-04-01T12:00:00Z",
            "updatedAt": "2023-04-05T12:00:00Z",
            "productImages": "https://media.istockphoto.com/id/1651942696/photo/diamond-ring-isolated-on-white-background.webp?b=1&s=170667a&w=0&k=20&c=sOaX2vYuPtkuJce37Umflp_Vwn-F4cd7ryx0ltEexsE=",
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
            "title": "PLKMR74237784",
            "description": "Comfortable and stylish running shoes",
            "price": 486050,
            "color": "Blue",
            "category": "Footwear",
            "rate": "4.3",
            "weight": 0.8,
            "deleted_at": null,
            "createdAt": "2023-05-01T12:00:00Z",
            "updatedAt": "2023-05-05T12:00:00Z",
            "productImages": "https://media.istockphoto.com/id/1133517116/photo/fancy-designer-precious-jewelry-golden-ring-closeup-macro-image-on-red-background-for-woman.webp?b=1&s=170667a&w=0&k=20&c=fQNCRVwT5wVZzYdEU6eWgiXqcJEMgB53jcj_jCuR8VI=",
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
            "title": "PLKMR74481251",
            "description": "High-performance running shoes",
            "price": 20500,
            "color": "White",
            "category": "Footwear",
            "rate": "4.4",
            "weight": 0.7,
            "deleted_at": null,
            "createdAt": "2023-06-01T12:00:00Z",
            "updatedAt": "2023-06-05T12:00:00Z",
            "productImages": "https://media.istockphoto.com/id/1651974076/photo/golden-wedding-rings-on-trendy-white-podium-aesthetic-still-life-art-photography.webp?b=1&s=170667a&w=0&k=20&c=JYqzNrZjGH5c4OxWrjhvebI5_6rBCJ9JRZPe9cj_-rM=",
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
            "title": "PLKMR7445856",
            "description": "Advanced wireless mouse",
            "price": 105086,
            "color": "Gray",
            "category": "Accessories",
            "rate": "4.9",
            "weight": 0.2,
            "deleted_at": null,
            "createdAt": "2023-07-01T12:00:00Z",
            "updatedAt": "2023-07-05T12:00:00Z",
            "productImages": "https://media.istockphoto.com/id/1651942696/photo/diamond-ring-isolated-on-white-background.webp?b=1&s=170667a&w=0&k=20&c=sOaX2vYuPtkuJce37Umflp_Vwn-F4cd7ryx0ltEexsE=",
            "brand_name": "Logitech"
          },
          "quantity": 3,
          "createdAt": "2023-07-01T12:00:00Z",
          "updatedAt": "2023-07-05T12:00:00Z"
        }
      ],
    }
  };

  static Future<void> productListApi() async {
    final ProductController productCon = Get.find<ProductController>();
    GetProductModel model = GetProductModel.fromJson(productList);
    productCon.productsList.value = model.data?.products ?? [];
  }
}
