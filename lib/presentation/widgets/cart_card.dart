import 'package:flutter/material.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.onAdd,
    required this.onRemove,
    required this.quantity,
    required this.onDelete,
  });

  final String imageUrl;
  final String title;
  final double price;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final int quantity;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      elevation: 6,
      child: Row(
        children: [
          Image.network(
            imageUrl,
            width: 120,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  '\$$price',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: onRemove,
              ),
              Text(
                quantity.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: onAdd,
              ),
              Container(
                height: 100,
                color: Colors.red,
                child: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: onDelete,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
