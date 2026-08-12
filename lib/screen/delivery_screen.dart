import 'package:flutter/material.dart';
import 'package:loqma/constant/constant_colors.dart';
import 'package:loqma/constant/constant_style.dart';
import 'package:loqma/custom_widget/cart_card_screen.dart';
import 'package:loqma/custom_widget/delivery_card.dart';
import 'package:loqma/provider/offer providers/cart_provider.dart';
import 'package:loqma/provider/offer%20providers/delivery_provider.dart';
import 'package:provider/provider.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    final deliveryProvider = context.watch<DeliveryProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Delivery',
          style: ConstantStyle.screentitleStyle,
        ),
      ),

      body: deliveryProvider.offers.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        size: 55,
                        color: Colors.grey.shade400,
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Your delivery is empty',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Looks like you haven’t added anything to your delivery yet.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    8,
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Your Delivery',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),

                      const Spacer(),

                      Text(
                        '${deliveryProvider.offers.length} items',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      8,
                      16,
                      20,
                    ),
                    itemCount: deliveryProvider.offers.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: DeliveryCard(
                        offer: deliveryProvider.offers[index],
                      ),
                    ),
                  ),
                ),

                
              ],
            ),
    );
  }
}