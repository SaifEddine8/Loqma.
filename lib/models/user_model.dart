import 'package:flutter/material.dart';
import 'package:loqma/models/offer_model.dart';
import 'package:loqma/models/person_mosel.dart';



enum UserType{
  user,
  admin,
  volunteer

}
class UserModel extends PersonModel{
  List<Offer> donations;
  UserType type;
  UserModel({
    
    required super.fullName,
    required super.email,
    required super.phone,
    required super.password,
     super.location,
      super.profileImage,
      this.type=UserType.user,
    this.donations = const [],
  });



}