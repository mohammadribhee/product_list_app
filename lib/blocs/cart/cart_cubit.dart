import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product_model.dart';
import '../../models/cart_item.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial([]));

  void addToCart(Product product) {
    final currentItems = List<CartItem>.from(_currentItems);
    final index =
        currentItems.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      currentItems[index].quantity++;
    } else {
      currentItems.add(CartItem(product: product));
    }

    emit(CartUpdated(currentItems));
  }

  void removeFromCart(Product product) {
    final currentItems = List<CartItem>.from(_currentItems);
    currentItems.removeWhere((item) => item.product.id == product.id);
    emit(CartUpdated(currentItems));
  }

  void increaseQty(Product product) {
    final currentItems = List<CartItem>.from(_currentItems);
    final index =
        currentItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      currentItems[index].quantity++;
      emit(CartUpdated(currentItems));
    }
  }

  void decreaseQty(Product product) {
    final currentItems = List<CartItem>.from(_currentItems);
    final index =
        currentItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1 && currentItems[index].quantity > 1) {
      currentItems[index].quantity--;
      emit(CartUpdated(currentItems));
    }
  }

  List<CartItem> get _currentItems {
    if (state is CartUpdated) {
      return (state as CartUpdated).items;
    } else if (state is CartInitial) {
      return (state as CartInitial).items;
    }
    return [];
  }
}
