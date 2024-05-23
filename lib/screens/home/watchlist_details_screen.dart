import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemate/Utils/movies_grid.dart';
import 'package:moviemate/models/watchlist_model.dart';

class WatchlistDetails extends StatefulWidget{
  final Watchlist watchList;
  const WatchlistDetails({super.key, required this.watchList});

  @override
  State<WatchlistDetails> createState() => _WatchlistDetailsState();
}

class _WatchlistDetailsState extends State<WatchlistDetails> {

  void _refresh() {
    setState(() {});
  }
  
  Widget watchListDetailsScreenInit(){
    if(widget.watchList.count == 0){
      return Center(
        child: Text(
          "No Movies Added",
          style: GoogleFonts.bebasNeue(fontSize: 30),
        ),
      );
    }else{
      return MoviesGrid.showMoviesListDel(widget.watchList, _refresh);
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