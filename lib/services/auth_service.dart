import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moviemate/models/user_model.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

    // Convert Firebase User to AppUser
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(uid: user.uid, email: user.email!, displayName: user.displayName!) : null;
  }

  // Stream of Auth Changes
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

   // Sign in with email & password
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email & password
  Future<UserModel?> registerWithEmailAndPassword(String email, String password, String displayName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // Update the display name
      await user!.updateDisplayName(displayName);
      await user.reload(); // Reload the user to apply the changes
      user = _auth.currentUser;

      // Create a new document for the user with the uid
      await _db.collection('users').doc(user!.uid).set({
        'uid': user.uid,
        'email': email,
        'displayName': displayName,
        'photoURL': user.photoURL,
      });

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return;
    }
  }

  // Get user data
  Future<UserModel?> getUserData(String uid) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}