import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/helpers/screen_navigation.dart';
import 'package:restaurant_app/helpers/style.dart';
import 'package:restaurant_app/providers/user.dart';
import 'package:restaurant_app/widgets/custom_text.dart';
import 'package:restaurant_app/widgets/product.dart';

import 'add_product.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(text: "Products",),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: userProvider.products
              .map((item) => GestureDetector(
            onTap: () {},
            child: ProductWidget(product: item,),
          )).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        child: Icon(Icons.add),
        onPressed: () {
          changeScreen(context, AddProductScreen());
        },
      ),
    );
  }
}
