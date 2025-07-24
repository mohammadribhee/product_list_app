import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list_app/blocs/cart/cart_cubit.dart';
import 'package:product_list_app/constants/app_colors.dart';
import 'package:product_list_app/models/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final BuildContext context;
  final bool authBool;

  const CartItemCard(
      {super.key,
      required this.item,
      required this.context,
      this.authBool = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                item.product.thumbnail,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text('\$${item.product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: authBool
                              ? AppColors.price
                              : AppColors.successGreen,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () =>
                          context.read<CartCubit>().decreaseQty(item.product),
                      iconSize: 25,
                    ),
                    Text(
                      item.quantity.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () =>
                          context.read<CartCubit>().increaseQty(item.product),
                      iconSize: 25,
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: AppColors.errorRed),
                  onPressed: () =>
                      context.read<CartCubit>().removeFromCart(item.product),
                  iconSize: 25,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
