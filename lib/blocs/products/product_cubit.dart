import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list_app/models/product_model.dart';
import 'product_state.dart';
import '../../services/product_service.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductService productService;
  List<Product> _allProducts = [];

  ProductCubit(this.productService) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      _allProducts = await productService.fetchProducts();

      emit(ProductLoaded(_allProducts));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void filterByCategory(String category) {
    if (category == 'all') {
      emit(ProductLoaded(_allProducts)); // Show all products
      return;
    }

    final filtered =
        _allProducts.where((product) => product.category == category).toList();

    emit(ProductLoaded(filtered));
  }

  void sortByPrice({required bool ascending}) {
    final currentState = state;
    if (currentState is ProductLoaded) {
      final sorted = [...currentState.products]..sort((a, b) =>
          ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price));
      emit(ProductLoaded(sorted));
    }
  }

  void clearFilter() {
    emit(ProductLoaded(_allProducts));
  }
}
