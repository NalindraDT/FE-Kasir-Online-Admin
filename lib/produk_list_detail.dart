import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal

// Halaman Detail Produk
class ProductDetail extends StatelessWidget {
  final Map<String, dynamic> product; // Data produk yang ditampilkan

  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Format tanggal created_at dan updated_at
    String createdAt = product['created_at'] != null
        ? DateFormat('dd MMMM yyyy, HH:mm:ss').format(DateTime.parse(product['created_at']))
        : 'N/A';
    String updatedAt = product['updated_at'] != null
        ? DateFormat('dd MMMM yyyy, HH:mm:ss').format(DateTime.parse(product['updated_at']))
        : 'N/A';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card( // Kartu detail produk
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Nama Produk
                Text(
                  product['nama'],
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const Divider(height: 30, thickness: 1),
                // Baris detail Harga
                _buildDetailRow(
                  icon: Icons.attach_money,
                  label: 'Harga',
                  value: 'Rp${double.parse(product['harga'].toString()).toStringAsFixed(2)}',
                ),
                // Baris detail Stok
                _buildDetailRow(
                  icon: Icons.inventory,
                  label: 'Stok',
                  value: product['stok'].toString(),
                ),
                // Baris detail Dibuat Pada
                _buildDetailRow(
                  icon: Icons.calendar_today,
                  label: 'Dibuat Pada',
                  value: createdAt,
                ),
                // Baris detail Diperbarui Pada
                _buildDetailRow(
                  icon: Icons.update,
                  label: 'Diperbarui Pada',
                  value: updatedAt,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget pembangun baris detail (icon, label, value)
  Widget _buildDetailRow({required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.teal, size: 24),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
