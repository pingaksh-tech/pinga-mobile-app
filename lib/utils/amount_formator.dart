class AmountFormator {
  AmountFormator._();

  static num calculationFormator(num amount) {
    return num.tryParse(((amount * 100).floor() / 100).toStringAsFixed(2)) ?? 0;
  }
}
