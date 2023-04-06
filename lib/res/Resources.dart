import 'package:flutter/cupertino.dart';
import 'package:ovian_test/res/colors/AppColors.dart';
import 'package:ovian_test/res/dimentions/AppDimension.dart';
import 'package:ovian_test/res/strings/VietnamStrings.dart';
import 'package:ovian_test/res/strings/Strings.dart';
import 'package:ovian_test/res/strings/EnglishStrings.dart';

class Resources {
  final BuildContext _context;

  Resources(this._context);

  Strings get strings {
    // It could be from the user preferences or even from the current locale
    Locale locale = Localizations.localeOf(_context);
    switch (locale.languageCode) {
      case 'vn':
        return VietnamStrings();
      default:
        return EnglishStrings();
    }
  }

  AppColors get color {
    return AppColors();
  }

  AppDimension get dimension {
    return AppDimension();
  }

  static Resources of(BuildContext context){
    return Resources(context);
  }
}