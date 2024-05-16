
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviemate/models/movie.dart';

class DetailsScreen extends StatefulWidget{
  final Movie movie;
  DetailsScreen({super.key, required this.movie});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movies',
          style: GoogleFonts.aBeeZee(),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
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
              style: GoogleFonts.bebasNeue(
                fontSize: 30
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Overview:\n" + widget.movie.overview
            ),
          )
        ]
      ),
    );
  }
}