import 'package:flutter/material.dart';
import 'package:loqma/models/user_model.dart';

class UserTypeProvider with ChangeNotifier{
  final List<UserModel> _users=[];
  List<UserModel> get users=>_users;
  void addUser(UserModel user)
  {
    _users.add(user);
    notifyListeners();
  }
  void removeUser(UserModel user)
  {
    _users.remove(user);
    notifyListeners();
  }
}