import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:moviemate/models/watchlist_model.dart';

class WatchlistService {
  
  static List<Watchlist> watchlists = [];

  static Future<void> loadWatchlists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? watchlistStrings = prefs.getStringList('watchlists');
    if (watchlistStrings != null) {
      watchlists = watchlistStrings.map((item) => Watchlist.fromJson(jsonDecode(item))).toList();
    }
  }

  static Future<void> saveWatchlists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> watchlistStrings = watchlists.map((watchlist) => jsonEncode(watchlist.toJson())).toList();
    prefs.setStringList('watchlists', watchlistStrings);
  }

  static Future<void> addWatchlist(Watchlist watchlist) async {
    watchlists.add(watchlist);
    await saveWatchlists();
  }

  static Future<void> removeWatchlistAtIndex(int index) async {
    watchlists.removeAt(index);
    await saveWatchlists();
  }

}
