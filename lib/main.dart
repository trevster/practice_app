import 'package:flutter/material.dart';

import 'view/appEntry.dart';
import 'config.dart';

void main(){
  Config.appFlavor = Flavor.LIVE;
  runApp(new MyApp());
}

