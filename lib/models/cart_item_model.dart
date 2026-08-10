import 'package:loqma/models/offer_model.dart';

class CartItemModel {
  final Offer offer;
  int quantity;
  CartItemModel({required this.offer, this.quantity=1});
  
}