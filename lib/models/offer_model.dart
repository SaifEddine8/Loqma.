import 'package:loqma/db/user_db.dart';
 
 

enum OfferType{
  donation,
  sale
}



class Offer {
  static int counter=0;
  final int id;
  final int ownerId;
  final String title;
  final String description;
  final int quantity;
  final DateTime expiryDate;
  final DateTime productionDate;
  final OfferType type;
  final String image;
  final double?price;
  final double?originalPrice;
  final String category;
  final int? volunteerId;





Offer({
   required this.ownerId,
    required this.title,
    required this.description,
    required this.quantity,
    required this.expiryDate,
    required this.productionDate,
    required this.image,
    this.price,
    this.originalPrice,
    required this.category,
    this.volunteerId,
    required this.type
  }):id=++counter;




}