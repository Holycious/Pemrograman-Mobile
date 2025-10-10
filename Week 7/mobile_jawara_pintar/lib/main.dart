import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    const primary = Color.fromARGB(255, 100, 92, 255); // Ungu seperti contoh
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        useMaterial3: true,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black87,
          displayColor: Colors.black87,
          fontFamily: GoogleFonts.figtree().fontFamily,
        ),
      ),
      routes: {'/dashboard': (_) => const DashboardPage()},
      home: const BaseLayout(),
    );
  }
}

class BaseLayout extends StatelessWidget {
  const BaseLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        // Gambar latar (opsional)
        decoration: const BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.saturation),
            image: AssetImage("images/login_jawara.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        // Overlay gelap agar konten kontras
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.35)),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 1) HEADER: Logo + Judul di sampingnya
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Box untuk logo
                          Container(
                            width: 52,
                            height: 52,
                            child: Image.asset(
                              'images/logo.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stack) {
                                // fallback jika logo belum ada
                                return Icon(
                                  Icons.image_outlined,
                                  color: cs.primary,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Jawara Pintar',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 2) LOGIN CONTAINER
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Label Email
                          const Text(
                            'Email',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Field Email
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: _inputDecoration(
                              hint: 'Masukkan email disini',
                            ),
                          ),
                          const SizedBox(height: 18),

                          // Label Password
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Field Password
                          TextField(
                            obscureText: true,
                            decoration: _inputDecoration(
                              hint: 'Masukkan password disini',
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Tombol Login
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(
                                  255,
                                  99,
                                  91,
                                  255,
                                ),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () => Navigator.pushReplacementNamed(
                                context,
                                '/dashboard',
                              ),
                              child: const Text('Login'),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Footer link "Belum punya akun? Daftar"
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Belum punya akun? ',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Navigate to Daftar'),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Daftar',
                                  style: TextStyle(
                                    color: Color(0xFF2F80ED), // biru link
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Solusi digital untuk manajemen keuangan dan kegiatan warga',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({required String hint}) {
    const borderColor = Color(0xFFEAEAEA);
    const focusedColor = Color.fromARGB(255, 100, 92, 255);
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black38),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: focusedColor, width: 1.5),
      ),
    );
  }
}
