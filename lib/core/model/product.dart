import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

class Product extends Equatable {
  final DateTime? enteredCartAt;
  final double price;
  final String name;
  final Color color;
  final String id;
  final int qty;

  const Product({
    required this.price,
    required this.color,
    required this.name,
    this.enteredCartAt,
    required this.id,
    this.qty = 0,
  });

  Product copyWith({
    DateTime? enteredCartAt,
    double? price,
    String? name,
    Color? color,
    int? qty,
  }) {
    return Product(
      enteredCartAt: enteredCartAt,
      price: price ?? this.price,
      color: color ?? this.color,
      name: name ?? this.name,
      qty: qty ?? this.qty,
      id: id,
    );
  }

  @override
  List<Object?> get props => [];
}
