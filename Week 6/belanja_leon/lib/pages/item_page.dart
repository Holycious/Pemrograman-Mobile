import 'package:flutter/material.dart';
import 'package:belanja_leon/models/item.dart';

class ItemPage extends StatelessWidget {
  final Item item;
  const ItemPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Hero(
            tag: 'item-image-${item.name}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(item.image, height: 260, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            item.name,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.store, size: 18, color: Colors.green.shade600),
              const SizedBox(width: 6),
              Text('Stok: ${item.stock}'),
              const Spacer(),
              _RatingDisplay(rating: item.rating),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Rp ${item.price}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.green.shade800,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Tambah ke Keranjang'),
          ),
          const SizedBox(height: 24),
          Text(
            'Deskripsi Produk',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            'Deskripsi contoh. Anda dapat mengganticanya dengan data asli '
            'atau mengambil dari API pada pengembangan berikutnya.',
          ),
        ],
      ),
    );
  }
}

class _RatingDisplay extends StatelessWidget {
  final double rating;
  const _RatingDisplay({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, size: 18, color: Colors.amber),
        const SizedBox(width: 4),
        Text(rating.toStringAsFixed(1)),
      ],
    );
  }
}
