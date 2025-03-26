import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  const CartPage({super.key, required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void removeFromCart(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Removed from cart!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart", style: TextStyle(fontSize: 12))),
      body: ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          var item = widget.cartItems[index];
          return ListTile(
            leading: Image.asset(
              item["image"],
              width: 20,
              height: 30,
            ), // Fixed width issue
            title: Text(item["name"], style: const TextStyle(fontSize: 13)),
            subtitle: Text(
              "\$${item["price"].toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 7),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red, size: 10),
              onPressed: () => removeFromCart(index),
            ),
          );
        },
      ),
    );
  }
}
