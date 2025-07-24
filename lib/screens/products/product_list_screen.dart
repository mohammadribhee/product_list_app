import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list_app/blocs/auth/auth_cubit.dart';
import 'package:product_list_app/blocs/auth/auth_state.dart';
import 'package:product_list_app/blocs/cart/cart_cubit.dart';
import 'package:product_list_app/blocs/cart/cart_state.dart';
import 'package:product_list_app/constants/app_colors.dart';
import 'package:product_list_app/screens/cart/cart_screen.dart';
import 'package:product_list_app/widgets/product_card.dart';
import '../../blocs/products/product_cubit.dart';
import '../../blocs/products/product_state.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthCubit>().state;
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(title: Text('Products'), actions: [
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            int itemCount = 0;
            if (state is CartUpdated) {
              itemCount = state.items.length;
            }

            return Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CartScreen()),
                    );
                  },
                ),
                if (itemCount > 0)
                  if (itemCount > 0)
                    Positioned(
                      right: 4,
                      top: 4,
                      child: IgnorePointer(
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.redNotifcation,
                            shape: BoxShape.circle,
                          ),
                          constraints:
                              BoxConstraints(minWidth: 18, minHeight: 18),
                          child: Text(
                            '$itemCount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
              ],
            );
          },
        ),
        (authState is Authenticated)
            ? IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  context.read<AuthCubit>().logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => ProductListScreen()),
                  );
                },
              )
            : SizedBox(),
      ]),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            final products = state.products;
            return Column(
              children: [
                // Add the sort and filter row here
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          context.read<ProductCubit>().filterByCategory(value);
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'all',
                            child: Text('All Categories'),
                          ),
                          ...state.products
                              .map((product) => product.category)
                              .toSet() // Remove duplicates
                              .map((category) => PopupMenuItem(
                                    value: category,
                                    child: Text(category),
                                  )),
                        ],
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.filter_alt),
                        ),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'asc') {
                            context
                                .read<ProductCubit>()
                                .sortByPrice(ascending: true);
                          } else {
                            context
                                .read<ProductCubit>()
                                .sortByPrice(ascending: false);
                          }
                        },
                        itemBuilder: (_) => [
                          PopupMenuItem(
                              value: 'asc', child: Text('Price: Low to High')),
                          PopupMenuItem(
                              value: 'desc', child: Text('Price: High to Low')),
                        ],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.sort),
                        ),
                      ),
                    ],
                  ),
                ),

                // Keep the existing ListView
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (_, index) {
                      final product = products[index];
                      bool authBool = authState is Authenticated;
                      return ProductCard(product: product, authBool: authBool);
                    },
                  ),
                ),
              ],
            );
          } else if (state is ProductError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container(); // initial state
        },
      ),
    );
  }
}
