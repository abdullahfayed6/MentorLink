import 'package:flutter/material.dart';

extension LocaleDirectionX on BuildContext {
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
