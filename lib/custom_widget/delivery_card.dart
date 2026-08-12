import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loqma/constant/constant_colors.dart';
import 'package:loqma/constant/constant_style.dart';
import 'package:loqma/custom_widget/cart_card_screen.dart';
import 'package:loqma/models/offer_model.dart';
import 'package:loqma/provider/offer%20providers/delivery_provider.dart';
import 'package:provider/provider.dart';

class DeliveryCard extends StatefulWidget {
  Offer offer;
  DeliveryCard({super.key,required this.offer});

  @override
  State<DeliveryCard> createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard> {
  @override
  Widget build(BuildContext context) {
final h=MediaQuery.of(context).size.height;
    final w=MediaQuery.of(context).size.width;
    return Column(
      children: [
        Stack(
          children: [
Material(
      elevation: 10,
      shape: BeveledRectangleBorder(borderRadius: BorderRadiusGeometry.all(Radius.circular(12))),
      child: Container(
        height: h/6,
        // width: w/3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[300]
        ),
        child: LayoutBuilder(
          builder: (context, constraints) => 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(12)),
                  child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrOjwDT1psaP5bz_sw0Le14wmWViiyRytwJY-529Atyg&s=10',height: constraints.maxHeight/1.3,)),
                  SizedBox(
                    width: constraints.maxWidth/2,
                    child: Column(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        // SizedBox(
                          // width: constraints.maxWidth/2,
                          // child: 
                          Text(widget.offer.title,style: ConstantStyle.titeStyle,
                          overflow: TextOverflow.ellipsis,
                          ),
                          // ),
                                    
                        Consumer<DeliveryProvider>(
                          builder: (context, value, child) => 
                          Row(
                            mainAxisAlignment: .center,
                            spacing: 10,
                            children: [
                              InkWell(
                                
                                onTap: () => value.decreament(widget.offer),
                                child: Icon(Icons.remove)),
                              Text(value.getQuantity(widget.offer).toString()),
                          
                              InkWell(
                                onTap: () => value.increament(widget.offer),
                                child: Icon(Icons.add))
                            ],
                          ),
                        ),
                                    
                        if (widget.offer.type==OfferType.sale)
                        Row(
                          mainAxisAlignment: .center,
                          children: [
                    
                            Text(
                              "${widget.offer.originalPrice}",
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                    
                            const SizedBox(width: 6),
                    
                            Text(
                              "${widget.offer.price} JD",
                              style: ConstantStyle.priceStyle
                            ),
                          ],
                        )
                      else
                        Text(
                          "FREE",
                          style: ConstantStyle.priceStyle
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: .start,
                    children: [
                      InkWell(
                        onTap: () =>  context.read<DeliveryProvider>().removeFromDelivery(widget.offer),
                        child: Icon(Icons.delete,color: Colors.red,)),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    ),
                Positioned(
              bottom: 10,
        
              right: 10,
              child: Container(
                alignment: .center,
                height: MediaQuery.of(context).size.height/20,
                width: MediaQuery.of(context).size.width/4,
                decoration: BoxDecoration(
                 color: Colors.amber[200],
                 borderRadius: BorderRadius.circular(12) 
                ),
                child: Consumer<DeliveryProvider>(
                  builder: (context, value, child) => 
                  Text(value.getStatus(widget.offer),style: TextStyle(color: ConstantColors.primaryColor),)),
              )
            ),
        
            
            
        
        
          ],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
                    backgroundColor: ConstantColors.primaryColor,
                    shape: RoundedSuperellipseBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    
                  ),
          
          onPressed: (){
            context.read<DeliveryProvider>().moveToNextStatus(widget.offer);
          }, child: Consumer<DeliveryProvider>(
          builder: (context, value, child) => 
          Text('N E X T',style: ConstantStyle.titeStyle.copyWith(color: ConstantColors.tertiaryColor),)))
      ],
    );
  }
}