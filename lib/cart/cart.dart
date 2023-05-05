import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverdown/core/model/product.dart';

class Cart extends StateNotifier<List<Product>> {
  Cart() : super([]);

  void addToCart(Product product) {
    if (state.where((element) => element.id == product.id).isEmpty) {
      state = [
        ...state,
        product.copyWith(
          enteredCartAt: DateTime.now(),
          qty: product.qty + 1,
        )
      ];

      state.sort(sortProductsInCart);
    } else {
      state.removeWhere((element) => element.id == product.id);

      state = [
        ...state,
        product.copyWith(
          qty: product.qty + 1,
          enteredCartAt: DateTime.now(),
        )
      ];

      state.sort(sortProductsInCart);
    }
  }

  void removeFromCart(String id) {
    state = [
      for (final product in state)
        if (product.id != id) product
    ];

    state.sort(sortProductsInCart);
  }

  void decreaseProductQty(String id) {
    final product = state.firstWhere((element) => element.id == id);
    state.removeWhere((element) => element.id == id);
    state = [...state, product.copyWith(qty: product.qty - 1, enteredCartAt: product.enteredCartAt)];
    state.sort(sortProductsInCart);
  }

  void clearCart() => state = [];

  double total() => state.fold(0, (previousValue, element) => previousValue + (element.price * element.qty));

  int sortProductsInCart(Product a, Product b) {
    if (a.enteredCartAt!.isBefore(b.enteredCartAt!)) return -1;
    if (a.enteredCartAt!.isAfter(b.enteredCartAt!)) return 1;

    return 0;
  }
}
