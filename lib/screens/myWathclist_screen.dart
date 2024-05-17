import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemate/models/watchlist.dart';
import 'package:moviemate/screens/home_screen.dart';
import 'package:moviemate/screens/watchlist_details.dart';

class MyWatchlistScreen extends StatefulWidget{

  const MyWatchlistScreen({super.key});

  @override
  State<MyWatchlistScreen> createState() => _MyWatchlistScreenState();
}

class _MyWatchlistScreenState extends State<MyWatchlistScreen> {

  Widget watchlistInit() {
    if (watchlists.isEmpty) {
      return Center(
        child: Text(
          'Watchlist is empty',
          style: GoogleFonts.bebasNeue(fontSize: 20),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: watchlists.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WatchlistDetails(watchList: watchlists[index])),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Text(
                watchlists[index].title,
                style: GoogleFonts.bebasNeue(fontSize: 20),
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> _showAddWatchlistDialog() async {
    TextEditingController _watchlistController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create a new watchlist'),
          content: TextField(
            controller: _watchlistController,
            decoration: const InputDecoration(hintText: "Watchlist Name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Create'),
              onPressed: () {
                setState(() {
                  Watchlist watchlist = Watchlist(title: _watchlistController.text);
                  watchlists.add(watchlist);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My watchlists',
          style: GoogleFonts.bebasNeue(fontSize: 30),
        ),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: 
      FloatingActionButton(
        onPressed: () {
          _showAddWatchlistDialog();
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add)
      ),
      body: watchlistInit()
    );
  }
  
}