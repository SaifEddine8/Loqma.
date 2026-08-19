import 'package:flutter/foundation.dart';
import 'package:loqma/models/offer_model.dart';

class WaitingOffers with ChangeNotifier{
  final List<Offer>_offers=[];
  List<Offer>get offers=>_offers;
  void add(Offer offer)
  {
    _offers.add(offer);
    notifyListeners();
  }
  void remove(Offer offer)
  {
    _offers.remove(offer);
    notifyListeners();

  }
}