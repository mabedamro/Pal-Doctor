import 'dart:io';

import 'package:desktop_version/provider/listProvider.dart';
import 'package:desktop_version/screen/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
        ChangeNotifierProvider(create: (_) => ListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pal Doctor',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
