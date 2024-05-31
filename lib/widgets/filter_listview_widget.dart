import 'package:flutter/material.dart';
import 'package:pingaksh_mobile/widgets/checkbox_title_tile.dart';

import '../exports.dart';

class FilterListViewWidget extends StatelessWidget {
  final List<Map<String, dynamic>> filterTabList;
  const FilterListViewWidget({super.key, required this.filterTabList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const RangeMaintainingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
      itemBuilder: (context, index) => CheckBoxWithTitleTile(
        title: filterTabList[index]["title"],
        isCheck: filterTabList[index]["isChecked"],
      ),
      separatorBuilder: (context, index) => Divider(
        height: defaultPadding / 2,
        indent: defaultPadding,
        endIndent: defaultPadding,
      ),
      itemCount: filterTabList.length,
    );
  }
}
