import 'dart:io';

import 'package:loqma/models/address_model.dart';

class PersonModel {
  static int counter=0;
  final int id;
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final AddressModel? location;
  final File? profileImage;



   PersonModel({
    
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
     this.location,
      this.profileImage,
  }):id=++counter;

}