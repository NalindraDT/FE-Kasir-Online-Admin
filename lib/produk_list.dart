import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kasir_app/produk_list_detail.dart'; // Halaman Detail Produk
import 'package:kasir_app/produk_input.dart'; // Halaman Input Produk
import 'package:kasir_app/produk_edit.dart'; // Halaman Edit Produk

// Halaman Daftar Produk
class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final String _baseUrl = 'http://192.168.19.167:8000/api/produk'; // URL API Produk

  late Future<List<dynamic>> _productsFuture; // Future untuk data produk
  @override
  void initState() {
    super.initState();
    _productsFuture = _fetchProducts(); // Ambil data saat inisialisasi
  }

  // Mengambil data produk dari API
  Future<List<dynamic>> _fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Failed to connect to API or parse data.');
    }
  }

  // Menghapus produk dari API
  Future<void> _deleteProduct(int productId) async {
    setState(() {}); // Untuk refresh UI
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/$productId'));
      if (response.statusCode == 204) { // Berhasil dihapus
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Produk berhasil dihapus!'),
            backgroundColor: Colors.green,
          ),
        );

        setState(() {
          _productsFuture = _fetchProducts(); // Refresh daftar
        });
      } else { // Gagal dihapus
        final Map<String, dynamic> errorData = json.decode(response.body);
        String errorMessage =
            errorData['message'] ?? 'Gagal menghapus produk. Silakan coba lagi.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      }
    } catch (e) { // Error koneksi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Koneksi gagal: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {}); // Sembunyikan loading jika ada
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        backgroundColor: Colors.teal,
        actions: [
          // Tombol Input Produk
          IconButton(
            icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductInput()),
              );

              if (result == true) { // Jika ada produk baru ditambahkan
                setState(() {
                  _productsFuture = _fetchProducts(); // Refresh daftar
                });
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>( // Menampilkan UI berdasarkan status Future
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Loading
          } else if (snapshot.hasError) {
            return Center( // Tampilan Error
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 50),
                  const SizedBox(height: 10),
                  Text('Error: ${snapshot.error}', textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _productsFuture = _fetchProducts(); // Coba lagi
                      });
                    },
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada produk yang tersedia.')); // Data kosong
          } else {
            final List<dynamic> products = snapshot.data!;
            return ListView.builder( // Menampilkan daftar produk
              padding: const EdgeInsets.all(8.0),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card( // Tampilan setiap item produk
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell( // Membuat Card bisa di-klik
                    onTap: () {
                      _showProductOptions(context, product); // Tampilkan opsi
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['nama'], // Nama produk
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Harga: Rp${double.parse(product['harga'].toString()).toStringAsFixed(2)}', // Harga produk
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  // Dialog Konfirmasi Hapus
  void _confirmDelete(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text(
            'Apakah Anda yakin ingin menghapus produk "${product['nama']}"?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Hapus', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteProduct(product['id']); // Panggil fungsi hapus
              },
            ),
          ],
        );
      },
    );
  }

  // Dialog Opsi Produk (Lihat, Update, Hapus)
  void _showProductOptions(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(product['nama']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.visibility),
                title: const Text('Lihat Detail Data'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(product: product),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Update Data'),
                onTap: () async {
                  Navigator.pop(context);
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductEdit(product: product),
                    ),
                  );

                  if (result == true) { // Jika update berhasil
                    setState(() {
                      _productsFuture = _fetchProducts(); // Refresh daftar
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Hapus Data'),
                onTap: () {
                  Navigator.pop(context);
                  _confirmDelete(context, product); // Panggil konfirmasi hapus
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
