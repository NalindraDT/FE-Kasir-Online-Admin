import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Halaman Input Produk Baru
class ProductInput extends StatefulWidget {
  const ProductInput({super.key});

  @override
  State<ProductInput> createState() => _ProductInputState();
}

class _ProductInputState extends State<ProductInput> {
  final _formKey = GlobalKey<FormState>(); // Kunci validasi form
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();

  bool _isLoading = false; // Status loading
  final String _baseUrl = 'http://192.168.19.167:8000/api/produk'; // URL API POST

  @override
  void dispose() {
    _namaController.dispose();
    _hargaController.dispose();
    _stokController.dispose();
    super.dispose();
  }

  // Mengirim data produk baru ke API
  Future<void> _submitProduct() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final String nama = _namaController.text;
      final double harga = double.parse(_hargaController.text);
      final int stok = int.parse(_stokController.text);

      try {
        final response = await http.post(
          Uri.parse(_baseUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'nama': nama,
            'harga': harga,
            'stok': stok,
          }),
        );

        if (response.statusCode == 201) { // Berhasil ditambahkan
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Produk berhasil ditambahkan!'),
              backgroundColor: Colors.green,
            ),
          );
          _namaController.clear();
          _hargaController.clear();
          _stokController.clear();
          Navigator.pop(context, true); // Kembali & refresh daftar
        } else { // Gagal ditambahkan
          final Map<String, dynamic> errorData = json.decode(response.body);
          String errorMessage =
              errorData['message'] ?? 'Gagal menambahkan produk. Silakan coba lagi.';

          if (errorData.containsKey('errors')) {
              errorData['errors'].forEach((key, value) {
                  errorMessage += '\n${value[0]}';
              });
          }

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
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Produk Baru'),
        backgroundColor: Colors.teal,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Tampilan loading
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form( // Form input produk
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    // Input Nama Produk
                    TextFormField(
                      controller: _namaController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Produk',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.shopping_bag),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama produk tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    // Input Harga
                    TextFormField(
                      controller: _hargaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Harga',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harga tidak boleh kosong';
                        }
                        if (double.tryParse(value) == null ||
                            double.parse(value) < 0) {
                          return 'Harga harus angka positif';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    // Input Stok
                    TextFormField(
                      controller: _stokController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Stok',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.inventory),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Stok tidak boleh kosong';
                        }
                        if (int.tryParse(value) == null ||
                            int.parse(value) < 0) {
                          return 'Stok harus angka bulat positif';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    // Tombol SIMPAN PRODUK
                    ElevatedButton.icon(
                      onPressed: _submitProduct,
                      icon: const Icon(Icons.save),
                      label: const Text(
                        'SIMPAN PRODUK',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.teal,
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
