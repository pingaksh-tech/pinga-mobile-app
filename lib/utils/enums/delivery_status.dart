import 'package:get/get.dart';

enum DeliveryStatus {
  orderPlaced(label: 'Order Placed'),
  pickupRequest(label: 'Pick Up Request'),
  pickedup(label: 'Picked Up'),
  dispatched(label: 'Dispatched'),
  onTheWay(label: 'On The Way'),
  delivered(label: 'Delivered');

  final String label;

  const DeliveryStatus({required this.label});

  static DeliveryStatus fromString(String value) {
    return DeliveryStatus.values.firstWhereOrNull((e) => e.name == value) ?? DeliveryStatus.orderPlaced;
  }
}
