import 'package:flutter/material.dart';
import 'package:loqma/models/cart_item_model.dart';
import 'package:loqma/models/offer_model.dart';

class CartProvider with ChangeNotifier{
final Map<Offer, int> _cartItems = {};  
  double subTotal=0.0;
  double tax=0.0.roundToDouble();
  List<Offer> get offers=>_cartItems.keys.toList();

  int getQuantity(Offer offer){
    return _cartItems[offer]??1;
  }
  void addToCart(Offer offer){
    if(!_cartItems.containsKey(offer))
    {_cartItems[offer]=1;
    sum();
    }
    notifyListeners();
    }
  
  void removeFromCart(Offer offer)
  {
    if(_cartItems.containsKey(offer))
    {
      _cartItems.remove(offer);
      sum();
      
    }
    notifyListeners();
  } 



    void increament(Offer offer){
      _cartItems[offer]=_cartItems[offer]!+1;
      sum();
      notifyListeners();
    }

    void decreament(Offer offer){
      if(_cartItems[offer]!>1)
      _cartItems[offer]=_cartItems[offer]!-1;
      sum();
      notifyListeners();
    }



    void sum(){
      
      subTotal=_cartItems.entries.fold<double>(
  0,
  (sum, item) =>item.key.type==OfferType.donation?sum+0: sum + (item.key.price!*item.value),

  
);
tax=subTotal*0.05;

notifyListeners();

    }
    

  
}