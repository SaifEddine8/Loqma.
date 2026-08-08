import 'package:flutter/material.dart';
import 'package:loqma/constant/constant_style.dart';
import 'package:loqma/custom_widget/cart_card_screen.dart';
import 'package:loqma/provider/offer%20providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  
  @override
  Widget build(BuildContext context) {
    final cartProvider=context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart',style: ConstantStyle.screentitleStyle,),
        centerTitle: true,
      ),
      body:Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: cartProvider.offers.length,
          itemBuilder:(context,index)=>Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CartCardScreen(offer:cartProvider.offers[index]),
          ) 
          ),
          
      ),
    );
  }
}