import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/helpers/order.dart';
import 'package:restaurant_app/models/order.dart';

enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  OrderServices _orderServices = OrderServices();

  // getter
  User get user => _user;
  Status get status => _status;

  //public variables
  List<OrderModel> orders = [];

  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
  }

  // 이 문법 모름
  UserProvider.initialize(): _auth = FirebaseAuth.instance{
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<void> _onStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    }
    else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future<bool> signUp() async {
    _status = Status.Authenticating;
    notifyListeners();
    await _auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((result) {
      _firestore.collection("users").doc(result.user.uid).set({
        'name': name.text,
        'email': email.text,
        'uid': result.user.uid,
        'likedFood': [],
        'likedRestaurants': [],
      });
    });
  }

  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
      return true;
    } catch(e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  getOrders() async {
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  Future<bool> removeFromCart({Map cartItem}) async {
    try {
      return true;
    } catch(e) {
      return false;
    }
  }
}