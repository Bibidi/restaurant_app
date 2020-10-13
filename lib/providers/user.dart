import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/helpers/order.dart';
import 'package:restaurant_app/helpers/product.dart';
import 'package:restaurant_app/helpers/restaurant.dart';
import 'package:restaurant_app/models/order.dart';
import 'package:restaurant_app/models/product.dart';
import 'package:restaurant_app/models/restaurant.dart';

enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  OrderServices _orderServices = OrderServices();
  ProductServices _productServices = ProductServices();
  RestaurantServices _restaurantServices = RestaurantServices();
  RestaurantModel _restaurant;
  List<ProductModel> _products = [];

  // getter
  User get user => _user;
  Status get status => _status;
  RestaurantModel get restaurant => _restaurant;
  List<ProductModel> get products => _products;

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

  Future reload() async {
    _restaurant = await _restaurantServices.getRestaurantById(id: user.uid);
    notifyListeners();
  }

  Future<void> _onStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    }
    else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      _restaurant = await _restaurantServices.getRestaurantById(id: user.uid);
      _products = await _productServices.getProductsByRestaurant(id: user.uid);
    }
    notifyListeners();
  }

  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((result) {
        _firestore.collection("restaurants").doc(result.user.uid).set({
          'name': name.text,
          'email': email.text,
          'uid': result.user.uid,
          'avgPrice': 0.0,
          'image': "",
          'popular': false,
          'rates': 0,
          'rating': 0.0,
        });
      });
      return true;
    } catch(e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
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