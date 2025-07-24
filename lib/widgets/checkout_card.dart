import 'package:flutter/material.dart';
import 'package:product_list_app/constants/app_colors.dart';
import 'package:product_list_app/models/cart_item.dart';

class CheckoutCard extends StatelessWidget {
  final CartItem item;

  const CheckoutCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteCard,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image on left
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                item.product.thumbnail,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

            // Product details in middle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.quantity} × \$${item.product.price.toStringAsFixed(2)}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.border,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Price on right
            Container(
              alignment: Alignment.centerRight,
              height: 100,
              child: Text(
                '\$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.price,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
