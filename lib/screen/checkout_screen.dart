import 'package:flutter/material.dart';
import 'package:loqma/constant/constant_colors.dart';
import 'package:loqma/db/user_db.dart';
import 'package:loqma/provider/offer%20providers/cart_provider.dart';
import 'package:loqma/provider/update_user_provider.dart';
import 'package:provider/provider.dart';
import 'package:loqma/models/order_model.dart';

class CheckoutScreen extends StatefulWidget {
  final String currentUserId;

  const CheckoutScreen({Key? key, required this.currentUserId}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: cartProvider.cartItems.isEmpty
          ? const Center(child: Text('The cart is currently empty'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Request Summary:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartProvider.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartProvider.cartItems[index];
                        final qty = cartProvider.getQuantity(item);
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(item.title),
                            subtitle: Text('Quantity: $qty × ${item.price ?? 0} JD'),
                            trailing: Text('${((item.price ?? 0) * qty).toStringAsFixed(2)} JD'),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 24),

                    const Text('Payment card information:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    
                    TextFormField(
                      controller: _cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Card Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                        prefixIcon: Icon(Icons.credit_card),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 16) {
                          return 'Please enter a valid 16-digit card number.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: _expiryDateController,
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Expiry date',
                              hintText: 'MM/YY',
                              prefixIcon: Icon(Icons.date_range),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty || !value.contains('/')) {
                                return 'Incorrect format';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: _cvvController,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'CVV',
                              hintText: '***',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty || value.length < 3) {
                                return 'Short code';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 32),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total required:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('${cartProvider.total.toStringAsFixed(2)} JD', 
                               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ConstantColors.primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String cardNumber = _cardNumberController.text;
                            String expiryDate = _expiryDateController.text;
                            String securityCode = _cvvController.text;
                            
                            print("Processing simulated transaction for User: ${widget.currentUserId}");
                            print("Captured Card Info internally -> Number: $cardNumber, Expiry: $expiryDate");

                            OrderModel? completedOrder = cartProvider.processCheckout(
                              currentUser: context.read<UpdateUserProvider>().currentUser!,
                              allUsers: users
                            );
                            
                            if (completedOrder != null) {
                              _showReceiptDialog(context, completedOrder);
                            }
                          }
                        },
                        child: const Text(
                          'Confirm payment',
                          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _showReceiptDialog(BuildContext context, OrderModel order) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Payment made and receipt issued.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Transaction ID: #${order.orderId}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Payment Status: Simulated Success',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const Divider(height: 20),
                  const Text(
                    'Received Items:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 8),

                  ...order.orderedItems.entries.map((entry) {
                    final offer = entry.key;
                    final quantity = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text(
                              '${offer.title} (Quantity: $quantity) - Offered by: ${offer.volunteerId ?? "Restaurant"}',
                              style: const TextStyle(fontSize: 13, height: 1.3),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Amount:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        'JOD ${order.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 16,
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
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Close and Return'),
          ),
        ],
      ),
    );
  }
}