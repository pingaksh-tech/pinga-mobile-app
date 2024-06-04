import 'package:get/get.dart';

import '../../../controller/dialog_controller.dart';
import '../../../view/products/product_controller.dart';
import '../../model/product/product_colors_model.dart';
import '../../model/product/product_model.dart';
import '../../model/product/product_size_model.dart';

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

  /// ***********************************************************************************
  ///                                       PRODUCT SIZE LIST
  /// ***********************************************************************************

  static Map<String, dynamic> productSizeList = {
    "success": true,
    "message": "Size fetched successfully",
    "data": {
      "sizes": [
        {"id": "size1", "size": "4 (S4 | CP-6 | P-04)"},
        {"id": "size2", "size": "5 (S5 | P-5)"},
        {"id": "size3", "size": "6 (S6 | CP-8 | P-6 45.9 (mm))"},
        {"id": "size4", "size": "7 (S7 | CP-7 | P-07)"},
        {"id": "size5", "size": "8 (S8 | P-8)"},
        {"id": "size6", "size": "9 (S9 | CP-9 | P-9 50.2 (mm))"},
        {"id": "size7", "size": "10 (S10 | CP-10 | P-10)"},
        {"id": "size8", "size": "11 (S11 | P-11)"},
        {"id": "size9", "size": "12 (S12 | CP-12 | P-12 60.4 (mm))"},
        {"id": "size10", "size": "13 (S13 | CP-13 | P-13)"},
        {"id": "size11", "size": "14 (S14 | P-14)"},
        {"id": "size12", "size": "15 (S15 | CP-15 | P-15 70.6 (mm))"},
        {"id": "size13", "size": "16 (S16 | CP-16 | P-16)"},
        {"id": "size14", "size": "17 (S17 | P-17)"},
        {"id": "size15", "size": "18 (S18 | CP-18 | P-18 80.8 (mm))"},
        {"id": "size16", "size": "19 (S19 | CP-19 | P-19)"},
        {"id": "size17", "size": "20 (S20 | P-20)"},
        {"id": "size18", "size": "21 (S21 | CP-21 | P-21 90.0 (mm))"},
        {"id": "size19", "size": "22 (S22 | CP-22 | P-22)"},
        {"id": "size20", "size": "23 (S23 | P-23)"},
        {"id": "size21", "size": "24 (S24 | CP-24 | P-24 100.2 (mm))"},
        {"id": "size22", "size": "25 (S25 | CP-25 | P-25)"},
        {"id": "size23", "size": "26 (S26 | P-26)"},
        {"id": "size24", "size": "27 (S27 | CP-27 | P-27 110.4 (mm))"},
        {"id": "size25", "size": "28 (S28 | CP-28 | P-28)"},
        {"id": "size26", "size": "29 (S29 | P-29)"},
        {"id": "size27", "size": "30 (S30 | CP-30 | P-30 120.6 (mm))"},
        {"id": "size28", "size": "31 (S31 | CP-31 | P-31)"},
        {"id": "size29", "size": "32 (S32 | P-32)"},
        {"id": "size30", "size": "33 (S33 | CP-33 | P-33 130.8 (mm))"},
        {"id": "size31", "size": "34 (S34 | CP-34 | P-34)"},
        {"id": "size32", "size": "35 (S35 | P-35)"},
        {"id": "size33", "size": "36 (S36 | CP-36 | P-36 140.0 (mm))"},
        {"id": "size34", "size": "37 (S37 | CP-37 | P-37)"},
        {"id": "size35", "size": "38 (S38 | P-38)"},
        {"id": "size36", "size": "39 (S39 | CP-39 | P-39 150.2 (mm))"},
        {"id": "size37", "size": "40 (S40 | CP-40 | P-40)"},
        {"id": "size38", "size": "41 (S41 | P-41)"},
        {"id": "size39", "size": "42 (S42 | CP-42 | P-42 160.4 (mm))"},
        {"id": "size40", "size": "43 (S43 | CP-43 | P-43)"},
        {"id": "size41", "size": "44 (S44 | P-44)"},
        {"id": "size42", "size": "45 (S45 | CP-45 | P-45 170.6 (mm))"},
        {"id": "size43", "size": "46 (S46 | CP-46 | P-46)"},
        {"id": "size44", "size": "47 (S47 | P-47)"},
        {"id": "size45", "size": "48 (S48 | CP-48 | P-48 180.8 (mm))"},
        {"id": "size46", "size": "49 (S49 | CP-49 | P-49)"},
        {"id": "size47", "size": "50 (S50 | P-50)"},
        {"id": "size48", "size": "51 (S51 | CP-51 | P-51 190.0 (mm))"},
        {"id": "size49", "size": "52 (S52 | CP-52 | P-52)"},
        {"id": "size50", "size": "53 (S53 | P-53)"}
      ],
    }
  };

  /// ***********************************************************************************
  ///                                       PRODUCT COLOR LIST
  /// ***********************************************************************************
  static Map<String, dynamic> productColorList = {
    "success": true,
    "message": "Colors fetched successfully",
    "data": {
      "colors": [
        {"id": "color1", "color": "Y (Yellow)"},
        {"id": "color2", "color": "R (Red)"},
        {"id": "color3", "color": "B (Blue)"},
        {"id": "color4", "color": "G (Green)"},
        {"id": "color5", "color": "O (Orange)"},
        {"id": "color6", "color": "P (Purple)"},
        {"id": "color7", "color": "W (White)"},
        {"id": "color8", "color": "BK (Black)"},
        {"id": "color9", "color": "BR (Brown)"},
        {"id": "color10", "color": "PI (Pink)"},
        {"id": "color11", "color": "C (Cyan)"},
        {"id": "color12", "color": "M (Magenta)"},
        {"id": "color13", "color": "L (Lime)"},
        {"id": "color14", "color": "N (Navy)"},
        {"id": "color15", "color": "GR (Gray)"},
        {"id": "color16", "color": "MG (Maroon)"},
        {"id": "color17", "color": "BE (Beige)"},
        {"id": "color18", "color": "TE (Teal)"},
        {"id": "color19", "color": "AQ (Aqua)"},
        {"id": "color20", "color": "LV (Lavender)"},
      ],
    }
  };
  static Map<String, dynamic> variantList = {
    "success": true,
    "message": "Colors fetched successfully",
    "data": {
      "products": [
        [
          {"id": "p1", "name": "Solitaire Ring", "price": 2344, "color_id": "color1", "size_id": "size50", "quantity": 3, "diamond": "ds"},
          {"id": "p2", "name": "Diamond Necklace", "price": 3999, "color_id": "color7", "size_id": "size14", "quantity": 1, "diamond": "ds"},
          {"id": "p3", "name": "Gold Bracelet", "price": 799, "color_id": "color2", "size_id": "size17", "quantity": 5, "diamond": "ds"},
          {"id": "p4", "name": "Silver Earrings", "price": 299, "color_id": "color3", "size_id": "size32", "quantity": 2, "diamond": "ds"},
          {"id": "p5", "name": "Platinum Band", "price": 1799, "color_id": "color4", "size_id": "size45", "quantity": 10, "diamond": "ds"},
          {"id": "p6", "name": "Ruby Pendant", "price": 1299, "color_id": "color2", "size_id": "size19", "quantity": 4, "diamond": "ds"},
          {"id": "p7", "name": "Sapphire Ring", "price": 2999, "color_id": "color3", "size_id": "size16", "quantity": 8, "diamond": "ds"},
          {"id": "p8", "name": "Emerald Bracelet", "price": 899, "color_id": "color4", "size_id": "size22", "quantity": 6, "diamond": "ds"},
          {"id": "p9", "name": "Topaz Earrings", "price": 499, "color_id": "color5", "size_id": "size35", "quantity": 3, "diamond": "ds"},
          {"id": "p10", "name": "Pearl Necklace", "price": 599, "color_id": "color7", "size_id": "size27", "quantity": 2, "diamond": "ds"},
          {"id": "p11", "name": "Amethyst Ring", "price": 899, "color_id": "color6", "size_id": "size23", "quantity": 5, "diamond": "ds"},
          {"id": "p12", "name": "Opal Pendant", "price": 749, "color_id": "color7", "size_id": "size30", "quantity": 7, "diamond": "ds"},
          {"id": "p13", "name": "Peridot Bracelet", "price": 349, "color_id": "color4", "size_id": "size39", "quantity": 4, "diamond": "ds"},
          {"id": "p14", "name": "Citrine Earrings", "price": 299, "color_id": "color1", "size_id": "size42", "quantity": 3, "diamond": "ds"},
          {"id": "p15", "name": "Garnet Ring", "price": 599, "color_id": "color2", "size_id": "size28", "quantity": 6, "diamond": "ds"},
          {"id": "p16", "name": "Tanzanite Bracelet", "price": 1599, "color_id": "color3", "size_id": "size24", "quantity": 9, "diamond": "ds"},
          {"id": "p17", "name": "Aquamarine Pendant", "price": 1099, "color_id": "color3", "size_id": "size17", "quantity": 3, "diamond": "ds"},
          {"id": "p18", "name": "Turquoise Necklace", "price": 499, "color_id": "color4", "size_id": "size36", "quantity": 5, "diamond": "ds"},
          {"id": "p19", "name": "Moonstone Earrings", "price": 399, "color_id": "color7", "size_id": "size41", "quantity": 2, "diamond": "ds"},
          {"id": "p20", "name": "Alexandrite Ring", "price": 1999, "color_id": "color6", "size_id": "size25", "quantity": 7, "diamond": "ds"}
        ]
      ],
    }
  };

  /// ***********************************************************************************
  ///                                       GET PRODUCT SIZE
  /// ***********************************************************************************
  static Future<void> getProductSizeAPI({RxBool? isLoader}) async {
    final DialogController dialogCon = Get.find<DialogController>();
    GetProductSizeModel model = GetProductSizeModel.fromJson(productSizeList /*response*/);
    dialogCon.productSizeList.value = model.data?.sizes ?? [];
  }

  /// ***********************************************************************************
  ///                                       GET PRODUCT COLOR
  /// ***********************************************************************************
  static Future<void> getProductColorAPI({RxBool? isLoader}) async {
    final DialogController dialogCon = Get.find<DialogController>();
    GetProductColorModel model = GetProductColorModel.fromJson(productColorList /*response*/);
    dialogCon.productColorList.value = model.data?.colors ?? [];
  }

  static Future<void> productListApi() async {
    final ProductController productCon = Get.find<ProductController>();
    GetProductModel model = GetProductModel.fromJson(productList);
    productCon.productsList.value = model.data?.products ?? [];
  }
}
