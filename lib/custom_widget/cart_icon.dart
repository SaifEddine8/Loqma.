import 'package:flutter/material.dart';
import 'package:loqma/screen/cart_screen.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()  
      {
        
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
      },
      child: Icon(Icons.shopping_cart_outlined,color: Colors.white,));
  }
}