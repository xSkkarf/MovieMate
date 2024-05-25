import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moviemate/services/user_provider.dart';
import 'package:moviemate/Utils/colours.dart';
import 'package:moviemate/screens/first_screen.dart';
import 'package:moviemate/firebase_options.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MovieMate',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colours.scaffoldBgColor,
        ),
        home: const FirstScreen(),
      ),
    );
  }
}
