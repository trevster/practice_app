import 'package:first_app/features/appEntry.dart';
import 'package:flutter/material.dart';

import 'config.dart';

void main(){
  Config.appFlavor = Flavor.LIVE;
  runApp(new MyApp());
}

