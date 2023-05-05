import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverdown/core/model/product.dart';
import 'package:riverdown/cart/cart.dart';

enum ScreenView {
  productsList,
  cart,
}

final screenViewProvider = StateProvider<ScreenView>((ref) => ScreenView.productsList);

final cartProvider = StateNotifierProvider<Cart, List<Product>>((ref) => Cart());

final productQtyOnCart = Provider.family<int, String>((ref, id) {
  final products = ref.watch(cartProvider).where((prod) => prod.id == id);

  return products.isEmpty ? 0 : products.first.qty;
});
