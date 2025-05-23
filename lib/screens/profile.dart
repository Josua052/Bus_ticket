import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3; // Profil aktif di posisi 3

  // Contoh data pengguna
  final String userName = 'USER NAME';

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    switch (index) {
      case 0:
        Navigator.popUntil(context, (route) => route.isFirst); // Misal kembali ke Home
        break;
      case 1:
      // Navigasi ke Ticket (buat halaman kalau ada)
      // Navigator.push(context, MaterialPageRoute(builder: (_) => TicketScreen()));
        break;
      case 2:
      // Navigasi ke Informasi (buat halaman kalau ada)
      // Navigator.push(context, MaterialPageRoute(builder: (_) => InformasiScreen()));
        break;
      case 3:
      // Sudah di profil, tidak perlu apa-apa
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Colors.deepPurple.withOpacity(0.5),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Kotak profil dengan foto dan nama
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/profile_photo.jpg'), // Ganti foto profil
                    backgroundColor: Colors.grey[300],
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      userName.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Menu daftar
            _menuItem(Icons.lock, 'Ganti Kata Sandi', () {
              // TODO: aksi ganti kata sandi
            }),
            Divider(),
            _menuItem(Icons.help_outline, 'Pusat Bantuan', () {
              // TODO: aksi pusat bantuan
            }),
            Divider(),
            _menuItem(Icons.info_outline, 'Tentang Bus Booking', () {
              // TODO: aksi tentang aplikasi
            }),
            Divider(),
            _menuItem(Icons.logout, 'Keluar', () {
              // TODO: aksi logout
            }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, "Beranda", 0),
            _buildNavItem(Icons.confirmation_num, "Ticket", 1),
            _buildNavItem(Icons.info, "Informasi", 2),
            _buildNavItem(Icons.person, "Profi", 3),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(label),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 4),
      horizontalTitleGap: 0,
    );
  }

  Widget _buildNavItem(IconData iconData, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    final color = isSelected ? Colors.deepPurple : Colors.grey;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            size: 28,
            color: color,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
