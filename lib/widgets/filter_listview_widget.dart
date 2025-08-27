import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/model/common/splash_model.dart';
import '../exports.dart';
import '../view/products/widgets/filter/filter_controller.dart';
import 'custom_check_box_tile.dart';

class FilterListViewWidget extends StatefulWidget {
  final FilterItemType type;
  final List<Map<String, dynamic>>? filterTabList;
  final List<String>? deliveryList;
  final List<DiamondModel>? diamondList;
  final List<MetalModel>? metalList;
  final List<CollectionModel>? collectionList;
  final Function() onSelect;

  const FilterListViewWidget({super.key, required this.type, this.filterTabList, this.diamondList, this.deliveryList, this.metalList, required this.onSelect, this.collectionList});

  @override
  State<FilterListViewWidget> createState() => _FilterListViewWidgetState();
}

class _FilterListViewWidgetState extends State<FilterListViewWidget> {
  final FilterController filterCon = Get.find<FilterController>();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const RangeMaintainingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
      itemCount: switch (widget.type) {
        FilterItemType.diamond => widget.diamondList != null ? widget.diamondList!.length : 0,
        FilterItemType.delivery => widget.deliveryList != null ? widget.deliveryList!.length : 0,
        FilterItemType.production => widget.deliveryList != null ? widget.deliveryList!.length : 0,
        FilterItemType.kt => widget.metalList != null ? widget.metalList!.length : 0,
        FilterItemType.collection => widget.collectionList != null ? widget.collectionList!.length : 0,
        FilterItemType.range => 0,
        FilterItemType.mrp => 0,
        FilterItemType.available => 0,
        FilterItemType.gender => 0,
        FilterItemType.retailers => 0,
      },
      itemBuilder: (context, index) => CustomCheckboxTile(
        scale: 1,
        title: switch (widget.type) {
          FilterItemType.diamond => widget.diamondList?[index].name ?? "",
          FilterItemType.delivery => widget.deliveryList?[index] ?? "",
          FilterItemType.production => widget.deliveryList?[index] ?? "",
          FilterItemType.kt => widget.metalList?[index].name ?? "",
          FilterItemType.collection => widget.collectionList?[index].name ?? "",
          FilterItemType.range => "",
          FilterItemType.mrp => "",
          FilterItemType.available => "",
          FilterItemType.gender => "",
          FilterItemType.retailers => "",
        },
        isSelected: switch (widget.type) {
          FilterItemType.diamond => RxBool(filterCon.selectedDiamonds.contains(widget.diamondList?[index].name)),
          FilterItemType.delivery => RxBool(filterCon.selectedDelivery.contains(widget.deliveryList?[index])),
          FilterItemType.production => RxBool(filterCon.selectedProductNames.contains(widget.deliveryList?[index])),
          FilterItemType.kt => RxBool(filterCon.selectedKt.contains(widget.metalList?[index].id?.value ?? "")),
          FilterItemType.collection => RxBool(filterCon.selectedCollections.contains(widget.collectionList?[index].id)),
          FilterItemType.range => false.obs,
          FilterItemType.mrp => false.obs,
          FilterItemType.available => false.obs,
          FilterItemType.gender => false.obs,
          FilterItemType.retailers => false.obs,
        },
        onChanged: (val) {
          switch (widget.type) {
            case FilterItemType.diamond:
              if (filterCon.selectedDiamonds.contains(widget.diamondList?[index].name)) {
                filterCon.selectedDiamonds.remove(widget.diamondList?[index].name);
                filterCon.count--;
              } else {
                filterCon.count++;
                filterCon.selectedDiamonds.add(widget.diamondList?[index].name ?? "");
              }
              printOkStatus(filterCon.count);
              break;

            case FilterItemType.delivery:
              if (filterCon.selectedDelivery.contains(widget.deliveryList?[index])) {
                filterCon.selectedDelivery.remove(widget.deliveryList?[index]);
                filterCon.count--;
              } else {
                filterCon.count++;
                filterCon.selectedDelivery.add(widget.deliveryList?[index] ?? "");
              }
              break;

            case FilterItemType.production:
              if (filterCon.selectedProductNames.contains(widget.deliveryList?[index])) {
                filterCon.selectedProductNames.remove(widget.deliveryList?[index]);
                filterCon.count--;
              } else {
                filterCon.count++;
                filterCon.selectedProductNames.add(widget.deliveryList?[index] ?? "");
              }
              break;

            case FilterItemType.kt:
              if (filterCon.selectedKt.contains(widget.metalList?[index].id?.value ?? "")) {
                filterCon.selectedKt.remove(widget.metalList?[index].id?.value ?? "");
                filterCon.count--;
              } else {
                filterCon.count++;
                filterCon.selectedKt.add(widget.metalList?[index].id?.value ?? "");
              }
              break;

            case FilterItemType.collection:
              if (filterCon.selectedCollections.contains(widget.collectionList?[index].id)) {
                filterCon.selectedCollections.remove(widget.collectionList?[index].id);
                filterCon.count--;
              } else {
                filterCon.count++;
                filterCon.selectedCollections.add(widget.collectionList?[index].id ?? "");
              }
              break;

            case FilterItemType.range:
              break;

            case FilterItemType.mrp:
              break;

            case FilterItemType.available:
              break;

            case FilterItemType.gender:
              break;
            case FilterItemType.retailers:
              break;
          }

          widget.onSelect();
        },
      ),
      separatorBuilder: (context, index) => Divider(
        height: defaultPadding / 2,
        indent: defaultPadding,
        endIndent: defaultPadding,
      ),
    );
  }
}
