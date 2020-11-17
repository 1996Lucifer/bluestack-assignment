import 'package:app_developer_assignment/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReusableWidgets {
  static showDialogBox(BuildContext context, Widget content) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('message'.tr),
              content: content,
              actions: <Widget>[
                FlatButton(
                    child: Text(
                      'ok'.tr,
                      style: TextStyle(color: themeColor),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ]);
        });
  }
}
