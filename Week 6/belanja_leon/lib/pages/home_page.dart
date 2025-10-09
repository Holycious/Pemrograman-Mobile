import 'package:flutter/material.dart';
import 'package:belanja_leon/models/item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Data dummy langsung di sini (tidak pakai file baru)
  List<Item> get _items => [
    Item(
      name: 'Gula Pasir',
      price: 18000,
      stock: 42,
      rating: 4.6,
      image: 'assets/images/sugar.jpg',
    ),
    Item(
      name: 'Garam Halus',
      price: 7000,
      stock: 120,
      rating: 4.3,
      image: 'assets/images/salt.jpeg',
    ),
    Item(
      name: 'Kopi Arabica',
      price: 52000,
      stock: 15,
      rating: 4.9,
      image: 'assets/images/kopi.jpeg',
    ),
    Item(
      name: 'Teh Hijau',
      price: 29000,
      stock: 33,
      rating: 4.4,
      image: 'assets/images/teh.jpeg',
    ),
  ];

  void _openItem(BuildContext context, Item item) {
    Navigator.pushNamed(context, '/item', arguments: item);
  }

  @override
  Widget build(BuildContext context) {
    final items = _items;
    return Scaffold(
      appBar: AppBar(title: const Text('Belanja Leon')),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return _ItemCard(
                  item: item,
                  onTap: () => _openItem(context, item),
                );
              },
            ),
          ),
          const _Footer(name: 'Leon Shan Yoedha Adjie', nim: '2341720136'),
        ],
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback onTap;
  const _ItemCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final priceStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
      color: Colors.green.shade700,
      fontWeight: FontWeight.bold,
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 6,
              offset: Offset(0, 3),
              color: Colors.black12,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Hero(
                  tag: 'item-image-${item.name}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      item.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(Icons.broken_image, size: 40),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  _RatingStars(rating: item.rating),
                  const Spacer(),
                  Text(
                    '${item.stock} stok',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Rp ${item.price}',
                style: priceStyle,
                maxLines: 1,
                overflow: TextOverflow.fade,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RatingStars extends StatelessWidget {
  final double rating;
  const _RatingStars({required this.rating});

  @override
  Widget build(BuildContext context) {
    final full = rating.floor();
    final half = (rating - full) >= 0.5;
    return Row(
      children: List.generate(5, (i) {
        if (i < full) {
          return const Icon(Icons.star, size: 14, color: Colors.amber);
        } else if (i == full && half) {
          return const Icon(Icons.star_half, size: 14, color: Colors.amber);
        } else {
          return const Icon(Icons.star_border, size: 14, color: Colors.amber);
        }
      }),
    );
  }
}

class _Footer extends StatelessWidget {
  final String name;
  final String nim;
  const _Footer({required this.name, required this.nim});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.green.shade50,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text(
        '$name - $nim',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w500,
          color: Colors.green.shade700,
        ),
      ),
    );
  }
}
