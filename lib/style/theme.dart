import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();

  // static const Color loginGradientStart = const Color(0xFFfbab66);
  //  static const Color loginGradientEnd = const Color(0xFFf7418c);
  static const Color loginGradientStart = const Color(0xFF00FA9A);
  static const Color loginGradientEnd = const Color(0xFF1E90FF);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}