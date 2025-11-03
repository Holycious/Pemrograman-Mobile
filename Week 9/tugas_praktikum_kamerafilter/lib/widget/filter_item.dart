import 'package:flutter/material.dart';

@immutable
class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.label,
    this.color,
    this.blendMode = BlendMode.hardLight,
    this.onSelected,
    this.textureUrl,
    this.textureOpacity = 0.12,
    this.colorFilter,
    this.selected = false,
  });

  final String label;
  final Color? color; // tint warna opsional
  final BlendMode blendMode;
  final VoidCallback? onSelected;
  final String? textureUrl; // url texture opsional
  final double textureOpacity; // 0..1
  final ColorFilter? colorFilter; // untuk grayscale/sepia dll
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final circle = ClipOval(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Lapisan dasar: jika ada colorFilter matrix, terapkan di bawah
          if (colorFilter != null)
            ColorFiltered(colorFilter: colorFilter!, child: _textureLayer())
          else
            _textureLayer(),

          // Lapisan tint warna (mode blend)
          if (color != null)
            ColorFiltered(
              colorFilter: ColorFilter.mode(color!, blendMode),
              child: Container(color: Colors.transparent),
            ),
        ],
      ),
    );

    return GestureDetector(
      onTap: onSelected,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  Positioned.fill(child: circle),
                  if (selected)
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _textureLayer() {
    if (textureUrl == null || textureUrl!.isEmpty) {
      // Background netral agar thumbnail tetap terlihat
      return Container(color: Colors.black12);
    }
    return Opacity(
      opacity: textureOpacity.clamp(0.0, 1.0),
      child: Image.network(
        textureUrl!,
        repeat: ImageRepeat.repeat,
        alignment: Alignment.topLeft,
        errorBuilder: (_, __, ___) => Container(color: Colors.black12),
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(color: Colors.black12);
        },
      ),
    );
  }
}
