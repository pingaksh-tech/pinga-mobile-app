import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pingaksh_mobile/res/app_bar.dart';
import 'package:pingaksh_mobile/view/collections/widgets/add_watchlist/add_watchlist_controller.dart';
import 'package:pingaksh_mobile/view/product/product_controller.dart';

import '../../../../exports.dart';
import '../../watch_list/components/watchlist_tile.dart';

class AddWatchlistScreen extends StatelessWidget {
  AddWatchlistScreen({super.key});

  final AddWatchlistController con = Get.put(AddWatchlistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Add to watch"),
      body: Obx(() {
        return ListView(
          physics: const RangeMaintainingScrollPhysics(),
          padding: EdgeInsets.all(defaultPadding),
          children: [
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 136.h),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: con.watchList.length,
              separatorBuilder: (context, index) => SizedBox(
                height: defaultPadding / 1.5,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Get.delete<ProductController>();
                  Get.toNamed(
                    AppRoutes.productScreen,
                    arguments: {"categoryName": con.watchList[index]['name']},
                  );
                },
                child: WatchlistTile(
                    name: con.watchList[index]['name'],
                    noOfItem: con.watchList[index]['no_of_item'],
                    createdBy: con.watchList[index]['created_by'],
                    isShowButtons: false,
                    selected: (con.watchList.indexWhere(
                              (e) => 0 == con.watchList[0]['id'],
                            ) ==
                            0)
                        ? con.select
                        : RxBool(false)),
              ),
            )
          ],
        );
      }),
      bottomSheet: Obx(() {
        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            AppTextField(
              title: "Add Watch list",
              hintText: "Enter watchlist name",
              contentPadding: EdgeInsets.all(defaultPadding / 1.2),
              padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(top: defaultPadding),
              textInputAction: TextInputAction.done,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(defaultRadius),
                ),
                borderSide: BorderSide.none,
              ),
              controller: con.nameCon.value,
              validation: con.nameValidation.value,
              errorMessage: con.nameError.value,
              onChanged: (value) {
                con.checkDisableButton();
              },
            ),
            AppButton(
              title: "Add",
              disableButton: con.disableButton.value,
              padding: EdgeInsets.all(defaultPadding).copyWith(bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (con.validate()) {
                  con.watchList.add(
                    {
                      'id': con.watchList.length.toString(),
                      'name': con.nameCon.value.text.trim(),
                      'no_of_item': 21,
                      'created_by': 'Guest',
                    },
                  );
                  con.nameCon.value.clear();
                }
              },
            ),
          ],
        );
      }),
    );
  }
}
