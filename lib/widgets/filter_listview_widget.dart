import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/model/common/splash_model.dart';

import '../exports.dart';
import 'custom_check_box_tile.dart';

class FilterListViewWidget extends StatefulWidget {
  final FilterItemType type;
  final List<Map<String, dynamic>>? filterTabList;
  final List<String>? deliveryList;
  final List<DiamondModel>? diamondList;
  final List<MetalModel>? metalList;
  final List<CollectionModel>? collectionList;
  final Function(List<dynamic>) onSelect;

  const FilterListViewWidget({super.key, required this.type, this.filterTabList, this.diamondList, this.deliveryList, this.metalList, required this.onSelect, this.collectionList});

  @override
  State<FilterListViewWidget> createState() => _FilterListViewWidgetState();
}

class _FilterListViewWidgetState extends State<FilterListViewWidget> {
  List<dynamic> selectedFilter = [];

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
      },
      itemBuilder: (context, index) => CustomCheckboxTile(
        scale: 1,
        title: switch (widget.type) {
          FilterItemType.diamond => widget.diamondList?[index].name ?? "",
          FilterItemType.delivery => widget.deliveryList?[index] ?? "",
          FilterItemType.production => widget.deliveryList?[index] ?? "",
          FilterItemType.kt => widget.metalList?[index].metalCarat ?? "",
          FilterItemType.collection => widget.collectionList?[index].name ?? "",
          FilterItemType.range => "",
          FilterItemType.mrp => "",
          FilterItemType.available => "",
          FilterItemType.gender => "",
        },
        isSelected: switch (widget.type) {
          FilterItemType.diamond => RxBool(selectedFilter.contains(widget.diamondList?[index].name)),
          FilterItemType.delivery => RxBool(selectedFilter.contains(widget.deliveryList?[index])),
          FilterItemType.production => RxBool(selectedFilter.contains(widget.deliveryList?[index])),
          FilterItemType.kt => RxBool(selectedFilter.contains(widget.metalList?[index].id)),
          FilterItemType.collection => RxBool(selectedFilter.contains(widget.collectionList?[index].id)),
          FilterItemType.range => false.obs,
          FilterItemType.mrp => false.obs,
          FilterItemType.available => false.obs,
          FilterItemType.gender => false.obs,
        },
        onChanged: (val) {
          switch (widget.type) {
            case FilterItemType.diamond:
              if (selectedFilter.contains(widget.diamondList?[index].name)) {
                selectedFilter.remove(widget.diamondList?[index].name);
              } else {
                selectedFilter.add(widget.diamondList?[index].name);
              }

              break;

            case FilterItemType.delivery:
              if (selectedFilter.contains(widget.deliveryList?[index])) {
                selectedFilter.remove(widget.deliveryList?[index]);
              } else {
                selectedFilter.add(widget.deliveryList?[index]);
              }
              break;

            case FilterItemType.production:
              if (selectedFilter.contains(widget.deliveryList?[index])) {
                selectedFilter.remove(widget.deliveryList?[index]);
              } else {
                selectedFilter.add(widget.deliveryList?[index]);
              }
              break;

            case FilterItemType.kt:
              if (selectedFilter.contains(widget.metalList?[index].id)) {
                selectedFilter.remove(widget.metalList?[index].id);
              } else {
                selectedFilter.add(widget.metalList?[index].id?.value);
              }
              break;

            case FilterItemType.collection:
              if (selectedFilter.contains(widget.collectionList?[index].id)) {
                selectedFilter.remove(widget.collectionList?[index].id);
              } else {
                selectedFilter.add(widget.collectionList?[index].id);
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
          }

          widget.onSelect(selectedFilter);
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
