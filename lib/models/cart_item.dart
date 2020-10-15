import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  static const ID = "id";
  static const RESTAURANT_ID = "restaurantId";
  static const PRODUCT_ID = "productId";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const QUANTITY = "quantity";

  String _id;
  String _restaurantId;
  String _productId;
  String _name;
  String _image;
  double _price;
  int _quantity;
  int _date;

  // getter
  String get id => _id;
  String get restaurantId => _restaurantId;
  String get productId => _productId;
  String get name => _name;
  String get image => _image;
  double get price => _price;
  int get quantity => _quantity;
  int get date => _date;


  CartItemModel.fromMap(Map data, int createdAt) {
    _id = data[ID];
    _restaurantId = data[RESTAURANT_ID];
    _productId = data[PRODUCT_ID];
    _name = data[NAME];
    _image = data[IMAGE];
    _price = data[PRICE].toDouble();
    _quantity = data[QUANTITY];
    _date = createdAt;
  }

  Map toMap() => {
    ID: _id,
    IMAGE: _image,
    NAME: _name,
    PRODUCT_ID: _productId,
    PRICE: _price,
    QUANTITY: _quantity,
    RESTAURANT_ID: _restaurantId,
  };
}