import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Flavor {
  DEVELOPMENT,
  LIVE,
  TESTING,
}

class Config {
  static Flavor appFlavor;
}
