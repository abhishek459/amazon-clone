import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
  );

  User get getUser => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
