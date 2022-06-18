import 'dart:convert';

import 'package:amazon_clone/constants/error_handlers.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';

class AuthService {
  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );

      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Account created successfully!');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      throw Error();
    }
  }

  Future<void> signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            saveUserToken(response).then((_) => {
                  Provider.of<UserProvider>(context, listen: false)
                      .setUser(response.body),
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      HomeScreen.routeName, (route) => false),
                });
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      throw Error();
    }
  }

  Future<void> saveUserToken(http.Response response) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('token', jsonDecode(response.body)['token']);
  }
}
