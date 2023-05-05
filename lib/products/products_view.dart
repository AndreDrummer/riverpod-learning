import 'package:riverdown/core/widgets/product_list.dart';
import 'package:riverdown/core/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverdown/core/model/product.dart';
import 'package:flutter/material.dart';

class ProductsView extends ConsumerWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = [
      const Product(id: '2', color: Colors.pinkAccent, name: 'iPhone 7 Mini', price: 700),
      const Product(name: 'Redmi Note 8 Pro', color: Colors.black, price: 1000, id: '1'),
      const Product(id: '7', color: Colors.blueGrey, name: 'MAC PRO M1', price: 23000),
      const Product(id: '5', color: Colors.amber, name: 'Acustic Guitar', price: 900),
      const Product(id: '8', color: Colors.black38, name: 'Microphone', price: 150),
      const Product(id: '4', color: Colors.red, name: 'Eletric Guitar', price: 1200),
      const Product(id: '6', color: Colors.grey, name: 'Amplifier', price: 800),
      const Product(id: '9', color: Colors.white38, name: 'Garden', price: 950),
      const Product(id: '3', color: Colors.white, name: 'Carro', price: 50000),
    ];

    return ProductList(
      products: List<Product>.generate(products.length, (index) {
        final presetProduct = products[index];
        final productIsInCart = ref.watch(cartProvider).where((prod) => prod.id == presetProduct.id).isNotEmpty;

        return productIsInCart
            ? presetProduct.copyWith(qty: ref.watch(cartProvider).firstWhere((prod) => prod.id == presetProduct.id).qty)
            : presetProduct;
      }),
    );
  }
}
