import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FluttermetFirebaseUser {
  FluttermetFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

FluttermetFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FluttermetFirebaseUser> fluttermetFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<FluttermetFirebaseUser>(
            (user) => currentUser = FluttermetFirebaseUser(user));
