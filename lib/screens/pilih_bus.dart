import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart'; // Import untuk SystemUiOverlayStyle
import 'pilih_kursi.dart';

class PilihBusScreen extends StatelessWidget {
  final String dari;
  final String tujuan;
  final String tanggal;

  const PilihBusScreen({
    Key? key,
    required this.dari,
    required this.tujuan,
    required this.tanggal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark, // Icon status bar warna hitam
        child: Scaffold(
          backgroundColor: Color(0xFFF5F6FA),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black), // Icon back warna hitam
            title: Text('Pilih Bus', style: TextStyle(color: Colors.black)),
            centerTitle: false,
            systemOverlayStyle: SystemUiOverlayStyle.dark, // Untuk status bar android
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Color(0xFF265AA5),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/identitas_logo.png',
                                height: 60.sp,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "$dari → $tujuan",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  tanggal,
                                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4.r,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("AC", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Color(0xFF265AA5))),
                                Text("Rp harga tiket", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Text("n kursi tersisa dari m kursi tersisa", style: TextStyle(fontSize: 12.sp)),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("10.00 - 12.00", style: TextStyle(fontSize: 14.sp)),
                                Text("Nomor Bus: 140", style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PilihKursiScreen(
                                        dari: dari,
                                        tujuan: tujuan,
                                        waktu: "10.00 - 12.00",
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFFD100),
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: Text(
                                  "Pilih Kursi",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
