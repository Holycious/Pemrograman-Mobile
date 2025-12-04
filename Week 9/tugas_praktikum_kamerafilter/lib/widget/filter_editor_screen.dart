import 'dart:io';
import 'package:flutter/material.dart';
import 'filter_selector.dart';

class FilterEditorScreen extends StatefulWidget {
  const FilterEditorScreen({super.key, required this.imagePath});
  final String imagePath;

  @override
  State<FilterEditorScreen> createState() => _FilterEditorScreenState();
}

class _FilterEditorScreenState extends State<FilterEditorScreen> {
  late final List<FilterConfig> _filters;
  late final PageController _pageController;
  int _selected = 0;
  // Hue slider (0..360) — dipakai hanya untuk filter yang memiliki tintColor
  double _hue = 0.0;

  // Texture stabil (eksternal)
  static const _txAsfalt =
      'https://www.transparenttextures.com/patterns/asfalt-dark.png';
  static const _txDiamond =
      'https://www.transparenttextures.com/patterns/diamond-upholstery.png';
  static const _txNoise =
      'https://www.transparenttextures.com/patterns/noise-pattern-with-subtle-cross-lines.png';
  static const _txDarkMatter =
      'https://www.transparenttextures.com/patterns/dark-matter.png';
  static const _txPurtyWood =
      'https://www.transparenttextures.com/patterns/purty-wood.png';

  @override
  void initState() {
    super.initState();

    _filters = [
      const FilterConfig(name: 'Normal'),
      FilterConfig(
        name: 'Warm',
        tintColor: Colors.orange.shade200,
        blendMode: BlendMode.softLight,
        textureUrl: _txAsfalt,
        textureOpacity: 0.10,
      ),
      const FilterConfig(
        name: 'B&W',
        colorFilter: ColorFilter.matrix(<double>[
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
        ]),
      ),
      FilterConfig(
        name: 'Sepia',
        colorFilter: const ColorFilter.matrix(<double>[
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
        ]),
        textureUrl: _txPurtyWood,
        textureOpacity: 0.12,
      ),
      FilterConfig(
        name: 'Cool',
        tintColor: Colors.cyan.shade200,
        blendMode: BlendMode.hardLight,
        textureUrl: _txNoise,
        textureOpacity: 0.10,
      ),
      FilterConfig(
        name: 'Moody',
        tintColor: Colors.deepPurple.shade200,
        blendMode: BlendMode.multiply,
        textureUrl: _txDarkMatter,
        textureOpacity: 0.20,
      ),
      FilterConfig(
        name: 'Vintage',
        tintColor: Colors.brown.shade200,
        blendMode: BlendMode.modulate,
        textureUrl: _txDiamond,
        textureOpacity: 0.14,
      ),
    ];

    _pageController = PageController(initialPage: _selected);
    // Inisialisasi hue dari filter terpilih (jika ada)
    final initTint = _filters[_selected].tintColor;
    _hue = initTint != null ? HSVColor.fromColor(initTint).hue : 0.0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editor Filter'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement simpan hasil edit ke file apabila diperlukan
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Geser kiri/kanan untuk ganti filter.'),
                ),
              );
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Column(
        children: [
          // AREA PREVIEW — bisa digeser untuk ganti filter
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: Stack(
                  children: [
                    // PageView: geser kiri/kanan untuk ganti filter
                    PageView.builder(
                      controller: _pageController,
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (i) => setState(() {
                        _selected = i;
                        final tint = _filters[i].tintColor;
                        _hue = tint != null
                            ? HSVColor.fromColor(tint).hue
                            : 0.0;
                      }),
                      itemCount: _filters.length,
                      itemBuilder: (context, i) {
                        final f = _filters[i];
                        return _buildPreviewForFilter(f);
                      },
                    ),

                    // Nama filter (overlay)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 12,
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Container(
                            key: ValueKey(_selected),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              _filters[_selected].name,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Slider warna (hanya muncul bila filter terpilih memiliki tint)
          if (_filters[_selected].hasTint)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('Warna'),
                      const SizedBox(width: 12),
                      // preview warna kecil
                      Container(
                        width: 28,
                        height: 20,
                        decoration: BoxDecoration(
                          color: HSVColor.fromAHSV(
                            1,
                            _hue,
                            HSVColor.fromColor(
                              _filters[_selected].tintColor!,
                            ).saturation,
                            HSVColor.fromColor(
                              _filters[_selected].tintColor!,
                            ).value,
                          ).toColor(),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.black12),
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _hue,
                    min: 0,
                    max: 360,
                    divisions: 360,
                    label: '${_hue.round()}°',
                    onChanged: (v) => setState(() => _hue = v),
                  ),
                ],
              ),
            ),

          // CAROUSEL THUMBNAILS — tap untuk lompat ke filter tertentu
          FilterSelector(
            filters: _filters,
            selectedIndex: _selected,
            onSelected: (i) {
              setState(() => _selected = i);
              // sinkronkan hue saat berpindah filter
              final tint = _filters[i].tintColor;
              _hue = tint != null ? HSVColor.fromColor(tint).hue : 0.0;
              _pageController.animateToPage(
                i,
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOut,
              );
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // Widget preview satu filter
  Widget _buildPreviewForFilter(FilterConfig f) {
    // Jika filter memiliki tint, hitung warna efektf dari hue slider
    final Color? effectiveTint = f.tintColor != null
        ? HSVColor.fromAHSV(
            1,
            _hue,
            HSVColor.fromColor(f.tintColor!).saturation,
            HSVColor.fromColor(f.tintColor!).value,
          ).toColor()
        : null;
    return Stack(
      fit: StackFit.expand,
      children: [
        // Base image
        _applyMatrixIfAny(
          Image.file(
            File(widget.imagePath),
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                const Center(child: Text('Tidak bisa memuat gambar')),
          ),
          f,
        ),

        // Texture overlay (repeat) — opsional
        if (f.textureUrl != null && f.textureUrl!.isNotEmpty)
          IgnorePointer(
            ignoring: true,
            child: Opacity(
              opacity: f.textureOpacity.clamp(0.0, 1.0),
              child: Image.network(
                f.textureUrl!,
                repeat: ImageRepeat.repeat,
                alignment: Alignment.topLeft,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ),

        // Tint overlay (blend) — opsional. Gunakan warna hasil slider jika tersedia.
        if (effectiveTint != null)
          IgnorePointer(
            ignoring: true,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(effectiveTint, f.blendMode),
              child: Container(color: Colors.transparent),
            ),
          ),
      ],
    );
  }

  Widget _applyMatrixIfAny(Widget child, FilterConfig f) {
    if (f.colorFilter == null) return child;
    return ColorFiltered(colorFilter: f.colorFilter!, child: child);
  }
}
