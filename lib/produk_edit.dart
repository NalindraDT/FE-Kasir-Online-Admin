import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Halaman Edit Produk
class ProductEdit extends StatefulWidget {
  final Map<String, dynamic> product; // Data produk yang akan diedit

  const ProductEdit({super.key, required this.product});

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  final _formKey = GlobalKey<FormState>(); // Kunci validasi form
  late TextEditingController _namaController;
  late TextEditingController _hargaController;
  late TextEditingController _stokController;

  bool _isLoading = false; // Status loading
  final String _baseUrl = 'http://192.168.19.167:8000/api/produk'; // URL API PUT

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan data produk yang diterima
    _namaController = TextEditingController(text: widget.product['nama']);
    _hargaController = TextEditingController(
      text: widget.product['harga'].toString(),
    );
    _stokController = TextEditingController(
      text: widget.product['stok'].toString(),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _hargaController.dispose();
    _stokController.dispose();
    super.dispose();
  }

  // Mengirim data produk yang diupdate ke API
  Future<void> _updateProduct() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final int productId = widget.product['id']; // ID produk
      final String nama = _namaController.text;
      final double harga = double.parse(_hargaController.text);
      final int stok = int.parse(_stokController.text);

      try {
        final response = await http.put( // Request PUT
          Uri.parse('$_baseUrl/$productId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'nama': nama,
            'harga': harga,
            'stok': stok,
          }),
        );

        if (response.statusCode == 200) { // Berhasil diupdate
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Produk berhasil diupdate!'),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pop(context, true); // Kembali & refresh daftar
        } else { // Gagal diupdate
          final Map<String, dynamic> errorData = json.decode(response.body);
          String errorMessage =
              errorData['message'] ?? 'Gagal mengupdate produk. Silakan coba lagi.';

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
        title: const Text('Edit Produk'),
        backgroundColor: Colors.teal,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Tampilan loading
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form( // Form edit produk
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
                    // Tombol UPDATE PRODUK
                    ElevatedButton.icon(
                      onPressed: _updateProduct,
                      icon: const Icon(Icons.save),
                      label: const Text(
                        'UPDATE PRODUK',
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
