import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.blue[800]),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.blue[800],
            ),
          ),
        ),
      ],
    );
  }

  ListTile _tile(String title, String subtitle, IconData icon) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      ),
      subtitle: Text(subtitle),
      leading: Icon(icon, color: Colors.blue[800]),
      minLeadingWidth: 32,
    );
  }

  // Horizontal facilities list with fixed-width wrappers so ListTile has bounded width.
  Widget _horizontalFacilitiesList() {
    final tiles = <Widget>[
      _tile('Djawatan Cafe', 'Cafe', Icons.local_cafe),
      _tile('Djawatan Gift Shop', 'Shop', Icons.shopify),
      _tile('Restroom Alam', 'WC', Icons.wc),
      _tile('Djawatan Theater', 'Theater', Icons.theaters),
      _tile('Resto Alam', 'Restaurant', Icons.restaurant),
    ];

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemBuilder: (context, index) {
        return SizedBox(width: 250, child: tiles[index]);
      },
      separatorBuilder: (_, __) => const SizedBox(width: 8),
      itemCount: tiles.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Wisata Gunung di Batu',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Text('Batu, Malang, Indonesia'),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.red[500]),
          const Text('4.1'),
        ],
      ),
    );

    final Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'CALL'),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: const Text(
        'Carilah teks di internet yang sesuai '
        'dengan foto atau tempat wisata yang ingin '
        'Anda tampilkan. '
        'Tambahkan nama dan NIM Anda sebagai '
        'identitas hasil pekerjaan Anda. '
        'Selamat mengerjakan 🙂.',
        softWrap: true,
      ),
    );

    Widget facilitiesSection = Container(
      padding: const EdgeInsets.all(32),
      child: SizedBox(height: 150, child: _horizontalFacilitiesList()),
    );

    return MaterialApp(
      title: 'Flutter layout: Leon Shan Yoedha Adjie, 2341720136',
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter layout demo')),
        body: ListView(
          children: [
            Image.asset(
              'assets/forest.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
            facilitiesSection,
          ],
        ),
      ),
    );
  }
}
