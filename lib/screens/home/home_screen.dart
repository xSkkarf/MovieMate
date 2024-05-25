import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemate/screens/home/movies_screen.dart';
import 'package:moviemate/screens/home/search_screen.dart';
import 'package:moviemate/screens/home/wathclists_screen.dart';
import 'package:moviemate/services/user_provider.dart';
import 'package:moviemate/services/watchlist_service.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = [
    const MoviesScreen(),
    const MyWatchlistScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WatchlistService.loadWatchlists();
  }

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text('MovieMate', style: GoogleFonts.bebasNeue(fontSize: 30)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'My Watchlist',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(user?.displayName ?? 'No Name'),
              accountEmail: Text(user?.email ?? 'No Email'),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Handle the navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                print(user?.uid);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () {
                userProvider.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
