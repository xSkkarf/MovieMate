import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemate/api/watchlist_service.dart';
import 'package:moviemate/models/movie_model.dart';
import 'package:moviemate/models/watchlist_model.dart';

class DetailsScreen extends StatefulWidget {
  final Movie movie;
  const DetailsScreen({super.key, required this.movie});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<Watchlist> selectedWatchlists = [];

  void showWatchlistDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add to Watchlist'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  for (Watchlist watchlist in WatchlistService.watchlists)
                    CheckboxListTile(
                      title: Text(watchlist.title),
                      value: selectedWatchlists.contains(watchlist),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null) {
                            if (value) {
                              selectedWatchlists.add(watchlist);
                            } else {
                              selectedWatchlists.remove(watchlist);
                            }
                          }
                        });
                      },
                    ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                for (Watchlist watchlist in selectedWatchlists) {
                  final SnackBar snackBar;
                  if (watchlist.add(widget.movie)) {
                    snackBar = SnackBar(
                      content: Text("The movie already exists in watchlist: ${watchlist.title}"),
                      duration: const Duration(seconds: 2),
                    );
                  }else{
                    snackBar = SnackBar(
                      content: Text("The movie was added successfully to watchlist: ${watchlist.title}"),
                      duration: const Duration(seconds: 2),
                    );
                  }
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
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
          'Movies',
          style: GoogleFonts.bebasNeue(fontSize: 30),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(children: [
        SizedBox(
          height: 300,
          child: Image.network(
            'https://image.tmdb.org/t/p/original${widget.movie.backDropPath}',
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Text(
            widget.movie.title,
            style: GoogleFonts.bebasNeue(fontSize: 30),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "Overview:\n${widget.movie.overview}",
            style: GoogleFonts.aBeeZee(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: () {
              showWatchlistDialog();
            },
            child: const Text('Add to Watchlist'),
          ),
        )
      ]),
    );
  }
}
