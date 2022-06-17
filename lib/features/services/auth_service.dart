import 'package:amazon_clone/constants/error_handlers.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

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
}
