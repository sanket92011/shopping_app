import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/product_model.dart';

final cartProvider =
    StateNotifierProvider<CartNotifier, List<ProductModel>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<ProductModel>> {
  CartNotifier() : super([]);

  void addToCart(ProductModel product) {
    final existingProduct = state.firstWhere(
      (item) => item.title == product.title,
      orElse: () => ProductModel(
        productUrl: product.productUrl,
        title: product.title,
        originalPrice: product.originalPrice,
        brand: product.brand,
        quantity: 0,
        discountPercentage: product.discountPercentage,
      ),
    );
    if (existingProduct.quantity > 0) {
      existingProduct.quantity += 1;
    } else {
      state = [...state, product];
    }
  }

  void removeFromCart(ProductModel product) {
    state = state.where((item) => item.title != product.title).toList();
  }

  void increaseQuantity(ProductModel product) {
    final index = state.indexWhere((item) => item.title == product.title);
    if (index != -1) {
      state[index].quantity += 1;
      state = [...state];
    }
  }

  void decreaseQuantity(ProductModel product) {
    final index = state.indexWhere((item) => item.title == product.title);
    if (index != -1 && state[index].quantity > 1) {
      state[index].quantity -= 1;
      state = [...state];
    }
  }
}
