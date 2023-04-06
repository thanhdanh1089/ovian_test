import 'package:flutter/cupertino.dart';
import 'package:ovian_test/res/Resources.dart';

extension AppContext on BuildContext {
  Resources get resources => Resources.of(this);
}