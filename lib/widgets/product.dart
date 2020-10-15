import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/helpers/style.dart';
import 'package:restaurant_app/models/product.dart';
import 'package:restaurant_app/providers/user.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;

  const ProductWidget({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
          children: [
            Container(
              width: 140,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: Image.network(product.image, fit: BoxFit.fill,),
              ),
            ),
            Expanded(child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(text: product.name, size: 20,),
                    ),
                  ],
                ),

                SizedBox(height: 18,),

                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Row(
                    children: [
                      CustomText(text: "from: ", color: grey, weight: FontWeight.w300, size: 14,),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: () {},
                        child: CustomText(text: product.restaurant, color: primary, weight: FontWeight.w300, size: 14,),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Icon(Icons.star, color: red, size: 20,),
                        ),

                        SizedBox(width: 2,),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CustomText(text: product.rating.toString(), color: grey, size: 14,),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CustomText(text: "\$${product.price}", weight: FontWeight.bold,),
                    ),
                  ],
                )

              ],
            )),
            IconButton(icon: Icon(Icons.delete), onPressed: () async {
              bool ok = await userProvider.removeFromProducts(productId: product.id);
              if (ok) {
                userProvider.reload();
              }
            })
          ],
        ),
      ),
    );
  }
}
