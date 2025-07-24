import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:product_list_app/blocs/cart/cart_cubit.dart';
import 'package:product_list_app/constants/app_colors.dart';
import 'package:product_list_app/models/product_model.dart';
import 'package:product_list_app/screens/products/product_details_screen.dart';
import 'package:product_list_app/widgets/primary_button.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool authBool;

  const ProductCard({super.key, required this.product, this.authBool = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteCard,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image on left
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                product.thumbnail,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 12),

            // Product details in middle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.border,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          authBool ? AppColors.price : AppColors.successGreen,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 12),

            // Buttons on right
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PrimaryButton(
                  label: 'Add',
                  onPressed: () {
                    context.read<CartCubit>().addToCart(product);
                    Fluttertoast.showToast(
                      msg: "${product.title} added to cart",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.black87,
                      textColor: Colors.white,
                      fontSize: 14.0,
                    );
                  },
                  backgroundColor:
                      authBool ? AppColors.lightBlue : AppColors.border,
                  textColor: AppColors.whiteCard,
                ),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsScreen(
                            product: product, authBool: authBool),
                      ),
                    );
                  },
                  child: Text('Details',
                      style: TextStyle(
                        color: authBool ? AppColors.peach : AppColors.black,
                        fontSize: 16,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
