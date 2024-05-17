import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemate/models/movie.dart';
import 'package:moviemate/screens/home_screen.dart';

class DetailsScreen extends StatefulWidget {
  final Movie movie;
  DetailsScreen({super.key, required this.movie});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  List<int> selectedWatchlistsIndex = [];

  void showWatchlistDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add to Watchlist'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  for (int i = 0; i < watchlists.length; i++)
                    CheckboxListTile(
                      title: Text(watchlists[i].title),
                      value: selectedWatchlistsIndex.contains(i),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null) {
                            if (value) {
                              selectedWatchlistsIndex.add(i);
                            } else {
                              selectedWatchlistsIndex.remove(i);
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
                for(int i = 0; i < selectedWatchlistsIndex.length; i++){
                  watchlists[selectedWatchlistsIndex[i]].add(widget.movie);
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
            child: Text('Add to Watchlist'),
          ),
        )
      ]),
    );
  }
}
