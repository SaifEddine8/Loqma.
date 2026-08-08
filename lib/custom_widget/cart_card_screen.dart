import 'package:flutter/material.dart';
import 'package:loqma/constant/constant_style.dart';
import 'package:loqma/models/offer_model.dart';
import 'package:loqma/provider/offer%20providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartCardScreen extends StatelessWidget {
  Offer offer;
   CartCardScreen({super.key,required this.offer});

  @override
  Widget build(BuildContext context) {
    final h=MediaQuery.of(context).size.height;
    final w=MediaQuery.of(context).size.width;
    return Material(
      elevation: 10,
      shape: BeveledRectangleBorder(borderRadius: BorderRadiusGeometry.all(Radius.circular(12))),
      child: Container(
        height: h/6,
        // width: w/3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[300]
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(12)),
                child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrOjwDT1psaP5bz_sw0Le14wmWViiyRytwJY-529Atyg&s=10',)),
                Column(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(offer.title,style: ConstantStyle.titeStyle,),
      
                    Consumer<CartProvider>(
                      builder: (context, value, child) => 
                      Row(
                        spacing: 10,
                        children: [
                          InkWell(
                            
                            onTap: () => value.decreament(),
                            child: Icon(Icons.remove)),
                          Text(value.qu.toString()),
                      
                          InkWell(
                            onTap: () => value.increament(),
                            child: Icon(Icons.add))
                        ],
                      ),
                    ),
      
                    Row(
                          children: [
          
                            Text(
                              "${offer.originalPrice}",
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
          
                            const SizedBox(width: 6),
          
                            Text(
                              "${offer.price} JD",
                              style: ConstantStyle.priceStyle
                            ),
                          ],
                        )
                  ],
                ),
                Column(
                  mainAxisAlignment: .start,
                  children: [
                    InkWell(
                      onTap: () =>  context.read<CartProvider>().removeFromCart(offer),
                      child: Icon(Icons.delete,color: Colors.red,)),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}