import 'package:moviemate/api/watchlist_service.dart';
import 'package:moviemate/Utils/colours.dart';
import 'package:moviemate/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WatchlistService.loadWatchlists();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieMate',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.scaffoldBgColor,
      ),
      home: const HomeScreen(),
    );
  }
}
