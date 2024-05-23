import 'package:flutter/material.dart';
import 'package:moviemate/screens/authentication/login_signup_screen.dart';
import 'package:moviemate/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:moviemate/services/user_provider.dart';


class FirstScreen extends StatelessWidget {
  
  const FirstScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    if (user == null) {
      return LoginSignupScreen();
    } else {
      return HomeScreen();
    }
  }

}