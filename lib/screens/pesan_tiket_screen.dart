import 'package:flutter/material.dart';

class PesanTiketScreen extends StatefulWidget {
  @override
  State<PesanTiketScreen> createState() => _PesanTiketScreenState();
}

class _PesanTiketScreenState extends State<PesanTiketScreen> {
  int _selectedIndex = 1; // Tiket aktif pada posisi 1

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    switch (index) {
      case 0:
        Navigator.popUntil(context, (route) => route.isFirst); // Contoh kembali ke Home
        break;
      case 1:
      // Sudah di halaman tiket
        break;
      case 2:
      // Navigasi ke halaman Informasi (buat jika ada)
        break;
      case 3:
      // Navigasi ke halaman Profil (buat jika ada)
        break;
    }
  }

  void _refresh() {
    // Contoh fungsi refresh, bisa dikembangkan
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data diperbarui')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perjalanan Saya'),
        backgroundColor: Colors.deepPurple.withOpacity(0.5),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refresh,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/kucing.png',
              width: 180,
              height: 180,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 24),
            Text(
              'Belum ada Perjalanan.\nAnda belum memiliki pemesanan.\nPesan perjalanan Anda berikutnya sekarang!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigasi ke halaman pemesanan tiket baru
                  Navigator.pop(context); // Contoh kembali ke Home/halaman sebelumnya
                },
                child: Text('Pesan Sekarang'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
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

  Widget _buildNavItem(IconData iconData, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    final color = isSelected ? Colors.deepPurple : Colors.grey;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, size: 28, color: color),
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
