import 'package:flutter/material.dart';

import '../../constants/global_variables.dart';
import '../screens/auth_screen.dart';

class LoginOptions extends StatelessWidget {
  final Auth value;
  final Auth? groupValue;
  final void Function(Auth?)? onChanged;
  final String label;
  const LoginOptions({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: (groupValue == value)
          ? GlobalVariables.backgroundColor
          : GlobalVariables.greyBackgroundCOlor,
      leading: Radio(
        activeColor: GlobalVariables.secondaryColor,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
      title: Text(label),
    );
  }
}
