import 'package:flutter/material.dart';
import 'package:tut_app/application/app.dart';
import 'package:tut_app/application/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
