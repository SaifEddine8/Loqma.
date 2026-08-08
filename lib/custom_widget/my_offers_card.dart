import 'package:flutter/material.dart';
import 'package:loqma/constant/constant_colors.dart';
import 'package:loqma/models/offer_model.dart';

class MyOffersCard extends StatefulWidget {
final Offer offer;
   MyOffersCard({super.key, required this.offer});

  @override
  State<MyOffersCard> createState() => _MyOffersCardState();
}

class _MyOffersCardState extends State<MyOffersCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          ClipRRect(
            
            borderRadius: BorderRadiusGeometry.all( Radius.circular(18)),
            child: Image.network(widget.offer.image, width: 100, height: 100, fit: BoxFit.cover,)),
        ],
      ),
    );
  }
}