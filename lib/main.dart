import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/viewmodels/first_screen_viewmodel.dart';
import 'package:test_flutter/viewmodels/third_screen_viewmodel.dart';
import 'package:test_flutter/viewmodels/second_screen_viewmodel.dart';
import 'package:test_flutter/views/first_screen.dart';
import 'package:test_flutter/views/second_screen.dart';
import 'package:test_flutter/views/third_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  statusBarColor: Colors.black, 
));
 
  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FirstScreenViewmodel()),
      ChangeNotifierProvider(create: (_) => SecondScreenViewmodel()),
      ChangeNotifierProvider(create: (_) => ThirdScreenViewmodel()),
    ],
      child: DevicePreview(
        enabled: false, 
        builder: (context) => MyApp(), 
      ),
    )
  );
}

class MyApp extends StatelessWidget {
   MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Flutter App',
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(),
        '/second': (context) => SecondScreen(),
        '/third': (context) => ThirdScreen(),
      },
    );
  }
}

