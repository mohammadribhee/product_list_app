import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list_app/blocs/auth/auth_cubit.dart';
import 'package:product_list_app/blocs/auth/auth_state.dart';
import 'package:product_list_app/constants/app_colors.dart';
import 'package:product_list_app/screens/auth/login_screen.dart';
import 'package:product_list_app/screens/cart/checkout_screen.dart';
import 'package:product_list_app/widgets/cart_item_card.dart';
import 'package:product_list_app/widgets/primary_button.dart';
import '../../blocs/cart/cart_cubit.dart';
import '../../blocs/cart/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthCubit>().state;
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(title: Text('Your Cart')),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartInitial ||
              (state is CartUpdated && state.items.isEmpty)) {
            return Center(
                child: Text('Your cart is empty',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)));
          } else if (state is CartUpdated) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (_, index) {
                      final item = state.items[index];
                      bool authBool = authState is Authenticated;
                      return CartItemCard(
                          item: item, context: context, authBool: authBool);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Total: \$${state.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      PrimaryButton(
                        label: 'Proceed to Checkout',
                        backgroundColor: AppColors.whiteCard,
                        textColor: authState is Authenticated
                            ? AppColors.peach
                            : AppColors.black,
                        onPressed: () {
                          final authState = context.read<AuthCubit>().state;

                          if (authState is Authenticated) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const CheckoutScreen()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Please log in to proceed to checkout"),
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
