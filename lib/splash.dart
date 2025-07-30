import 'package:flutter/material.dart';
import 'dart:async'; // Diperlukan untuk Timer
import 'package:kasir_app/main.dart'; // Import DashboardScreen

class WelcomeSplashScreen extends StatefulWidget {
  const WelcomeSplashScreen({super.key});

  @override
  State<WelcomeSplashScreen> createState() => _WelcomeSplashScreenState();
}

class _WelcomeSplashScreenState extends State<WelcomeSplashScreen> {
  @override
  void initState() {
    super.initState();
    // Menggunakan Timer untuk menunda navigasi selama 5 detik
    Timer(const Duration(seconds: 5), () {
      // Setelah 5 detik, navigasi ke DashboardScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.teal, // Warna latar belakang
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline, // Icon centang atau selamat datang
              size: 80,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              'Selamat datang di sistem aplikasi kasir online',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}