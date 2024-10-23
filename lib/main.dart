import 'package:flutter/material.dart';
import 'package:home_camera/pages/login_screen.dart';
import 'package:home_camera/services/app_service.dart';
import 'package:home_camera/utils/constants.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(const MyApp());
  runApp(ChangeNotifierProvider(
    create: (_) => AppService(),
    builder: (context, widget) => const MyApp(),
    // builder: (context, widget) => WhatsApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.red,
          
          iconTheme: IconThemeData(color: secondaryColor),
          buttonTheme: ButtonThemeData(buttonColor: Colors.green)),
      home: const LoginScreen(),
    );
  }
}
