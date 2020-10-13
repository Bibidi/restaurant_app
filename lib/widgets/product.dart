import 'package:flutter/material.dart';
import 'package:restaurant_app/helpers/style.dart';
import 'package:restaurant_app/models/product.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;

  const ProductWidget({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            offset: Offset(-2, -1),
            blurRadius: 5,
          )
        ]
      ),
      child: Row(

      ),
    );
  }
}
