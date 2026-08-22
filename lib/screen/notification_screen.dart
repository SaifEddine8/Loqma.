import 'package:flutter/material.dart';
import 'package:loqma/db/user_db.dart';
import 'package:loqma/provider/offer%20providers/delivery_provider.dart';
import 'package:loqma/screen/order_details_screen.dart';
import 'package:loqma/services/local_notification_services.dart';
import 'package:provider/provider.dart';
import 'package:loqma/provider/offer%20providers/cart_provider.dart';
import 'package:loqma/models/order_model.dart';
import 'package:loqma/models/notification_model.dart';

class ReceiptsHistoryScreen extends StatefulWidget {
  final String currentUserId;

  const ReceiptsHistoryScreen({Key? key, required this.currentUserId}) : super(key: key);

  @override
  State<ReceiptsHistoryScreen> createState() => _ReceiptsHistoryScreenState();
}

class _ReceiptsHistoryScreenState extends State<ReceiptsHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DeliveryProvider>(context, listen: false)
          .checkAndApplyExpiredPenalties(widget.currentUserId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    final myOrders = cartProvider.getMyOrders(widget.currentUserId);
    final userNotifications = LocalNotificationService.getNotificationsForUser(widget.currentUserId);
    final List<dynamic> combinedList = [
      ...myOrders,
      ...userNotifications,
    ];

    combinedList.sort((a, b) {
      DateTime dateA = a is OrderModel ? a.orderDate : (a as NotificationModel).date;
      DateTime dateB = b is OrderModel ? b.orderDate : (b as NotificationModel).date;
      return dateB.compareTo(dateA);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications & Receipts', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: combinedList.isEmpty
          ? const Center(
              child: Text(
                'No receipts or notifications currently.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: combinedList.length,
              itemBuilder: (context, index) {
                final item = combinedList[index];

                // 🔔 1. عرض الإشعارات
                if (item is NotificationModel) {
                  bool isFine = item.penaltyAmount != null && item.penaltyAmount! > 0;

                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    color: isFine ? Colors.red.shade50 : Colors.blue.shade50,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isFine ? Colors.red.shade100 : Colors.blue.shade100,
                        child: Icon(
                          isFine ? Icons.warning_amber_rounded : Icons.local_shipping,
                          color: isFine ? Colors.red : Colors.blue,
                        ),
                      ),
                      title: Text(
                        item.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isFine ? Colors.red.shade900 : Colors.blue.shade900,
                        ),
                      ),
                      subtitle: Text(
                        '${item.message}\nDate: ${item.date.toString().substring(0, 16)}',
                        style: const TextStyle(height: 1.4),
                      ),
                      trailing: item.order != null 
                          ? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey)
                          : null,
                          
                      // ⚡ ⚡ الربط الجديد المفكوك: نقل المتطوع لشاشة التفاصيل عند الضغط على الإشعار ⚡ ⚡
                      onTap: () {
                        if (item.order != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetailsScreen(order: item.order!),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('No details available for this notification')),
                          );
                        }
                      },
                    ),
                  );
                }

                // 🧾 2. عرض الفواتير والطلبات
                final order = item as OrderModel;
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 220, 245, 221),
                      child: Icon(Icons.receipt, color: Colors.green),
                    ),
                    title: Text(
                      'Successful Order #${order.orderId}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Date: ${order.orderDate.toString().substring(0, 16)}\nTotal: ${order.totalPrice.toStringAsFixed(2)} JOD',
                      style: const TextStyle(height: 1.4),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    onTap: () {
                      _showOrderDetailsDialog(context, order);
                    },
                  ),
                );
              },
            ),
    );
  }

  void _showOrderDetailsDialog(BuildContext context, OrderModel order) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.receipt_long, color: Colors.green, size: 26),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Order Details #${order.orderId}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.65,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.delivery_dining, color: Colors.blue, size: 20),
                            SizedBox(width: 6),
                            Text(
                              'Assigned Delivery Volunteer:',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Name: ${order.volunteerName ?? "Not Specified"}',
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Phone: ${order.volunteerPhone ?? "N/A"}',
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ordered Items:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 8),
                  ...order.orderedItems.entries.map((entry) {
                    final offer = entry.key;
                    final quantity = entry.value;
                    double itemTotal = (offer.price ?? 0) * quantity;

                    // ⚡ البحث عن صاحب العرض آمن وبدون استخدام ownerId المفقود
                    final ownerUser = users.firstWhere(
                      (u) => u.id == offer.volunteerId,
                      orElse: () => users.first,
                    );

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Meal: ${offer.title}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                              ),
                              Text(
                                '${itemTotal.toStringAsFixed(2)} JOD',
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Quantity: $quantity × ${offer.price ?? 0} JOD',
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Offered by: ${ownerUser.fullName}', // 👈 اسم صاحب العرض
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Amount:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      Text(
                        '${order.totalPrice.toStringAsFixed(2)} JOD',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}