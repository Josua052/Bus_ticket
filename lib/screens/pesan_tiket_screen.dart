import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_screen.dart';
import 'informasi_jadwal_bus.dart';
import 'profile.dart';

class PesanTiketScreen extends StatefulWidget {
  @override
  State<PesanTiketScreen> createState() => _PesanTiketScreenState();
}

class _PesanTiketScreenState extends State<PesanTiketScreen> {
  int _selectedIndex = 1;

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
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => InformasiJadwalBusScreen()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ProfileScreen()),
        );
        break;
    }
  }

  void _refresh() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data diperbarui')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text('Perjalanan Saya'),
          backgroundColor: Color(0xFF265AA5),
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
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/kucing.png',
                width: 180.w,
                height: 180.w,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 24.h),
              Text(
                'Belum ada Perjalanan.\nAnda belum memiliki pemesanan.\nPesan perjalanan Anda berikutnya sekarang!',
                style: TextStyle(fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => HomeScreen()),
                    );
                  },
                  child: Text('Pesan Sekarang'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFD100),
                    foregroundColor: Color(0xFF265AA5),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
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
} 
