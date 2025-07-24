import '../../models/cart_item.dart';

abstract class CartState {}

class CartInitial extends CartState {
  final List<CartItem> items;

  CartInitial(this.items);
}

class CartUpdated extends CartState {
  final List<CartItem> items;

  CartUpdated(this.items);

  double get totalPrice => items.fold(0, (sum, item) => sum + item.totalPrice);
}
