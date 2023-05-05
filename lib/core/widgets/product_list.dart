import 'package:riverdown/core/widgets/produt_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverdown/core/model/product.dart';
import 'package:flutter/material.dart';

class ProductList extends ConsumerWidget {
  const ProductList({this.isInCart = false, required this.products, super.key});

  final List<Product> products;
  final bool isInCart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: products.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (ctx, index) {
        return ProductItem(
          product: products.elementAt(index),
          isInCart: isInCart,
        );
      },
    );
  }
}
