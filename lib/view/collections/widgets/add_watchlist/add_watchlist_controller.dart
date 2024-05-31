import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddWatchlistController extends GetxController {
  Rx<TextEditingController> nameCon = TextEditingController().obs;
  RxBool nameValidation = true.obs;
  RxString nameError = ''.obs;

  RxBool select = false.obs;

  RxList watchList = [
    {
      'id': '1',
      'name': "Numun",
      'no_of_item': 33,
      'created_by': "Personal",
    },
    {
      'id': '2',
      'name': "Binks",
      'no_of_item': 42,
      'created_by': "Guest login",
    },
    {
      'id': '3',
      'name': "Joker",
      'no_of_item': 21,
      'created_by': "Guest login",
    },
    {
      'id': '4',
      'name': "Milli",
      'no_of_item': 33,
      'created_by': "Personal",
    },
    {
      'id': '5',
      'name': "Pinkness",
      'no_of_item': 42,
      'created_by': "Guest login",
    },
    {
      'id': '6',
      'name': "Enlighted",
      'no_of_item': 21,
      'created_by': "Guest login",
    }
  ].obs;
}
