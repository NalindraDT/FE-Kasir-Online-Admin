import 'package:flutter/material.dart';
import 'dart:async';
import 'package:kasir_app/produk_list.dart'; // Halaman Daftar Produk
import 'package:kasir_app/produk_input.dart'; // Halaman Input Produk
import 'package:kasir_app/info.dart'; // Halaman Informasi Aplikasi
import 'package:kasir_app/login.dart'; // Halaman Login

// Dashboard / Menu Utama Aplikasi
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Admin Kasir'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.person_pin, size: 120, color: Colors.teal),
              const SizedBox(height: 40),

              // Tombol LIHAT PRODUK
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductList(),
                    ),
                  );
                },
                icon: const Icon(Icons.menu_book),
                label: const Text(
                  'LIHAT PRODUK',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.red[700],
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 15),

              // Tombol INPUT PRODUK
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductInput(),
                    ),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text(
                  'INPUT PRODUK',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 15),

              // Tombol INFORMASI
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InfoScreen()),
                  );
                },
                icon: const Icon(Icons.info),
                label: const Text('INFORMASI', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.grey[700],
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Splash Screen Awal Aplikasi
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Timer untuk navigasi setelah 5 detik
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.store, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text(
              'Kasir Online',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// Fungsi utama yang menjalankan aplikasi Flutter
void main() {
  runApp(const MyApp());
}

// Widget utama aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Kasir',
      theme: ThemeData(primarySwatch: Colors.teal, useMaterial3: true),
      home: const SplashScreen(), // Aplikasi dimulai dari SplashScreen
      debugShowCheckedModeBanner: false,
    );
  }
}
