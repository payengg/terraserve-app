import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terraserve_app/pages/login_pages.dart';

class RegisterPages extends StatefulWidget {
  const RegisterPages({super.key});

  @override
  State<RegisterPages> createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final int _selectedTabIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Gambar di kanan atas yang tetap statis
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/produk_login.png',
              width: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.cover,
            ),
          ),

          // Semua konten (termasuk tombol back + logo) sekarang berada di dalam SingleChildScrollView
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ Tombol kembali sekarang menjadi bagian dari konten yang bisa digulir
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Image.asset(
                          'assets/images/back.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Logo Terraserve
                    Image.asset(
                      'assets/images/logo_terraserve.png',
                      width: 45,
                      height: 47,
                    ),
                    const SizedBox(height: 24),

                    // Judul
                    Text(
                      'Mulailah sekarang',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Tab Login/Daftar
                    _buildLoginTabs(),
                    const SizedBox(height: 24),

                    // Form Fields
                    _buildTextField(
                      label: 'Full name',
                      hint: 'Masukkan nama anda',
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      label: 'Email address',
                      hint: 'Masukkan email anda',
                      icon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      label: 'Phone number',
                      hint: 'Masukkan nomor telepon',
                      icon: Icons.phone_iphone_rounded,
                    ),
                    const SizedBox(height: 16),

                    _buildPasswordField(
                      label: 'Set password',
                      isVisible: _isPasswordVisible,
                      onToggleVisibility: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    _buildPasswordField(
                      label: 'Confirm password',
                      isVisible: _isConfirmPasswordVisible,
                      onToggleVisibility: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    _buildPrimaryButton(
                      text: 'Daftar',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 24),

                    _buildDisclaimer(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),

          // ✅ Tombol kembali yang statis di sini sudah dihapus
        ],
      ),
    );
  }

  Widget _buildLoginTabs() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTabItem('Login', 0)),
          Expanded(child: _buildTabItem('Daftar', 1)),
        ],
      ),
    );
  }

  Widget _buildTabItem(String text, int index) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPages()),
          );
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.black : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          obscureText: !isVisible,
          decoration: InputDecoration(
            hintText: '••••••••',
            prefixIcon: const Icon(Icons.lock_outline_rounded,
                color: Colors.grey),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
              ),
              onPressed: onToggleVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF859F3D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildDisclaimer() {
    return Text(
      'Dengan mendaftar, Anda menyetujui Persyaratan Layanan dan Perjanjian Pemrosesan Data',
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        fontSize: 12,
        color: Colors.grey[600],
      ),
    );
  }
}
