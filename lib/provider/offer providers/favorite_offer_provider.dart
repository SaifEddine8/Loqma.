import 'package:flutter/material.dart';
import 'package:loqma/models/offer_model.dart';

class FavoriteOfferProvider with ChangeNotifier{
  final List<Offer> _offers=[];
  List<Offer> get offers=>_offers;

  void toggleFavorite(Offer offer){
    if(_offers.contains(offer))
    {_offers.remove(offer);}
    else
    {_offers.add(offer);}
    notifyListeners();
    }
  
}