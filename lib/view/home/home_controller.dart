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
      "brandName": "Pingaksh",
    },
    {
      "image": 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVErxeqhTxrd4NYxO73norO2MWmwcziMvFWg&s',
      "brandName": "Fancy Diamond Collection",
    },
    {
      "image": 'https://media.designrush.com/tinymce_images/316671/conversions/Juliana-Brasileiro---Design-de-Joias-content.jpg',
      "brandName": "Solitare",
    },
    {
      "image": 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlg1hJbN1MJxOP8emzbbcEtDiVsnvgsig2P9oL6xMBzn_gJAL1uPwqq0DatpdfBxGzzqI&usqp=CAU',
      "brandName": "Platinum",
    },
    {
      "image": 'https://t4.ftcdn.net/jpg/06/97/08/63/360_F_697086368_rNvfF1rJJefEaY5Bxrdckclv6h8H4nQH.jpg',
      "brandName": "Rangtrang",
    },
  ];
}
