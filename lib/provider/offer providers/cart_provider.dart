import 'package:flutter/material.dart';
import 'package:loqma/models/cart_item_model.dart';
import 'package:loqma/models/offer_model.dart';

class CartProvider with ChangeNotifier{
  final List<Offer> _offers=[];
  int qu=1;
  double subTotal=0.0;
  List<Offer> get offers=>_offers;

  void addToCart(Offer offer){
    if(!_offers.contains(offer))
    {_offers.add(offer);
    sum();
    }
    notifyListeners();
    }
  
  void removeFromCart(Offer offer)
  {
    if(_offers.contains(offer))
    {
      _offers.remove(offer);
      sum();
      
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



    void sum(){
      
      subTotal=_offers.fold<double>(
  0,
  (sum, item) =>item.type==OfferType.donation?sum+0: (sum + item.price!)*5,

  
);
notifyListeners();

    }
  
}