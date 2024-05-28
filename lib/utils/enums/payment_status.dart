import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PaymentStatus {
  none(id: -1, color: Colors.yellow),
  unpaid(id: 0, color: Colors.yellow),
  paid(id: 1, color: Colors.green),
  failed(id: 2, color: Colors.redAccent);

  final int id;
  final Color color;
  const PaymentStatus({
    required this.id,
    required this.color,
  });

  static PaymentStatus formId(int id) {
    return PaymentStatus.values.firstWhereOrNull((e) => e.id == id) ?? PaymentStatus.none;
  }
}

enum PaymentType {
  partial('50% Payment'),
  full('100% Payment');

  final String label;
  const PaymentType(this.label);
}

enum BankPaymentType { neft, rtgs }
