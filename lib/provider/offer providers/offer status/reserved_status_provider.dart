import 'package:flutter/material.dart';
import 'package:loqma/models/offer_model.dart';

class ReservedStatusProvider with ChangeNotifier {
  final List<Offer> _offers = [];

  List<Offer> get offers => _offers;

  void addOffer(Offer offer) {
    _offers.add(offer);
    notifyListeners();
  }

  void removeOffer(Offer offer) {
    _offers.remove(offer);
    notifyListeners();
  }
}