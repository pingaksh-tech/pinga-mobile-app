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

  final List<String> imgList = [
    'https://media.designrush.com/tinymce_images/316674/conversions/Desiree-Qelaj-content.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVErxeqhTxrd4NYxO73norO2MWmwcziMvFWg&s',
    'https://media.designrush.com/tinymce_images/316671/conversions/Juliana-Brasileiro---Design-de-Joias-content.jpg',
    'https://mir-s3-cdn-cf.behance.net/projects/404/82a27390100689.Y3JvcCw0MDE5LDMxNDMsNTg2LDY5.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlg1hJbN1MJxOP8emzbbcEtDiVsnvgsig2P9oL6xMBzn_gJAL1uPwqq0DatpdfBxGzzqI&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4MJT-OT0a1HXFBgWaKIDyV0-eU-n-qXLhTw&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQers3oGbMq-Ij2sssFAisAOD5r5j7N5c5yQw&s',
    'https://images.pexels.com/photos/691046/pexels-photo-691046.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/1458867/pexels-photo-1458867.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://media.designrush.com/tinymce_images/316674/conversions/Desiree-Qelaj-content.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVErxeqhTxrd4NYxO73norO2MWmwcziMvFWg&s',
    'https://media.designrush.com/tinymce_images/316671/conversions/Juliana-Brasileiro---Design-de-Joias-content.jpg',
  ];
}
