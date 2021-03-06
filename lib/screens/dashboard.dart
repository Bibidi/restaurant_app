import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/helpers/screen_navigation.dart';
import 'package:restaurant_app/helpers/style.dart';
import 'package:restaurant_app/providers/product.dart';
import 'package:restaurant_app/providers/user.dart';
import 'package:restaurant_app/screens/add_product.dart';
import 'package:restaurant_app/screens/login.dart';
import 'package:restaurant_app/screens/orders.dart';
import 'package:restaurant_app/screens/products.dart';
import 'package:restaurant_app/widgets/custom_text.dart';
import 'package:restaurant_app/widgets/product.dart';
import 'package:restaurant_app/widgets/small_floating_button.dart';
import 'package:transparent_image/transparent_image.dart';

class DashboardScreen extends StatelessWidget {

  const DashboardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    bool hasImage = true;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        backgroundColor: primary,
        title: CustomText(
          text: "Sales: \$${userProvider.totalSales}",
          color: white,
        ),
        actions: [],
      ),
      drawer: Drawer(

        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: primary,
              ),
              accountName: CustomText(
                text: userProvider.restaurant.name,
                color: white,
                weight: FontWeight.bold,
                size: 18,
              ),

              accountEmail: CustomText(
                text: userProvider.user.email,
                color: white,
              ),
            ),
            ListTile(
              onTap: () {

              },
              leading: Icon(Icons.home),
              title: CustomText(text: "Home",),
            ),
            ListTile(
              onTap: () {

              },
              leading: Icon(Icons.restaurant),
              title: CustomText(text: "My restaurant",),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, OrdersScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "Orders",),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, ProductsScreen());
              },
              leading: Icon(Icons.fastfood),
              title: CustomText(text: "Products",),
            ),
            ListTile(
              onTap: () {
                userProvider.signOut();
                changeScreenReplacement(context, LoginScreen());
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log out",),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [

                // restaurant image
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(2),
                    bottomRight: Radius.circular(2),
                  ),
                  child: imageWidget(hasImage: hasImage, url: userProvider.restaurant.image),
                ),

                // fading black
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(2),
                      bottomRight: Radius.circular(2),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.05),
                        Colors.black.withOpacity(0.025),
                      ],
                    ),
                  ),
                ),

                // restaurant name
                Positioned.fill(
                  bottom: 30,
                  left: 10,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: CustomText(
                      text: userProvider.restaurant.name,
                      color: white,
                      size: 24,
                      weight: FontWeight.normal,
                    ),
                  ),
                ),

                Positioned.fill(
                  bottom: 10,
                  left: 10,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: CustomText(
                      text: "Average Price: \$${userProvider.avgPrice.toStringAsFixed(2)}",
                      color: white,
                      size: 16,
                      weight: FontWeight.w300,
                    ),
                  ),
                ),

                // close button
                Positioned.fill(
                  top: 5,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: black.withOpacity(0.3),
                          ),
                          child: FlatButton.icon(
                              onPressed: () {

                              },
                              icon: Icon(Icons.edit, color: white,),
                              label: CustomText(
                                text: "Edit",
                                color: white,
                              ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned.fill(
                  bottom: 2,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.star,
                                color: Colors.yellow[900],
                                size: 20,
                              ),
                            ),
                            Text("${(userProvider.restaurantRating).toStringAsFixed(1)}"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned.fill(
                  top: 5,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                          child: SmallButton(Icons.favorite)),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      offset: Offset(-2, -1),
                      blurRadius: 5
                    ),
                  ]
                ),
                child: ListTile(
                  onTap: () {
                    changeScreen(context, OrdersScreen());
                  },
                  leading: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset("images/delivery.png"),
                  ),
                  title: CustomText(
                    text: "Orders",
                    size: 24,
                  ),
                  trailing: CustomText(
                    text: userProvider.orders.length.toString(),
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(-2, -1),
                          blurRadius: 5
                      ),
                    ]
                ),
                child: ListTile(
                  onTap: () {
                    changeScreen(context, ProductsScreen());
                  },
                  leading: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset("images/fd.png"),
                  ),
                  title: CustomText(
                    text: "Products",
                    size: 24,
                  ),
                  trailing: CustomText(
                    text: userProvider.products.length.toString(),
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageWidget({bool hasImage, String url}) {
    if (hasImage) {
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: url,
        height: 160,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
    else {
      return Container(
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt,
                  size: 40,
                )
              ],
            ),
            CustomText(text: "No Photo"),
          ],
        ),
      );
    }
  }
}
