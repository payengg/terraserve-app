import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_picker/country_picker.dart';
import 'package:terraserve_app/pages/verify_code_pages.dart';

class LupaPwPages extends StatefulWidget {
  const LupaPwPages({super.key});

  @override
  State<LupaPwPages> createState() => _LupaPwPagesState();
}

class _LupaPwPagesState extends State<LupaPwPages> {
  int _selectedTabIndex = 0;

  Country _selectedCountry = Country(
    phoneCode: '62',
    countryCode: 'ID',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Indonesia',
    example: 'Indonesia',
    displayName: 'Indonesia',
    displayNameNoCountryCode: 'ID',
    e164Key: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 27),
              Text(
                'Lupa Password',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Masukkan email atau nomor telepon Anda, kami akan mengirimkan kode verifikasi',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 80),
              _buildTabs(),
              const SizedBox(height: 49),
              if (_selectedTabIndex == 0)
                _buildEmailField(hint: 'Masukkan email Anda')
              else
                // ✅ Label dihilangkan dari sini
                _buildMobileField(),
              // ✅ Jarak ke tombol didekatkan
              const SizedBox(height: 25),
              _buildPrimaryButton(
                text: 'Kirim Kode',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VerifyCodePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTabItem('E-mail', 0)),
          Expanded(child: _buildTabItem('Mobile Number', 1)),
        ],
      ),
    );
  }

  Widget _buildTabItem(String text, int index) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
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
                    spreadRadius: 1,
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

  Widget _buildEmailField({required String hint}) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Image.asset(
            'assets/images/icon_email.png',
            height: 20,
          ),
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
    );
  }

  // ✅ Widget diubah, tidak lagi menggunakan Column dan label
  Widget _buildMobileField() {
    return TextField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Masukan nomor Anda',
        prefixIcon: GestureDetector(
          onTap: () {
            showCountryPicker(
              context: context,
              countryListTheme: CountryListThemeData(
                bottomSheetHeight: 500,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                inputDecoration: InputDecoration(
                  labelText: 'Cari Negara',
                  hintText: 'Mulai ketik untuk mencari',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color(0xFF8C98A8).withOpacity(0.2),
                    ),
                  ),
                ),
              ),
              onSelect: (Country country) {
                setState(() {
                  _selectedCountry = country;
                });
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 10, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _selectedCountry.flagEmoji,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 8),
                Text(
                  '+${_selectedCountry.phoneCode}',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
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
    );
  }

  Widget _buildPrimaryButton({required String text, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF859F3D),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
}
