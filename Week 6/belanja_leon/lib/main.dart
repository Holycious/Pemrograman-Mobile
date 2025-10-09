import 'package:flutter/material.dart';
import 'package:belanja_leon/pages/home_page.dart';
import 'package:belanja_leon/pages/item_page.dart';
import 'package:belanja_leon/models/item.dart';

void main() {
  runApp(const BelanjaApp());
}

class BelanjaApp extends StatelessWidget {
  const BelanjaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belanja Leon',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        // Tidak definisikan langsung '/item' karena butuh arguments
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/item') {
          final item = settings.arguments as Item;
          return MaterialPageRoute(
            builder: (_) => ItemPage(item: item),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
