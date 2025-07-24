import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:product_list_app/blocs/cart/cart_cubit.dart';
import 'package:product_list_app/constants/app_colors.dart';
import 'package:product_list_app/models/product_model.dart';
import 'package:product_list_app/widgets/primary_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  final bool authBool;

  const ProductDetailsScreen(
      {super.key, required this.product, this.authBool = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.thumbnail, height: 200),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(8), // Optional: Add padding for spacing
              decoration: BoxDecoration(
                color: AppColors.whiteCard, // Background color of the container
                borderRadius:
                    BorderRadius.circular(8), // Optional: Rounded corners
                border: Border.all(
                  // Optional: Add a border
                  color: AppColors.border,
                  width: 1,
                ),
              ),
              child: Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  color: authBool
                      ? AppColors.price
                      : AppColors.successGreen, // Your custom color
                  fontWeight: FontWeight.bold, // Optional: Make text bold
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text('Category: ${product.category}'),
            const SizedBox(height: 8),
            Text('Stock: ${product.stock} available'),
            const SizedBox(height: 16),
            Text(product.description),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Add to Cart',
              onPressed: () {
                context.read<CartCubit>().addToCart(product);
                Fluttertoast.showToast(
                  msg: "${product.title} added to cart",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.black87,
                  textColor: AppColors.whiteCard,
                  fontSize: 14.0,
                );
              },
              backgroundColor:
                  authBool ? AppColors.lightBlue : AppColors.border,
              textColor: AppColors.whiteCard,
            ),
          ],
        ),
      ),
    );
  }
}
