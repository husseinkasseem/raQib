import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:raqib/core/reusable%20widgets/Custom%20button.dart';
import 'package:raqib/core/strings%20manager.dart';

class CustomDialog {
  static showLoadingDialog(BuildContext context){
    showDialog(context: context,
        builder: (context) => AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(StringsManager.loading.tr(),
              style: Theme.of(context).textTheme.headlineLarge
              ),
              CircularProgressIndicator()
            ],
          ),
        ),);
  }
  static showMessageDialog({
    required BuildContext context,
    required String message,
    required Function() onPressed,
    required String textInButton
  }){
    showDialog(context: context,
        builder: (context) => AlertDialog(
          content: Text(message),
          actions: [
           TextButton(
               onPressed: onPressed,
               child: Text(textInButton)
           )
          ],
        ),
    );
  }
}
