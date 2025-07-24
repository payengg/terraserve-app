import 'package:flutter/material.dart';
import 'package:terraserve_app/pages/startup_pages.dart'; // pastikan bukan splash_pages.dart
import 'theme.dart';

void main() => runApp(const TerraServe());

class TerraServe extends StatelessWidget {
  const TerraServe({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp adalah widget dasar untuk aplikasi Anda
    return const MaterialApp(
      // Menghilangkan banner "Debug" di pojok kanan atas
      debugShowCheckedModeBanner: false,
      // Menentukan halaman pertama yang akan ditampilkan
      home: StartupPage(),
    );
  }
}
