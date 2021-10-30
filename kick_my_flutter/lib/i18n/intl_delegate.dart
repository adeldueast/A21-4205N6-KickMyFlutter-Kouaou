import 'dart:async';

import 'package:flutter/material.dart';

import 'intl_localization.dart';

class DemoDelegate extends LocalizationsDelegate<Locs> {
  const DemoDelegate();


  @override
  bool isSupported(Locale locale) => ['fr', 'en'].contains(locale.languageCode);

  @override
  Future<Locs> load(Locale locale) async {

    Locs localizations = Locs(locale);
    await localizations.load();
    return localizations;
  }


  @override
  bool shouldReload(DemoDelegate old) => false;
}