import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loqma/screen/cart_screen.dart';
import 'package:loqma/screen/delivery_screen.dart';

class DeliveryIcon extends StatelessWidget {
  const DeliveryIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()  
      {
        
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryScreen()));
      },
      child: Icon(Icons.delivery_dining,color: Colors.white,));
  }
  }
