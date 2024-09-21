import 'package:get/get.dart';

class ProductInfoController extends GetxController {
  RxList<Map<String, dynamic>> productDetails = <Map<String, dynamic>>[].obs;

  /// Formate info key
  String formatKey(String key) {
    List<String> words = key.split('_');

    // If no underscores are present, split the key into individual words
    if (words.length == 1) {
      words = key.split(' ');
    }

    List<String> capitalizedWords = words.map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();

    // Ensure the second word is capitalized if it exists
    if (capitalizedWords.length > 1) {
      capitalizedWords[1] = capitalizedWords[1][0].toUpperCase() + capitalizedWords[1].substring(1).toLowerCase();
    }

    return capitalizedWords.join(' ');
  }

  @override
  void onReady() {
    // super.onReady();
  }
}
