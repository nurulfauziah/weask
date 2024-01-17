import 'package:flutter/material.dart';
import 'package:weask/chat_landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(color: Color(0xFF030C1A)),
          bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF030C1A))),
      home: const ChatLandingScreen(),
    );
  }
}
