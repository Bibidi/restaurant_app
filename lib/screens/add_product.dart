import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/helpers/style.dart';
import 'package:restaurant_app/providers/app.dart';
import 'package:restaurant_app/providers/category.dart';
import 'package:restaurant_app/providers/product.dart';
import 'package:restaurant_app/providers/user.dart';
import 'package:restaurant_app/widgets/custom_file_button.dart';
import 'package:restaurant_app/widgets/custom_text.dart';
import 'package:restaurant_app/widgets/loading.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: white,
        title: CustomText(
          text: "Add Product",
          color: black,
        ),
      ),
      body: appProvider.isLoading ? Loading() : ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: productProvider.productImage == null ? CustomFileUploadButton(
                    icon: Icons.image,
                    text: "Add image",
                    onTap: () async {
                      // productProvider.loadImageFile();
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext bc) {
                            return Container(
                              child: new Wrap(
                                children: <Widget>[

                                  new ListTile(
                                      leading: new Icon(Icons.image),
                                      title: new Text('From gallery'),
                                      onTap: () async {
                                        productProvider.getImageFile(
                                            source: ImageSource.gallery);
                                        Navigator.pop(context);
                                      }),
                                  new ListTile(
                                    leading: new Icon(Icons.camera_alt),
                                    title: new Text('Take a photo'),
                                    onTap: () async {
                                      productProvider.getImageFile(
                                          source: ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  ) : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(productProvider.productImage, height: 480,)),
                ),
              ],
            ),
          ),

          Visibility(
            visible: productProvider.productImage != null,
            child: FlatButton(
                onPressed: () async {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext bc) {
                        return Container(
                          child: new Wrap(
                            children: <Widget>[
                              new ListTile(
                                  leading: new Icon(Icons.image),
                                  title: new Text('From gallery'),
                                  onTap: () async {
                                    productProvider.getImageFile(
                                        source: ImageSource.gallery);
                                    Navigator.pop(context);
                                  }),
                              new ListTile(
                                leading: new Icon(Icons.camera_alt),
                                title: new Text('Take a photo'),
                                onTap: () async {
                                  productProvider.getImageFile(
                                      source: ImageSource.camera);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      });
                  Navigator.pop(context);
                },
                child: CustomText(text: "Change Image", color: primary,)
            ),
          ),

          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(text: "featured Magazine"),
                Switch(
                    value: productProvider.featured,
                    onChanged: (value) {
                      productProvider.changeFeatured();
                    }),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomText(
                text: "Category:",
                color: grey,
                weight: FontWeight.w300,
              ),
              DropdownButton<String>(
                  value: categoryProvider.selectedCategory,
                  style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.w300,
                  ),
                  icon: Icon(
                    Icons.filter_list,
                    color: primary,
                  ),
                  elevation: 0,
                  items: categoryProvider.categoryNames
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    categoryProvider.changeSelectedCategory(
                        newCategory: value.trim());
                  }),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: black, width: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.5),
                      offset: Offset(2, 7),
                      blurRadius: 7,
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: TextField(
                  controller: productProvider.name,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Product names",
                      hintStyle: TextStyle(
                        color: grey,
                        fontFamily: "Sen",
                        fontSize: 18,
                      )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: black, width: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.5),
                      offset: Offset(2, 7),
                      blurRadius: 7,
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: TextField(
                  controller: productProvider.description,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Product description",
                      hintStyle: TextStyle(
                        color: grey,
                        fontFamily: "Sen",
                        fontSize: 18,
                      )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: black, width: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.5),
                      offset: Offset(2, 7),
                      blurRadius: 7,
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: TextField(
                  controller: productProvider.price,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Price",
                      hintStyle: TextStyle(
                        color: grey,
                        fontFamily: "Sen",
                        fontSize: 18,
                      )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Container(
                decoration: BoxDecoration(
                    color: primary,
                    border: Border.all(color: black, width: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: grey.withOpacity(0.5),
                        offset: Offset(2, 7),
                        blurRadius: 4,
                      )
                    ]),
                child: FlatButton(
                  onPressed: () async {
                    appProvider.changeLoading();
                    if (!await productProvider.uploadProduct(
                      category: categoryProvider.selectedCategory,
                      restaurant: userProvider.restaurant.name,
                      restaurantId: userProvider.restaurant.id
                    )) {
                      _key.currentState.showSnackBar(SnackBar(
                        content: Text("Upload failed"),
                        duration: const Duration(seconds: 10),
                      ));
                      appProvider.changeLoading();
                      return;
                    }
                    productProvider.clear();
                    _key.currentState.showSnackBar(SnackBar(
                      content: Text("Upload completed"),
                      duration: const Duration(seconds: 10),
                    ));
                    userProvider.loadProductsByRestaurant(restaurantId: userProvider.restaurant.id);
                    await userProvider.reload();
                    appProvider.changeLoading();
                },
                  child: CustomText(
                    text: "Post",
                    color: white,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
