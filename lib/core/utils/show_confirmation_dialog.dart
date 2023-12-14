import 'package:flutter/material.dart';

void showConfirmationDialog(BuildContext context, Function positiveActionHandler) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmation'),
        content: Text('Are you sure you want to proceed?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Close the dialog and perform the action
              // you want when "Yes" is selected
              positiveActionHandler();
              Navigator.of(context).pop(true); // You can pass any value here
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              // Close the dialog when "No" is selected
              Navigator.of(context).pop(false); // You can pass any value here
            },
            child: Text('No'),
          ),
        ],
      );
    },
  );
  }