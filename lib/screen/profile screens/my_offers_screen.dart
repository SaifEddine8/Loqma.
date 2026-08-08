import 'package:flutter/material.dart';
import 'package:loqma/constant/constant_colors.dart';
import 'package:loqma/constant/constant_style.dart';
import 'package:loqma/custom_widget/item_card.dart';
import 'package:loqma/db/offers_db.dart';
import 'package:loqma/db/user_db.dart';
import 'package:loqma/models/offer_model.dart';

class MyOffersScreen extends StatelessWidget {
  const MyOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
final double itemWidth = (screenWidth - 32 - 10) / 2;
final double requiredItemHeight = 143 + 140;
final double dynamicAspectRatio = itemWidth / requiredItemHeight;
    List<Offer> myOffers = offersNotifier.value.where((offer) => offer.ownerId==currentUser?.id).toList();

    return Scaffold(
      backgroundColor: ConstantColors.tertiaryColor,
      appBar: AppBar(
        title:  Text('My Offers',style: ConstantStyle.screentitleStyle,),
        centerTitle: true,
        backgroundColor: ConstantColors.tertiaryColor,
      ),
      

      body: myOffers.isEmpty?
      Center(child: Text('No offers found'))
      :
      Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio:dynamicAspectRatio
                    ), 
                    
                itemCount: myOffers.length,
                itemBuilder:(context,index)=> ItemCard(offer: myOffers[index],)
                 ),
      ),
     
    );
  }
}