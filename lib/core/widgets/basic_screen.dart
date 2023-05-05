import 'package:riverdown/core/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverdown/products/products_view.dart';
import 'package:riverdown/cart/cart_view.dart';
import 'package:flutter/material.dart';

class BasicScreen extends ConsumerWidget {
  const BasicScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isInCart = ref.watch(screenViewProvider) == ScreenView.cart;

    return Scaffold(appBar: appBar(isInCart, ref), body: screenBody(context, isInCart, ref));
  }

  AppBar appBar(bool isInCart, WidgetRef ref) {
    final String title = isInCart ? 'Carrinho' : 'Produtos';

    return AppBar(
      title: Text(title),
      leading: screenLeading(isInCart, ref),
      actions: screenActions(isInCart, ref),
    );
  }

  Widget screenLeading(bool isInCart, WidgetRef ref) => Visibility(
        visible: isInCart,
        child: BackButton(
          onPressed: () => ref.read(screenViewProvider.notifier).state = ScreenView.productsList,
        ),
      );

  List<Widget> screenActions(bool isInCart, WidgetRef ref) => [
        Visibility(
          visible: !isInCart,
          child: cartButton(ref),
        ),
        Visibility(
          visible: isInCart,
          child: cartTotalValue(ref),
        ),
      ];

  Padding cartTotalValue(WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, right: 8.0),
      child: Text('Total: R\$ ${ref.watch(cartProvider.notifier).total()}'),
    );
  }

  Stack cartButton(WidgetRef ref) {
    return Stack(
      children: [
        IconButton(
          onPressed: () => ref.read(screenViewProvider.notifier).state = ScreenView.cart,
          icon: const Icon(Icons.shopping_cart),
        ),
        Positioned(
          top: 4,
          right: 6,
          child: Text(
            '${ref.watch(cartProvider).length}',
            style: const TextStyle(fontSize: 9),
          ),
        )
      ],
    );
  }

  Widget screenBody(BuildContext context, bool isInCart, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        productsList(isInCart, context),
        const Spacer(),
        clearCartButton(isInCart, ref),
      ],
    );
  }

  Visibility productsList(bool isInCart, BuildContext context) {
    return Visibility(
      visible: isInCart,
      replacement: SizedBox(
        height: MediaQuery.of(context).size.height * .8,
        child: const ProductsView(),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .7,
        child: CartView(
          isInCart: isInCart,
        ),
      ),
    );
  }

  Visibility clearCartButton(bool isInCart, WidgetRef ref) {
    return Visibility(
      visible: isInCart && ref.read(cartProvider).isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            ref.read(cartProvider.notifier).clearCart();
          },
          child: const Text('Esvaziar Carrinho'),
        ),
      ),
    );
  }
}
