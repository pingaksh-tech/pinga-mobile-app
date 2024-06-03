import 'package:get/get.dart';

class ProductInfoController extends GetxController {
  RxList<Map<String, String>> productDetails = [
    {"Metal": "Gold"},
    {"Karatage": "18KT"},
    {"Metal Wt": "6.4"},
    {"Brand": "KISNA FG"},
    {"Category": "RINGS"},
    {"Collection": "Flora"},
    {"Default color": "Yellow"},
    {"Stone": "Diamond"},
    {"Stone quality": "VVS-FG"},
    {"Stone shape": "ROUND"},
    {"Stone Wt": "0.66"},
    {"Diamond quantity": "19"},
    {"Gross Wt": "6,53"},
    {"Approx delivery": "15 Days"}
  ].obs;
}
