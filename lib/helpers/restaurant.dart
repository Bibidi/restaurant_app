import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_app/models/restaurant.dart';

class RestaurantServices {
  String collection = "restaurants";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<RestaurantModel>> getRestaurants() async =>
      _firestore.collection(collection).get().then((result) {
        List<RestaurantModel> restaurants = [];
        for (DocumentSnapshot restaurant in result.docs) {
          restaurants.add(RestaurantModel.fromSnapshot(restaurant));
        }
        return restaurants;
      });
  
  Future<List<RestaurantModel>> searchRestaurant({String restaurantName}) {
    String searchKey = restaurantName[0].toUpperCase() + restaurantName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((result) {
          List<RestaurantModel> restaurants = [];
          for (DocumentSnapshot restaurant in result.docs) {
            restaurants.add(RestaurantModel.fromSnapshot(restaurant));
          }
          return restaurants;
    });
  }
}