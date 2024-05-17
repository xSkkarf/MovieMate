import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemate/Utils/moviesGrid.dart';
import 'package:moviemate/models/watchlist.dart';

class WatchlistDetails extends StatefulWidget{
  final Watchlist watchList;
  const WatchlistDetails({super.key, required this.watchList});

  @override
  State<WatchlistDetails> createState() => _WatchlistDetailsState();
}

class _WatchlistDetailsState extends State<WatchlistDetails> {
  Widget watchListDetailsScreenInit(){
    if(widget.watchList.count == 0){
      return Center(
        child: Text(
          "No Movies Added",
          style: GoogleFonts.bebasNeue(fontSize: 30),
        ),
      );
    }else{
      return MoviesGrid.showWatchList(widget.watchList.movies);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.watchList.title,
          style: GoogleFonts.bebasNeue(fontSize: 30),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: watchListDetailsScreenInit()
    );
  }
}