import 'package:flutter/material.dart';
import 'package:loqma/models/user_model.dart';

class UpdateUserProvider extends ChangeNotifier {
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;



  void setUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }
  void updateUser(UserModel updatedUser) {
    _currentUser = updatedUser;
    notifyListeners();
  }
 
}