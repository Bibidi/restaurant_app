import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_app/models/cart_item.dart';

class OrderModel {
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";
  static const RESTAURANT_ID = "restaurantId";

  String _id;
  String _restaurantId;
  String _description;
  String _userId;
  String _status;
  int _createdAt;
  double _total;

  // getter
  String get id => _id;
  String get restaurantId => _restaurantId;
  String get description => _description;
  double get total => _total;
  int get createdAt => _createdAt;
  String get status => _status;
  String get userId => _userId;

  // public variable
  List<CartItemModel> cart;


  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _restaurantId = snapshot.data()[RESTAURANT_ID];
    _description = snapshot.data()[DESCRIPTION];
    _total = snapshot.data()[TOTAL].toDouble();
    _status = snapshot.data()[STATUS];
    _userId = snapshot.data()[USER_ID];
    _createdAt = snapshot.data()[CREATED_AT];
    cart = _convertCartItem(snapshot.data()[CART], _createdAt);
  }

  List<CartItemModel> _convertCartItem(List cart, int createdAt) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem, createdAt));
    }
    return convertedCart;
  }
}