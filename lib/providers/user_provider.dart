import 'package:amazon_clone/models/myuser_model.dart';
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
  );

  MyUser get user => _myUser;

  void setUser(String user) {
    _myUser = MyUser.fromJson(user);
    notifyListeners();
  }
}
