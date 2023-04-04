import 'package:flutter/cupertino.dart';
import 'package:ovian_test/res/Resources.dart';
import 'package:ovian_test/res/dimentions/AppDimension.dart';

extension AppContext on BuildContext {
  Resources get resources => Resources.of(this);
}