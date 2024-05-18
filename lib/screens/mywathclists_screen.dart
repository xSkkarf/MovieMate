import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemate/api/watchlist_service.dart';
import 'package:moviemate/models/watchlist_model.dart';
import 'package:moviemate/screens/watchlist_details_screen.dart';

class MyWatchlistScreen extends StatefulWidget {
  const MyWatchlistScreen({super.key});

  @override
  State<MyWatchlistScreen> createState() => _MyWatchlistScreenState();
}

class _MyWatchlistScreenState extends State<MyWatchlistScreen> {
  void deleteDialog(int index) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete this watchlist?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                setState(() {
                  WatchlistService.removeWatchlistAtIndex(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget watchlistInit() {
    if (WatchlistService.watchlists.isEmpty) {
      return Center(
        child: Text(
          'Watchlist is empty',
          style: GoogleFonts.bebasNeue(fontSize: 20),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: WatchlistService.watchlists.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WatchlistDetails(
                        watchList: WatchlistService.watchlists[index])),
              );
            },
            onLongPress: () {
              deleteDialog(index);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Text(
                WatchlistService.watchlists[index].title,
                style: GoogleFonts.bebasNeue(fontSize: 20),
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> _showAddWatchlistDialog() async {
    TextEditingController watchlistController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create a new watchlist'),
          content: TextField(
            controller: watchlistController,
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
                  Watchlist watchlist =
                      Watchlist(title: watchlistController.text);
                  WatchlistService.watchlists.add(watchlist);
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
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showAddWatchlistDialog();
            },
            shape: const CircleBorder(),
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add)),
        body: watchlistInit());
  }
}
