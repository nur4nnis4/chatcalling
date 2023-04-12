import 'package:flutter/material.dart';

class CustomSnackbar {
  static SnackBar loadingSnackbar(BuildContext context, {String? text}) {
    double horizontalMargin = MediaQuery.of(context).size.width * 0.3;
    return SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.fromLTRB(horizontalMargin, 0, horizontalMargin,
            MediaQuery.of(context).size.height * 0.4),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        content: Row(
          children: [
            SizedBox.square(
              dimension: 13,
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                strokeWidth: 3,
              ),
            ),
            SizedBox(width: 10),
            Text(
              text ?? ' Processing...',
              style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ],
        ));
  }

  static SnackBar errorSnackBar(BuildContext context, {String? text}) =>
      SnackBar(
        content: Text(text ?? 'Unknown error.'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
}
