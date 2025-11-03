import 'package:flutter/material.dart';

@immutable
class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.color,
    this.onFilterSelected,
    this.textureUrl = defaultTextureUrl,
    this.textureOpacity = 0.12,
  });

  /// Warna filter (tint) di atas texture
  final Color color;

  /// Callback saat item dipilih
  final VoidCallback? onFilterSelected;

  /// URL texture eksternal (stabil). Bisa diganti dari luar.
  final String textureUrl;

  /// Intensitas texture (0-1). Semakin besar semakin terlihat teksturnya.
  final double textureOpacity;

  /// Default texture yang stabil dari transparenttextures.com
  static const String defaultTextureUrl =
      'https://www.transparenttextures.com/patterns/asfalt-dark.png';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFilterSelected,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipOval(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Lapisan texture (diulang agar menutupi area)
                Opacity(
                  opacity: textureOpacity.clamp(0.0, 1.0),
                  child: Image.network(
                    textureUrl,
                    repeat: ImageRepeat.repeat,
                    alignment: Alignment.topLeft,
                    // Saat loading, tampilkan background netral
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(color: Colors.black12);
                    },
                    // Saat error (misal 404), jangan crash: tampilkan background netral
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: Colors.black12);
                    },
                  ),
                ),

                // Lapisan warna (tint) di atas texture
                Container(color: color.withOpacity(0.5)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
