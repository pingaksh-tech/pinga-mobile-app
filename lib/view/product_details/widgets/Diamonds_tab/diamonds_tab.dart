import 'package:flutter/material.dart';

import '../../../../data/model/product/products_model.dart';
import '../../../../exports.dart';

class DiamondsTab extends StatelessWidget {
  final List<DiamondListModel> diamondList;

  const DiamondsTab({super.key, required this.diamondList});

  @override
  Widget build(BuildContext context) {
    return /* SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: */
        Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(bottom: defaultPadding * 2),
      child: Table(
        border: TableBorder.all(color: Theme.of(context).dividerColor.withOpacity(0.15)),
        defaultVerticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
        columnWidths: const {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(3),
          2: FlexColumnWidth(2.5),
          3: FlexColumnWidth(2.5),
          4: FlexColumnWidth(2),
          5: FlexColumnWidth(4),
        },
        // columnWidths: const {
        //   0: IntrinsicColumnWidth(), // Clarity
        //   1: IntrinsicColumnWidth(), // Shape
        //   2: IntrinsicColumnWidth(), // Size
        //   3: IntrinsicColumnWidth(), // Wts
        //   4: IntrinsicColumnWidth(), // Qty
        //   5: IntrinsicColumnWidth(), // Amt
        // },
        children: [
          // Header row
          TableRow(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface.withOpacity(0.5)),
            children: [
              Padding(
                padding: EdgeInsets.all(defaultPadding / 3),
                child: Text('Clarity', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(defaultPadding / 3),
                child: Text('Shape', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(defaultPadding / 3),
                child: Text('Size', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(defaultPadding / 3),
                child: Text('Wts', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(defaultPadding / 3),
                child: Text('Qty', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(defaultPadding / 3),
                child: Text('Amt', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          // Data rows
          ...diamondList.map((diamond) => TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultPadding / 3),
                    child: Center(
                      child: Text(
                        diamond.diamondClarity?.value ?? '-',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding / 3),
                    child: Center(
                      child: Text(
                        diamond.diamondShape ?? '-',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding / 3),
                    child: Center(
                      child: Text(
                        diamond.size?.diamondSlieveSize ?? '-',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding / 3),
                    child: Center(
                      child: Text(
                        diamond.diamondWeight?.toString() ?? '-',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding / 3),
                    child: Center(
                      child: Text(
                        diamond.diamondCount?.toString() ?? '-',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding / 3),
                    child: Center(
                      child: Text(
                        UiUtils.amountFormat(diamond.totalPrice ?? 0, decimalDigits: 2),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
      // ),
    );
  }
}
