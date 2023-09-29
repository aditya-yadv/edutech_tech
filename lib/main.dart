import 'package:edukit_tech/view_models/user_viewmodel.dart';
import 'package:edukit_tech/views/profile.dart';
import 'package:edukit_tech/views/signIn.dart';
import 'package:edukit_tech/views/signUp.dart';
import 'package:edukit_tech/views/update_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserViewModel())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'signup': (context) => SignUp(),
        'signin': (context) => SignIn(),
        'profile': (context) => ProfileScreen(),
        'update': (context) => UpdateLocation(),
      },
      initialRoute: 'signup',
    );
  }
}
