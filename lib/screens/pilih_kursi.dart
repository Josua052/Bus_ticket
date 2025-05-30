import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'informasi_penumpang.dart';

class PilihKursiScreen extends StatefulWidget {
  final String dari;
  final String tujuan;
  final String waktu;

  const PilihKursiScreen({
    Key? key,
    required this.dari,
    required this.tujuan,
    required this.waktu,
  }) : super(key: key);

  @override
  State<PilihKursiScreen> createState() => _PilihKursiScreenState();
}

class _PilihKursiScreenState extends State<PilihKursiScreen> {
  final Map<int, bool> kursiStatus = {
    1: false, 2: false, 3: false, 4: false, 5: false,
    6: false, 7: true, 8: false, 9: false, 10: true,
    11: false, 12: false, 13: false, 14: false, 15: false,
    16: false, 17: false, 18: false, 19: false, 20: false,
  };

  Set<int> selectedSeats = {};
  final int hargaTiket = 55000;

  @override
  
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          extendBody: false,
          backgroundColor: const Color(0xFFF5F6FA),
          appBar: AppBar(
            title: const Text("Pilih Kursi"),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                children: [
                  Text(
                    "${widget.dari} → ${widget.tujuan}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    widget.waktu,
                    style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(color: Colors.blue.shade900, width: 2.w),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            'assets/images/setir_mobil.png',
                            width: 40.w,
                            height: 40.w,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Column(
                          children: List.generate(5, (rowIndex) {
                            int leftSeat1 = rowIndex * 4 + 1;
                            int leftSeat2 = leftSeat1 + 1;
                            int rightSeat1 = leftSeat1 + 2;
                            int rightSeat2 = leftSeat1 + 3;

                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      _buildSeat(leftSeat1),
                                      SizedBox(width: 12.w),
                                      _buildSeat(leftSeat2),
                                    ],
                                  ),
                                  SizedBox(width: 40.w),
                                  Row(
                                    children: [
                                      _buildSeat(rightSeat1),
                                      SizedBox(width: 12.w),
                                      _buildSeat(rightSeat2),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _colorLegendBox(Colors.grey.shade400),
                      SizedBox(width: 8.w),
                      Text(" : Tersedia", style: TextStyle(fontSize: 14.sp)),
                      SizedBox(width: 20.w),
                      _colorLegendBox(const Color(0xFFFFD10A)),
                      SizedBox(width: 8.w),
                      Text(" : Sudah dipesan", style: TextStyle(fontSize: 14.sp)),
                      SizedBox(width: 20.w),
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: selectedSeats.isEmpty
              ? null
              : Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(
                    24.w,
                    12.h,
                    24.w,
                    16.h + MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Rp harga tiket",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                              ),
                              Text(
                                "Rp ${(hargaTiket * selectedSeats.length)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Kursi ke",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                              ),
                              Text(
                                (() {
                                  List<int> sortedSeats = selectedSeats.toList()..sort();
                                  return sortedSeats.join(", ");
                                })(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InformasiPenumpangScreen(
                                  dari: widget.dari,
                                  tujuan: widget.tujuan,
                                  waktu: widget.waktu,
                                  selectedSeats: selectedSeats,
                                  hargaTiketPerKursi: hargaTiket,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                          ),
                          child: Text(
                            "Lanjutkan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildSeat(int seatNumber) {
    bool isBooked = kursiStatus[seatNumber] ?? false;
    bool isSelected = selectedSeats.contains(seatNumber);

    Color bgColor;
    if (isBooked) {
      bgColor = const Color(0xFFFFD10A);
    } else if (isSelected) {
      bgColor = Colors.green;
    } else {
      bgColor = Colors.grey.shade400;
    }

    return GestureDetector(
      onTap: isBooked
    ? null
    : () {
        setState(() {
          if (isSelected) {
            selectedSeats.remove(seatNumber);
          } else {
            if (selectedSeats.length < 4) {
              selectedSeats.add(seatNumber);
            } else {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/penumpang_duduk.png',
                          width: 400.w,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "Anda hanya dapat memilih maksimal 4 tempat duduk.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        SizedBox(
                          width: double.infinity,
                          height: 48.h,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFD10A),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            child: const Text(
                              "OK",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        });
      },

      child: Container(
        width: 50.w,
        height: 50.w,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        alignment: Alignment.center,
        child: Text(
          seatNumber.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: isBooked ? Colors.black87 : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _colorLegendBox(Color color) {
    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.r),
      ),
    );
  }
}
