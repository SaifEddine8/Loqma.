import 'package:flutter/material.dart';
import 'package:loqma/models/cart_item_model.dart';
import 'package:loqma/models/offer_model.dart';

class DeliveryProvider with ChangeNotifier{
final Map<Offer, int> _deliveryItems = {}; 
final Map<Offer, String> _itemStatuses = {};

  double subTotal=0.0;
  double tax=0.0.roundToDouble();
  List<Offer> get offers=>_deliveryItems.keys.toList();


  int getQuantity(Offer offer){
    return _deliveryItems[offer]??1;
  }
  String getStatus(Offer offer) {
    return _itemStatuses[offer] ?? "In Preparation";
  }


  void addToDelivery(Offer offer){
    if(!_deliveryItems.containsKey(offer))
    {_deliveryItems[offer]=1;
    }

    if (!_itemStatuses.containsKey(offer)) {
      _itemStatuses[offer] = "In Preparation"; 
    }
    notifyListeners();
    }
  
  void removeFromDelivery(Offer offer)
  {
    if(_deliveryItems.containsKey(offer))
    {
      _deliveryItems.remove(offer);
      
    }
    notifyListeners();
  } 



    void increament(Offer offer){
      
      _deliveryItems[offer]=_deliveryItems[offer]!+1;
      notifyListeners();
    }

    void decreament(Offer offer){
      if(_deliveryItems[offer]!>1)
      _deliveryItems[offer]=_deliveryItems[offer]!-1;
      notifyListeners();
    }



  
    void moveToNextStatus(Offer offer) {
    String currentStatus = getStatus(offer);

    if (currentStatus == "In Preparation") {
      _itemStatuses[offer] = "In Delivery";
    } else if (currentStatus == "In Delivery") {
      _itemStatuses[offer] = "Delivered";
      
    }

    notifyListeners(); 
  }

  
}