import 'package:get/get.dart';
import '../../../view/sub_category/sub_category_controller.dart';

import '../../model/sub_category/sub_category_model.dart';

class SubCategoryRepository {

  static Map<String, dynamic> subCategoryList = {
    "success": true,
    "message": "Cart fetched successfully",
    "data": {
      "category": [
        {
          "catName": "Ring",
          "slug": "ring",
          "productAvailable": "Available 4098",
          "image": "https://zeevector.com/wp-content/uploads/2021/02/Diamond-Wedding-Ring-PNG.png",
        },
        {
          "catName": "Earrings",
          "slug": "ear_ring",
          "productAvailable": "Available 4058",
          "image": "https://media.istockphoto.com/id/1742119817/photo/golden-earrings-on-display-on-white-background.jpg?s=612x612&w=0&k=20&c=rO_Seej-7UCuIk42u9ocmfE6pFeK4jJbA4C019PAyVA=",
        },
        {
          "catName": "Pendants",
          "slug": "pendants",
          "productAvailable": "Available 2198",
          "image": "https://media.istockphoto.com/id/1276740597/photo/indian-traditional-gold-necklace.webp?b=1&s=170667a&w=0&k=20&c=8XV0SkFAoH9uuoWCur5C1ErB2oaIXr9vhV7eHhXL6aE=",
        },
        {
          "catName": "Bangles",
          "slug": "bangles",
          "productAvailable": "Available 3598",
          "image": "https://media.istockphoto.com/id/1308181463/photo/indian-traditional-wedding-gold-bangles.webp?b=1&s=170667a&w=0&k=20&c=bAUndDqGEo8SYwmSpKe6JcUNRJqcsreZ4pTjhSDLvCw=",
        },
        {
          "catName": "Necklace",
          "slug": "necklace",
          "productAvailable": "Available 3598",
          "image": "https://media.istockphoto.com/id/176026236/photo/diamond-necklace-and-earring-set.webp?b=1&s=170667a&w=0&k=20&c=XQODMknL5tfcXxYWz38tUpf0WyGghxIUNu5RSat0pSQ=",
        },
        {
          "catName": "Nose Pin",
          "slug": "nose_pin",
          "productAvailable": "Available 3598",
          "image": "https://media.istockphoto.com/id/1484907312/photo/gold-bangles-on-white-background.webp?b=1&s=170667a&w=0&k=20&c=0x5V5AxUQB5nKJU7Fbdr_aF6jLWwQLWnSr0kO77jX1s=",
        },
        {
          "catName": "Bracelet",
          "slug": "bracelet",
          "productAvailable": "Available 3598",
          "image": "https://media.istockphoto.com/id/1651942696/photo/diamond-ring-isolated-on-white-background.webp?b=1&s=170667a&w=0&k=20&c=sOaX2vYuPtkuJce37Umflp_Vwn-F4cd7ryx0ltEexsE=",
        }
      ],
    }
  };

  /// ***********************************************************************************
  ///                                 GET SUB-CATEGORIES API
  /// ***********************************************************************************

  static Future<void> getSubCategoryListApi() async {
    final SubCategoryController categoryCon = Get.find<SubCategoryController>();
    GetSubCategoryModel model = GetSubCategoryModel.fromJson(subCategoryList);
    categoryCon.categoryList.value = model.data?.category ?? [];
  }
}
