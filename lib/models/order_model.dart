import 'package:loqma/models/offer_model.dart';

class OrderModel {
  final String orderId;
  final String userId;
  final Map<Offer, int> orderedItems; 
  final double subTotal;
  final double tax;
  final double totalPrice;
  final DateTime orderDate;

  final String? volunteerId;
  final String? volunteerName;
  final String? volunteerPhone;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.orderedItems,
    required this.subTotal,
    required this.tax,
    required this.totalPrice,
    required this.orderDate,
    this.volunteerId,
    this.volunteerName,
    this.volunteerPhone,
  });
}