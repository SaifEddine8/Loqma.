import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loqma/constant/constant_colors.dart';
import 'package:loqma/db/offers_db.dart';
import 'package:loqma/models/offer_model.dart';
import 'package:loqma/provider/offer%20providers/favorite_offer_provider.dart';

import 'package:provider/provider.dart';

class ItemCard extends StatefulWidget {
  final Offer offer;
   ItemCard({
    super.key,
    required this.offer,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          // افتح صفحة التفاصيل
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// الصورة
            Stack(
              children: [

                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrOjwDT1psaP5bz_sw0Le14wmWViiyRytwJY-529Atyg&s=10',
                    height: MediaQuery.of(context).size.height/5.5,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: InkWell(
                      onTap: () 
                      {
                        context.read<FavoriteOfferProvider>().toggleFavorite(widget.offer);

                        
                      } 
                      
                      ,
                    
                        child: Consumer<FavoriteOfferProvider>(
                          builder: (context, value, child) => 
                          Icon(
                            value.offers.contains(widget.offer)? Icons.favorite:Icons.favorite_border,
                            size: 18,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                

                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: widget.offer.type==OfferType.donation
                          ? Colors.green
                          : Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.offer.type==OfferType.donation
                          ? "Donation"
                          : "Sale",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    /// الاسم
                    Text(
                      widget.offer.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),

                    /// الكمية
                    Row(
                      children: [
                        const Icon(Icons.fastfood, size: 16),
                        const SizedBox(width: 5),
                        Text("${widget.offer.quantity} meals"),
                      ],
                    ),

                    /// تاريخ الانتهاء
                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          "${widget.offer.expiryDate.day}/${widget.offer.expiryDate.month} Exp",
                        ),
                      ],
                    ),

                    /// السعر
                    if (widget.offer.type==OfferType.sale)
                      Row(
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
                            style: TextStyle(
                              color: ConstantColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      )
                    else
                      Text(
                        "FREE",
                        style: TextStyle(
                          color: ConstantColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}