import 'package:flutter/material.dart';


import 'config.dart';
import 'features/appEntry.dart';

void main(){
  Config.appFlavor = Flavor.DEVELOPMENT;
  runApp(new MyApp());
}