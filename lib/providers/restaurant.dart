import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_app/helpers/restaurant.dart';
import 'package:restaurant_app/models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  RestaurantServices _restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> searchedRestaurants = [];

  RestaurantModel restaurant;

  final _picker = ImagePicker();
  String restaurantImageFileName;
  File restaurantImage;

  RestaurantProvider.initialize() {
    _loadRestaurants();
  }

  _loadRestaurants() async {
    restaurants = await _restaurantServices.getRestaurants();
    notifyListeners();
  }

  loadSingleRestaurant({String restaurantId}) async {
    restaurant = await _restaurantServices.getRestaurantById(id: restaurantId);
    notifyListeners();
  }

  Future search({String name}) async {
    searchedRestaurants = await _restaurantServices.searchRestaurant(restaurantName: name);
    notifyListeners();
  }

  getImageFile({ImageSource source}) async {
    final pickedFile = await _picker.getImage(source: source, maxWidth: 640, maxHeight: 400);
    restaurantImage = File(pickedFile.path);
    restaurantImageFileName =  restaurantImage.path.substring(restaurantImage.path.indexOf('/') + 1);
    notifyListeners();
  }

  Future<String> _uploadImageFile({File imageFile, String imageFileName}) async {
    StorageReference reference = FirebaseStorage.instance.ref().child(imageFileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    String imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    return imageUrl;
  }
}