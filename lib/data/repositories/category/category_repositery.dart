import 'package:get/get.dart';
import '../../../view/category/category_controller.dart';

import '../../model/category/category_model.dart';

class CategoryRepository {
  static Map<String, dynamic> categoryList = {
    "success": true,
    "message": "Cart fetched successfully",
    "data": {
      "category": [
        {
          "catName": "Ring",
          "productAvailable": "Available 4098",
          "image": "https://zeevector.com/wp-content/uploads/2021/02/Diamond-Wedding-Ring-PNG.png",
        },
        {
          "catName": "Earrings",
          "productAvailable": "Available 4058",
          "image": "https://media.istockphoto.com/id/1742119817/photo/golden-earrings-on-display-on-white-background.jpg?s=612x612&w=0&k=20&c=rO_Seej-7UCuIk42u9ocmfE6pFeK4jJbA4C019PAyVA=",
        },
        {
          "catName": "Pendants",
          "productAvailable": "Available 2198",
          "image": "https://media.istockphoto.com/id/1276740597/photo/indian-traditional-gold-necklace.webp?b=1&s=170667a&w=0&k=20&c=8XV0SkFAoH9uuoWCur5C1ErB2oaIXr9vhV7eHhXL6aE=",
        },
        {
          "catName": "Bangles",
          "productAvailable": "Available 3598",
          "image": "https://media.istockphoto.com/id/1308181463/photo/indian-traditional-wedding-gold-bangles.webp?b=1&s=170667a&w=0&k=20&c=bAUndDqGEo8SYwmSpKe6JcUNRJqcsreZ4pTjhSDLvCw=",
        },
        {
          "catName": "Necklace",
          "productAvailable": "Available 3598",
          "image": "https://media.istockphoto.com/id/176026236/photo/diamond-necklace-and-earring-set.webp?b=1&s=170667a&w=0&k=20&c=XQODMknL5tfcXxYWz38tUpf0WyGghxIUNu5RSat0pSQ=",
        },
        {
          "catName": "Bangles",
          "productAvailable": "Available 3598",
          "image": "https://media.istockphoto.com/id/1484907312/photo/gold-bangles-on-white-background.webp?b=1&s=170667a&w=0&k=20&c=0x5V5AxUQB5nKJU7Fbdr_aF6jLWwQLWnSr0kO77jX1s=",
        },
        {
          "catName": "Ring",
          "productAvailable": "Available 3598",
          "image": "https://media.istockphoto.com/id/1651942696/photo/diamond-ring-isolated-on-white-background.webp?b=1&s=170667a&w=0&k=20&c=sOaX2vYuPtkuJce37Umflp_Vwn-F4cd7ryx0ltEexsE=",
        }
      ],
    }
  };

  static Future<void> categoryListApi() async {
    final CategoryController categoryCon = Get.find<CategoryController>();
    GetCategoryModel model = GetCategoryModel.fromJson(categoryList);
    categoryCon.categoryList.value = model.data?.category ?? [];
  }
}
