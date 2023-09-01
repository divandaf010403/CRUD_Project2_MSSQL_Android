import 'package:flutter/material.dart';
import 'package:project1_crud/InsertScreen.dart';
import 'package:project1_crud/ScreenController.dart';
import 'package:project1_crud/SelectScreen.dart';
import 'package:project1_crud/UploadingFIle.dart';
import 'package:project1_crud/variable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => const ScreenController(),
        '/insert' : (context) => MainScreen(IpAddress: IpAddress!),
        '/select' : (context) => SelectScreen(IpAddress: IpAddress!),
        '/file' : (context) => const UploadingFile(),
      },
    );
  }
}