import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('id'),
  ];
  static AppLocalizations of(BuildContext context) =>
      AppLocalizations.of(context)!;
}
