import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:product_list_app/blocs/cart/cart_cubit.dart';
import 'package:product_list_app/blocs/cart/cart_state.dart';
import 'package:product_list_app/constants/app_colors.dart';
import 'package:product_list_app/models/cart_item.dart';
import 'package:product_list_app/widgets/checkout_card.dart';
import 'package:product_list_app/widgets/primary_button.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartState = context.watch<CartCubit>().state;

    // Extract the cart items
    List<CartItem> cartItems = [];
    if (cartState is CartUpdated) {
      cartItems = cartState.items;
    } else if (cartState is CartInitial) {
      cartItems = cartState.items;
    }

    // Calculate total
    final total = cartItems.fold<double>(
      0.0,
      (sum, item) => sum + item.product.price * item.quantity,
    );

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text('Your cart is empty.'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return CheckoutCard(item: item);
                    },
                  ),
                ),
                Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('\$${total.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      label: 'Confirm Order',
                      onPressed: () {
                        Fluttertoast.showToast(
                          msg: "Order confirmed!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.black87,
                          textColor: Colors.white,
                          fontSize: 14.0,
                        );
                      },
                      backgroundColor: AppColors.lightBlue,
                      textColor: AppColors.whiteCard,
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
