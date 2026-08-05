import 'package:loqma/db/offers_db.dart';
import 'package:loqma/models/address_model.dart';
import 'package:loqma/models/user_model.dart';

List<UserModel> users=[UserModel(
  fullName: 'Saif',
  password: '123456',
  email: 'saif@example.com',
  phone: '0791234567'
  
  ),
  UserModel(
    fullName: "Ahmad Ali",
    email: "ahmad@gmail.com",
    phone: "0792222222",
    password: "1eE@23456",
    location: AddressModel(
    address: "Irbid, Jordan",
    latitude: 32.5556,
    longitude: 35.8500,
  ),
    donations: [],
  ),

  UserModel(
    fullName: "Sara Mohammad",
    email: "sara@gmail.com",
    phone: "0793333333",
    password: "1eE@23456",
    location: AddressModel(
    address: "Irbid, Jordan",
    latitude: 32.5556,
    longitude: 35.8500,
  ),
    donations: [],
  ),

  UserModel(
    fullName: "Green Restaurant",
    email: "green@restaurant.com",
    phone: "0794444444",
    password: "123456",
    location: AddressModel(
    address: "Irbid, Jordan",
    latitude: 32.5556,
    longitude: 35.8500,
  ),
    donations: [],
  ),

  UserModel(
    fullName: "Fresh Market",
    email: "market@gmail.com",
    phone: "0795555555",
    password: "123456",
    location: AddressModel(
    address: "Irbid, Jordan",
    latitude: 32.5556,
    longitude: 35.8500,
  ),
    donations: [],
  ),
  ];


UserModel ?currentUser;