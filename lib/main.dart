import 'package:flutter/material.dart';

import 'database/database.dart';
import 'view/appEntry.dart';
import 'config.dart';

late final TodoDao todoDao;

void main(){
  Config.appFlavor = Flavor.LIVE;
  todoDao = MyDatabase().todoDao;
  runApp(new MyApp());
}

