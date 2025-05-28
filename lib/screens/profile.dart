import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_screen.dart';
import 'pesan_tiket_screen.dart';
import 'informasi_jadwal_bus.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3; // Profil aktif

  final String userName = 'USER NAME';

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => PesanTiketScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => InformasiJadwalBusScreen()),
        );
        break;
      case 3:
        // Sudah di Profil
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Profil'),
          backgroundColor: Color(0xFF265AA5),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40.r,
                      backgroundImage: AssetImage('assets/images/profile_photo.jpg'),
                      backgroundColor: Colors.grey[300],
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Text(
                        userName.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              _menuItem(Icons.lock, 'Ganti Kata Sandi', () {}),
              Divider(),
              _menuItem(Icons.help_outline, 'Pusat Bantuan', () {}),
              Divider(),
              _menuItem(Icons.info_outline, 'Tentang Bus Booking', () {}),
              Divider(),
              _menuItem(Icons.logout, 'Keluar', () {}),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Color(0xFF265AA5),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
            BottomNavigationBarItem(icon: Icon(Icons.confirmation_num), label: 'Tiket'),
            BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'Informasi'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF265AA5)),
      title: Text(label),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
      horizontalTitleGap: 0,
    );
  }
} 
