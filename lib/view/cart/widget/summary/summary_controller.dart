import 'package:get/get.dart';

import '../../../../data/model/cart/cart_summary_model.dart';
import '../../../../data/repositories/cart/cart_repository.dart';

class SummaryController extends GetxController {
  RxList<DiamondSummaryModel> diamondSummaryList = <DiamondSummaryModel>[].obs;
  Rx<TotalDeliverySummary> totalDiamond = TotalDeliverySummary().obs;

  RxList<WeightSummaryModel> weightSummaryList = <WeightSummaryModel>[].obs;
  Rx<TotalWeightSummary> totalWeight = TotalWeightSummary().obs;
  RxBool isLoading = true.obs;
  @override
  void onReady() {
    super.onReady();
    CartRepository.getCartSummaryAPI(isLoader: isLoading);
  }
}
