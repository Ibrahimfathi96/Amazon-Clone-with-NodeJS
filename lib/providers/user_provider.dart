import 'package:amazon_clone/models/my_user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  MyUser _myUser = MyUser(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );

  MyUser get user => _myUser;

  void setUser(String user) {
    _myUser = MyUser.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(MyUser user) {
    _myUser = user;
    notifyListeners();
  }
}
