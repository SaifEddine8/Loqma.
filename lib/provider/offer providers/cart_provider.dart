import 'package:flutter/material.dart';
import 'package:loqma/models/offer_model.dart';

class CartProvider with ChangeNotifier{
  final List<Offer> _offers=[];
  int qu=1;
  List<Offer> get offers=>_offers;

  void addToCart(Offer offer){
    if(!_offers.contains(offer))
    {_offers.add(offer);}
    notifyListeners();
    }
  
  void removeFromCart(Offer offer)
  {
    if(_offers.contains(offer))
    {
      _offers.remove(offer);
      
    }
    notifyListeners();
  } 



    void increament(){
      qu++;
      notifyListeners();
    }

    void decreament(){
      if(qu>1)
      qu--;
      notifyListeners();
    }
  
}