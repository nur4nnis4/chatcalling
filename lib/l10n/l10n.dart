import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class L10n {
  static final all = [
    const Locale('id'),
    const Locale('en'),
  ];

  static String getLocalLanguageCode(BuildContext context) =>
      Localizations.localeOf(context).languageCode;

  static AppLocalizations of(BuildContext context) =>
      AppLocalizations.of(context)!;
}
