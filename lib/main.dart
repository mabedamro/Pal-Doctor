import 'dart:convert';
import 'dart:io';

import 'package:desktop_version/api/authApi.dart';
import 'package:desktop_version/provider/employeesProvider.dart';
import 'package:desktop_version/provider/patinetProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/loginScreen.dart';
import 'package:desktop_version/screen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';
import 'package:provider/provider.dart';

void main() async {
  FirebaseAuth.initialize(AuthApi.APIKEY, VolatileStore());
  Firestore.initialize('pal-doctor');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    //   // DesktopWindow.setWindowSize(Size(700, 200));
    //   DesktopWindow.setMaxWindowSize(Size(700, 200));

    //   DesktopWindow.setMinWindowSize(Size(700, 200));
    // }
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider(create: (_) => UserProvier()),
        ChangeNotifierProvider(create: (_) => EmployeesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pal Doctor',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
