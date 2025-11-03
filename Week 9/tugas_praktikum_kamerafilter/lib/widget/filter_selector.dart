import 'package:flutter/material.dart';
import 'filter_item.dart';

class FilterConfig {
  final String name;

  // Untuk filter berbasis matriks (grayscale/sepia)
  final ColorFilter? colorFilter;

  // Untuk filter berbasis tint (warna + blend mode)
  final Color? tintColor;
  final BlendMode blendMode;

  // Texture opsional sebagai overlay
  final String? textureUrl;
  final double textureOpacity;

  const FilterConfig({
    required this.name,
    this.colorFilter,
    this.tintColor,
    this.blendMode = BlendMode.hardLight,
    this.textureUrl,
    this.textureOpacity = 0.12,
  });

  bool get hasTint => tintColor != null;
  bool get hasMatrix => colorFilter != null;
}

class FilterSelector extends StatelessWidget {
  const FilterSelector({
    super.key,
    required this.filters,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<FilterConfig> filters;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          final f = filters[i];
          return FilterItem(
            label: f.name,
            color: f.tintColor,
            blendMode: f.blendMode,
            colorFilter: f.colorFilter,
            textureUrl: f.textureUrl,
            textureOpacity: f.textureOpacity,
            selected: i == selectedIndex,
            onSelected: () => onSelected(i),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 4),
        itemCount: filters.length,
      ),
    );
  }
}

// Util: matriks filter
ColorFilter grayscaleMatrix() {
  return const ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
}

ColorFilter sepiaMatrix() {
  return const ColorFilter.matrix(<double>[
    0.393,
    0.769,
    0.189,
    0,
    0,
    0.349,
    0.686,
    0.168,
    0,
    0,
    0.272,
    0.534,
    0.131,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
}
