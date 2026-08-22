import 'package:loqma/models/order_model.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime date;
  final String receiverId;
  final OrderModel? order;
  final double? penaltyAmount;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.receiverId,
    this.order,
    this.penaltyAmount,
  });

  bool get isReceipt => order != null;

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? date,
    String? receiverId,
    OrderModel? order,
    double? penaltyAmount,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      date: date ?? this.date,
      receiverId: receiverId ?? this.receiverId,
      order: order ?? this.order,
      penaltyAmount: penaltyAmount ?? this.penaltyAmount,
    );
  }
}