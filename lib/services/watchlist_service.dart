import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moviemate/models/watchlist_model.dart';

class WatchlistService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static User? get _user => FirebaseAuth.instance.currentUser;
  static List<Watchlist> watchlists = [];

  static Future<void> loadWatchlists() async {
    if (_user != null) {
      try {
        print("alooo");
        QuerySnapshot snapshot = await _db
            .collection('users')
            .doc(_user!.uid)
            .collection('watchlists')
            .get();
        watchlists = snapshot.docs.map((doc) => Watchlist.fromJson(doc.data() as Map<String, dynamic>)).toList();
      } catch (e) {
        // Handle errors if needed
        print("Error loading watchlists from Firebase: $e");
      }
    }
  }

  static Future<void> saveWatchlists() async {
    if (_user != null) {
      try {
        CollectionReference userWatchlists = _db.collection('users').doc(_user!.uid).collection('watchlists');
        // Clear existing watchlists
        var snapshots = await userWatchlists.get();
        for (var doc in snapshots.docs) {
          await doc.reference.delete();
        }
        // Add updated watchlists
        for (Watchlist watchlist in watchlists) {
          await userWatchlists.add(watchlist.toJson());
        }
      } catch (e) {
        // Handle errors if needed
        print("Error saving watchlists to Firebase: $e");
      }
    }
    
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
