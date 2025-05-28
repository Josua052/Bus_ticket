import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'pesan_tiket_screen.dart';
import 'informasi_jadwal_bus.dart';
import 'profile.dart';
import 'pilih_bus.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  String? selectedFrom;
  String? selectedTo;
  DateTime? selectedDate;
  final TextEditingController searchController = TextEditingController();

  final List<String> kota = ['Medan', 'Ranto Parapat', 'Siantar'];

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _showKotaPicker(bool isFromField) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.5,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 20.h,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
            ),
            child: StatefulBuilder(
              builder: (context, setStateModal) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            onChanged: (_) => setStateModal(() {}),
                            decoration: InputDecoration(
                              hintText: 'Masukkan nama kota',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              suffixIcon: searchController.text.isNotEmpty
                                  ? IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  searchController.clear();
                                  setStateModal(() {});
                                },
                              )
                                  : null,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            backgroundColor: Color(0xFF265AA5),
                          ),
                          child: Text("Cari", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: ListView(
                        children: kota
                            .where((city) => city
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase()))
                            .map(
                              (city) => ListTile(
                            title: Text(city),
                            onTap: () {
                              setState(() {
                                if (isFromField) {
                                  selectedFrom = city;
                                } else {
                                  selectedTo = city;
                                }
                              });
                              Navigator.pop(context);
                            },
                          ),
                        )
                            .toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // status bar ikon putih
      child: Scaffold(
        extendBodyBehindAppBar: true, // biar body dan appbar melebar ke atas layar
        backgroundColor: Color(0xFFF5F6FA),
        body: SafeArea(
          top: false, // matikan safearea di atas supaya warna header bisa sampai status bar
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ScreenUtilInit(
                designSize: Size(375, 812),
                builder: (context, child) => SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFF265AA5),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(24.r),
                              bottomRight: Radius.circular(24.r),
                            ),
                          ),
                          // Padding atas ditambah status bar agar tidak tertutup
                          padding: EdgeInsets.fromLTRB(
                              16.w,
                              24.h + MediaQuery.of(context).padding.top,
                              16.w,
                              24.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/images/logo_app.png',
                                      width: 40.w, height: 40.w),
                                  SizedBox(width: 12.w),
                                  Flexible(
                                    child: Text(
                                      'Halo, Josua Ronaldo',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              Container(
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Column(
                                  children: [
                                    _buildCustomPicker('Dari', selectedFrom, () => _showKotaPicker(true)),
                                    SizedBox(height: 12.h),
                                    _buildCustomPicker('Tujuan', selectedTo, () => _showKotaPicker(false)),
                                    SizedBox(height: 12.h),
                                    InkWell(
                                      onTap: _pickDate,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: Colors.grey.shade400),
                                          borderRadius: BorderRadius.circular(12.r),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_city_outlined, color: Colors.grey),
                                            SizedBox(width: 10.w),
                                            Expanded(
                                              child: Text(
                                                selectedDate == null
                                                    ? "Tanggal keberangkatan"
                                                    : "${selectedDate!.day.toString().padLeft(2, '0')}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.year}",
                                                style: TextStyle(
                                                  color: selectedDate == null ? Colors.grey : Colors.black,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            ),
                                            Icon(Icons.arrow_drop_down),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (selectedFrom != null && selectedTo != null && selectedDate != null) {
                                            final formattedDate = "${selectedDate!.day.toString().padLeft(2, '0')} - ${_monthName(selectedDate!.month)} - ${selectedDate!.year} | ${_dayName(selectedDate!.weekday)}";
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => PilihBusScreen(
                                                  dari: selectedFrom!,
                                                  tujuan: selectedTo!,
                                                  tanggal: formattedDate,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFFFFD100),
                                          foregroundColor: Color(0xFF265AA5),
                                          padding: EdgeInsets.symmetric(vertical: 16.h),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.r),
                                          ),
                                        ),
                                        child: Text(
                                          "Cari Bus",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[900],
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Riwayat", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                              TextButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_ios, size: 14.sp),
                                label: Text("Lihat Semua", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 24.h),
                          child: Column(
                            children: [
                              Image.asset("assets/images/not_file.png", width: 100.w),
                              SizedBox(height: 12.h),
                              Text(
                                "Belum ada Riwayat Pemesanan",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40.w),
                                child: Text(
                                  "Belum ada riwayat pemesanan tiket bus. Pesan tiket sekarang untuk memulai perjalanan Anda!",
                                  style: TextStyle(fontSize: 13.sp, color: Colors.black54),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
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

  Widget _buildCustomPicker(String label, String? value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(Icons.location_city_outlined, color: Colors.grey),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                value ?? label,
                style: TextStyle(
                  color: value == null ? Colors.grey : Colors.black,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => PesanTiketScreen()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => InformasiJadwalBusScreen()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
        break;
    }
  }

  String _monthName(int month) {
    const months = [
      '',
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }

  String _dayName(int weekday) {
    const days = [
      '', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];
    return days[weekday];
  }
}
