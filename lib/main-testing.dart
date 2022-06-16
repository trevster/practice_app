import 'package:flutter/material.dart';

import 'view/appEntry.dart';
import 'config.dart';

void main(){
  Config.appFlavor = Flavor.TESTING;
  runApp(new MyApp());
}