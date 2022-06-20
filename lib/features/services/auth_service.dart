// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/error_handlers.dart';
import '../../constants/global_variables.dart';
import '../../constants/utils.dart';
import '../../models/user.dart';
import '../../providers/user.dart';
import '../home/screens/home_screen.dart';

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

  Future<void> validateUser(BuildContext context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      if (token == null) {
        preferences.setString('token', '');
      }

      http.Response tokenResponse = await http.get(
        Uri.parse('$uri/validate'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token!
        },
      );

      bool response = jsonDecode(tokenResponse.body);
      if (response == true) {
        http.Response userData = await http.get(
          Uri.parse('$uri/me'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token
          },
        );

        UserProvider userProvider =
            Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userData.body);
      }
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
