import 'package:get/get.dart';

import '../../exports.dart';

class HomeController extends GetxController {
  RxList<String> bannerList = <String>[
    AppAssets.banner01,
    AppAssets.banner02,
    AppAssets.banner03,
    AppAssets.banner04,
    AppAssets.banner05,
  ].obs;

  List<Map<String, dynamic>> brandList = [
    {
      "image": 'https://media.designrush.com/tinymce_images/316674/conversions/Desiree-Qelaj-content.jpg',
      "brandName": "OroKraft",
    },
    {
      "image": 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVErxeqhTxrd4NYxO73norO2MWmwcziMvFWg&s',
      "brandName": "Rare Solitaire",
    },
    {
      "image": 'https://media.designrush.com/tinymce_images/316671/conversions/Juliana-Brasileiro---Design-de-Joias-content.jpg',
      "brandName": "Platinum",
    },
    {
      "image": 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlg1hJbN1MJxOP8emzbbcEtDiVsnvgsig2P9oL6xMBzn_gJAL1uPwqq0DatpdfBxGzzqI&usqp=CAU',
      "brandName": "Rang Tarang",
    },
  ];
}
