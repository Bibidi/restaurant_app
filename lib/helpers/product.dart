import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_app/models/product.dart';

class ProductServices {
  String collection = "products";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future createProduct({Map data}) async {
    _firestore.collection(collection).doc(data['id']).set(data);
  }


  Future deleteProduct({String productId}) async {
    _firestore.collection(collection).doc(productId).delete();
  }

  Future<List<ProductModel>> getProducts() async =>
      _firestore.collection(collection).get().then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  void likeOrDislikeProduct({String id, List<String> userLikes}) {
    _firestore.collection(collection).doc(id).update({
      "userLikes": userLikes,
    });
  }

  Future<List<ProductModel>> getProductsByRestaurant({String id}) async =>
      _firestore
          .collection(collection)
          .where("restaurantId", isEqualTo: id)
          .get()
          .then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<ProductModel>> getProductsOfCategory({String category}) async => _firestore
          .collection(collection)
          .where("category", isEqualTo: category)
          .get()
          .then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future searchProducts({String productName}) {
    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((result) {
      List<ProductModel> products = [];
      for (DocumentSnapshot product in result.docs) {
        products.add(ProductModel.fromSnapshot(product));
      }
      return products;
    });
  }
}
