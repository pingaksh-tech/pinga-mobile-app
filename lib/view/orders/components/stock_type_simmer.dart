import 'package:flutter/material.dart';

import '../../../exports.dart';

class StockTypeSimmer extends StatelessWidget {
  const StockTypeSimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerUtils.shimmer(
      child: Container(
        height: 30,
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2.5, vertical: defaultPadding / 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultPadding),
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.1), width: .7),
        ),
        child: Center(
          child: ShimmerUtils.shimmer(
            child: Container(
              height: 15,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultPadding),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.1), width: .7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
