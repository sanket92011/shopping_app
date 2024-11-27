import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/cart_provider.dart';
import 'package:shopping_app/presentation/widgets/cart_card.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    final totalPrice = cart.fold(0.0, (total, product) {
      double discountedPrice = product.originalPrice;
      return total + (discountedPrice * product.quantity);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Cart"),
      ),
      body: cart.isEmpty
          ? const Center(child: Text("Come on buy something"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final product = cart[index];
                      return CartCard(
                        imageUrl: product.productUrl,
                        title: product.title,
                        price: product.originalPrice,
                        onAdd: () {
                          ref
                              .read(cartProvider.notifier)
                              .increaseQuantity(product);
                        },
                        onRemove: () {
                          if (product.quantity > 1) {
                            ref
                                .read(cartProvider.notifier)
                                .decreaseQuantity(product);
                          } else {
                            ref
                                .read(cartProvider.notifier)
                                .removeFromCart(product);
                          }
                        },
                        quantity: product.quantity,
                        onDelete: () {
                          ref
                              .read(cartProvider.notifier)
                              .removeFromCart(product);
                        },
                      );
                    },
                  ),
                ),
                Stack(
                  children: [
                    Card(
                      elevation: 10,
                      color: Colors.white,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Amount Price:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              children: [
                                Text(
                                  '\$${totalPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          width: 120,
                          child: GestureDetector(
                            onTap: () {
                              debugPrint("Button Taped");
                            },
                            child: const Card(
                              color: Colors.redAccent,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Check Out",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
    );
  }
}
