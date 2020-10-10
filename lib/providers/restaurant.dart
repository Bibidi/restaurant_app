import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/helpers/restaurant.dart';
import 'package:restaurant_app/models/restaurant.dart';

class Restaurantprovider with ChangeNotifier {
  RestaurantServices _restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> searchedRestaurants = [];

  Restaurantprovider.initialize() {
    loadRestaurants();
  }

  loadRestaurants() async {
    restaurants = await _restaurantServices.getRestaurants();
    notifyListeners();
  }

  Future search({String name}) async {
    searchedRestaurants = await _restaurantServices.searchRestaurant(restaurantName: name);
    notifyListeners();
  }
}