import 'package:loqma/models/order_model.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime date;
  
  final OrderModel? order;

  final double? penaltyAmount;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    this.order,
    this.penaltyAmount,
  });

  bool get isReceipt => order != null;
}