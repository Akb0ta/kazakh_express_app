import 'package:bus_app/api/local_storage.dart';
import 'package:bus_app/app/app.dart';
import 'package:bus_app/data/local_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalData.instance.initDatas();
  // await SecureStorage().clearAll();
  runApp(BusApp());
}
