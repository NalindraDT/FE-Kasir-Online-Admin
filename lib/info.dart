import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Aplikasi Kasir Online',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Aplikasi Kasir Online ini dirancang untuk memudahkan pendataan produk dan pengelolaan penjualan di rumah makan Anda. '
              'Sebagai administrator, Anda dapat dengan mudah menambah, melihat, mengedit, dan menghapus data produk.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Fitur yang tersedia:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 10),
            _buildFeatureBullet('Lihat Produk: Menampilkan daftar lengkap semua produk yang tersedia.'),
            _buildFeatureBullet('Input Produk: Menambahkan produk baru ke sistem.'),
            _buildFeatureBullet('Edit Produk: Mengubah detail informasi produk yang sudah ada.'),
            _buildFeatureBullet('Hapus Produk: Menghapus produk dari daftar.'),
            const SizedBox(height: 30),
            const Text(
              'Dikembangkan oleh:',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const Text(
              'Nalindra Driyawan Thahai',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const Text(
              'Junior Mobile Programmer',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, left: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, size: 20, color: Colors.teal),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 15, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}