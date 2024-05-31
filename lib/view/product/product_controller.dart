import 'package:get/get.dart';

class ProductController extends GetxController {
  RxString categoryName = "".obs;
  RxBool isProductViewChange = true.obs;

  final List<Map<String, dynamic>> productList = [
    {
      "price": "50000",
      "image": "https://media.istockphoto.com/id/1318401740/photo/indian-gold-jewellery-stock-photo.webp?b=1&s=170667a&w=0&k=20&c=xbkn3_S5igjnfBDOHkuGCfg4BmGj8U2djQSvdDuccC8=",
    },
    {
      "price": "108045",
      "image": "https://media.istockphoto.com/id/502711544/photo/rings.webp?b=1&s=170667a&w=0&k=20&c=UnC1U08uujF6Weh3Cz1u8duHbG-0luKf_U9_GfRo2Bc=",
    },
    {
      "price": "50730",
      "image": "https://media.istockphoto.com/id/1132212394/photo/artificial-golden-bangles-close-up-on-a-textured-background.webp?b=1&s=170667a&w=0&k=20&c=A5kc3t0SNznsnJN6Numvt23avS2K_FrRwOBgmgpSY-o=",
    },
    {
      "price": "102540",
      "image": "https://media.istockphoto.com/id/1651942696/photo/diamond-ring-isolated-on-white-background.webp?b=1&s=170667a&w=0&k=20&c=sOaX2vYuPtkuJce37Umflp_Vwn-F4cd7ryx0ltEexsE=",
    },
    {
      "price": "486050",
      "image": "https://media.istockphoto.com/id/1133517116/photo/fancy-designer-precious-jewelry-golden-ring-closeup-macro-image-on-red-background-for-woman.webp?b=1&s=170667a&w=0&k=20&c=fQNCRVwT5wVZzYdEU6eWgiXqcJEMgB53jcj_jCuR8VI=",
    },
    {
      "price": "105086",
      "image": "https://media.istockphoto.com/id/1651942696/photo/diamond-ring-isolated-on-white-background.webp?b=1&s=170667a&w=0&k=20&c=sOaX2vYuPtkuJce37Umflp_Vwn-F4cd7ryx0ltEexsE=",
    },
    {
      "price": "205001",
      "image": "https://media.istockphoto.com/id/1651974076/photo/golden-wedding-rings-on-trendy-white-podium-aesthetic-still-life-art-photography.webp?b=1&s=170667a&w=0&k=20&c=JYqzNrZjGH5c4OxWrjhvebI5_6rBCJ9JRZPe9cj_-rM=",
    },
  ];

  RxList sort = [].obs;
  final List<Map<String, dynamic>> sortOptions = [
    {"title": "Price - Low to high", "isChecked": false.obs},
    {"title": "Price - High to Low", "isChecked": false.obs},
    {"title": "Newest First", "isChecked": false.obs},
    {"title": "Oldest First", "isChecked": false.obs},
    {"title": "Most Ordered", "isChecked": false.obs},
  ];
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments["categoryName"].runtimeType == String) {
        categoryName.value = Get.arguments["categoryName"];
      }
    }
  }
}
