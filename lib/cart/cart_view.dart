import 'package:riverdown/core/widgets/product_list.dart';
import 'package:riverdown/core/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class CartView extends ConsumerWidget {
  const CartView({required this.isInCart, super.key});

  final bool isInCart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProductList(products: ref.watch(cartProvider), isInCart: isInCart);
  }
}
