import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';
import '../../../providers/user.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(child: Text(user.toJson())),
    );
  }
}
