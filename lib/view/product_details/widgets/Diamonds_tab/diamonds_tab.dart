import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/model/product/products_model.dart';
import '../../../../exports.dart';

class DiamondsTab extends StatelessWidget {
  final List<DiamondListModel> diamondList;

  const DiamondsTab({super.key, required this.diamondList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(bottom: defaultPadding * 2),
        child: Table(
          border: TableBorder.all(color: Theme.of(context).dividerColor.withOpacity(0.15)),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: IntrinsicColumnWidth(), // Clarity
            1: IntrinsicColumnWidth(), // Shape
            2: IntrinsicColumnWidth(), // Size
            3: IntrinsicColumnWidth(), // Wts
            4: IntrinsicColumnWidth(), // Qty
            5: IntrinsicColumnWidth(), // Amt
          },
          children: [
            // Header row
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface.withOpacity(0.5)),
              children: [
                Padding(
                  padding: EdgeInsets.all(defaultPadding / 3),
                  child: Text('Clarity', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding / 3),
                  child: Text('Shape', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding / 3),
                  child: Text('Size', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding / 3),
                  child: Text('Wts', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding / 3),
                  child: Text('Qty', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding / 3),
                  child: Text('Amt', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            // Data rows
            ...diamondList.map((diamond) => TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultPadding / 3),
                      child: Text(
                        diamond.diamondClarity?.value ?? '-',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding / 3),
                      child: Text(
                        diamond.diamondShape ?? '-',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding / 3),
                      child: Text(
                        diamond.size?.diamondSlieveSize ?? '-',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding / 3),
                      child: Text(
                        diamond.diamondWeight?.toString() ?? '-',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding / 3),
                      child: Text(
                        diamond.diamondCount?.toString() ?? '-',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding / 3),
                      child: Text(
                        UiUtils.amountFormat(diamond.totalPrice ?? 0, decimalDigits: 2),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12.sp),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
