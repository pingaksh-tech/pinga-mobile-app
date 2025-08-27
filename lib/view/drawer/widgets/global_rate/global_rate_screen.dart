import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/global_rate/global_rate_repositories.dart';
import '../../../../exports.dart';
import '../../../../res/app_bar.dart';
import 'global_rate_controller.dart';

class GlobalRateScreen extends StatelessWidget {
  GlobalRateScreen({super.key});

  final GlobalRateController con = Get.put(GlobalRateController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: MyAppBar(
          title: "Global Rate",
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(top: defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Current Rate ",
                    style: AppTextStyle.textFieldStyle(context),
                  ),
                  Text(
                    "${LocalStorage.priceRate} %",
                    style: AppTextStyle.textFieldStyle(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            AppTextField(
              title: "Set Global Rate (%)",
              hintText: "Enter rate",
              contentPadding: EdgeInsets.all(defaultPadding / 1.2),
              padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(top: defaultPadding),
              textInputAction: TextInputAction.done,
              maxLines: 1,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(defaultRadius),
                ),
                borderSide: BorderSide.none,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'(^\d*\.?\d{0,2})'),
                ),
              ],
              keyboardType: TextInputType.phone,
              controller: con.rateCon.value,
              validation: con.rateValidation.value,
              errorMessage: con.rateError.value,
              onChanged: (value) {
                con.checkDisableButton();
                if (value.isNotEmpty) {
                  con.checkValidation(value);
                }
              },
            ),

            // Obx(() {
            //   return con.loader.isFalse
            //       ? con.globalRateList.isNotEmpty
            //           ? ListView.separated(
            //               shrinkWrap: true,
            //               physics: const NeverScrollableScrollPhysics(),
            //               itemCount: con.globalRateList.length,
            //               separatorBuilder: (context, index) => const Divider(),
            //               itemBuilder: (context, index) {
            //                 final rate = con.globalRateList[index];
            //                 return ListTile(
            //                   title: Text(rate.name ?? "No Name"),
            //                   subtitle: Text("Rate: ${rate.rate}"),
            //                   trailing: Text("Date: ${rate.date}"),
            //                 );
            //               },
            //             )
            //           : Center(child: Text("No Global Rates available"))
            //       : Center(child: CircularProgressIndicator());
            // }),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: AppButton(
            title: "Update",
            disableButton: con.disableButton.value,
            loader: con.isLoading.value,
            padding: EdgeInsets.all(defaultPadding).copyWith(bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
            onPressed: () {
              FocusScope.of(context).unfocus();

              if (con.checkValidation(con.rateCon.value.text.trim())) {
                GlobalRateRepositories.updateRateApi(isLoader: con.isLoading, userRate: con.rateCon.value.text.trim()).then(
                  (value) {
                    Get.back();
                    if (con.rateCon.value.text.trim().isNotEmpty) {
                      LocalStorage.setPriceRate(
                        priceRate: con.rateCon.value.text.trim(),
                      );
                      // LocalStorage.userModel.pricePercentage?.value = int.parse(con.rateCon.value.text.trim());
                    }
                    Get.back();
                  },
                );
              }
            },
          ),
        ),
      );
    });
  }
}
