import 'package:riverdown/core/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverdown/core/model/product.dart';
import 'package:flutter/material.dart';

class ProductItem extends ConsumerWidget {
  const ProductItem({
    required this.isInCart,
    required this.product,
    super.key,
  });

  final Product product;
  final bool isInCart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 8),
          Text(product.name),
          const Spacer(),
          Text('${ref.watch<int>(productQtyOnCart(product.id))}'),
          const SizedBox(width: 24),
          Visibility(
            visible: isInCart && ref.watch<int>(productQtyOnCart(product.id)) == 1,
            replacement: decreaseQtyOrAddProductButton(ref),
            child: removeItemButton(ref),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  IconButton removeItemButton(WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(cartProvider.notifier).removeFromCart(product.id);
      },
      icon: const Icon(Icons.delete),
    );
  }

  IconButton decreaseQtyOrAddProductButton(WidgetRef ref) {
    return IconButton(
      onPressed: () {
        if (isInCart) {
          ref.read(cartProvider.notifier).decreaseProductQty(product.id);
        } else {
          ref.read(cartProvider.notifier).addToCart(product);
        }
      },
      icon: Icon(isInCart ? Icons.minimize : Icons.add),
    );
  }
}
