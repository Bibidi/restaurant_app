import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/helpers/style.dart';
import 'package:restaurant_app/models/cart_item.dart';
import 'package:restaurant_app/providers/user.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(text: "Orders",),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: userProvider.cartItems.length,
        itemBuilder: (_, index) {
          List<CartItemModel> cart = userProvider.cartItems;

          return ListTile(
            leading: CustomText(
              text: "\$${cart[index].price * cart[index].quantity}",
              weight: FontWeight.bold,
            ),
            title: Text(cart[index].name),
            subtitle: Text(DateTime.fromMillisecondsSinceEpoch(cart[index].date).toString()),
          );
        },
      ),
    );
  }
}
