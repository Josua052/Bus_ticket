import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

class InformasiPenumpangScreen extends StatefulWidget {
  final String dari;
  final String tujuan;
  final String waktu;
  final Set<int> selectedSeats;
  final int hargaTiketPerKursi;

  const InformasiPenumpangScreen({
    Key? key,
    required this.dari,
    required this.tujuan,
    required this.waktu,
    required this.selectedSeats,
    required this.hargaTiketPerKursi,
  }) : super(key: key);

  @override
  State<InformasiPenumpangScreen> createState() =>
      _InformasiPenumpangScreenState();
}

class _InformasiPenumpangScreenState extends State<InformasiPenumpangScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  bool agreedTerms = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  Widget _textField({
    required String hint,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$hint wajib diisi";
        }
        if (hint.toLowerCase() == 'email' || hint.contains('@')) {
          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
            return "Email tidak valid";
          }
        }
        if (hint.toLowerCase() == 'umur') {
          if (int.tryParse(value) == null) {
            return "Umur harus angka";
          }
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalHarga = widget.hargaTiketPerKursi * widget.selectedSeats.length;
    List<int> sortedSeats = widget.selectedSeats.toList()..sort();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false, 
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 37, 87, 160),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text(
              "Informasi Penumpang",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF265AA5),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "${widget.dari} → ${widget.tujuan}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            widget.waktu,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 16.h, top: 16.h),
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Detail Kontak", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                                  SizedBox(height: 12.h),
                                  _textField(hint: "Alamat email", controller: emailController),
                                  SizedBox(height: 12.h),
                                  _textField(hint: "No. Telepon", controller: phoneController),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Detail Penumpang", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                                  SizedBox(height: 12.h),
                                  _textField(hint: "Nama", controller: nameController),
                                  SizedBox(height: 12.h),
                                  _textField(hint: "Umur", controller: ageController),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Checkbox(
                          value: agreedTerms,
                          onChanged: (value) {
                            setState(() {
                              agreedTerms = value ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
                              children: [
                                const TextSpan(text: "Saya telah membaca dan setuju terhadap "),
                                TextSpan(
                                  text: "Syarat dan ketentuan pembelian tiket",
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xFF265AA5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
                bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
          24.w,
          16.h,
          24.w,
          16.h + MediaQuery.of(context).padding.bottom,
        ),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rp ${NumberFormat('#,###', 'id_ID').format(totalHarga)}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Kursi ke ",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                      SizedBox(
                        width: 160.w,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            sortedSeats.join(", "),
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: (agreedTerms && _formKey.currentState?.validate() == true)
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Pembayaran berhasil!")),
                            );
                          }
                        : null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                        return const Color(0xFFFFC107);
                      }),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                      ),
                    ),
                    child: Text(
                      "Bayar Sekarang",
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
}
