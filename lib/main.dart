import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/pesan_tiket_screen.dart';
import 'screens/info_keberangkatan_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String pesanTiketRoute = '/pesan_tiket';
  static const String infoKeberangkatanRoute = '/info_keberangkatan';

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812), // ukuran desain dari Figma (misalnya iPhone X)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Bus Ticket Booking',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
          initialRoute: splashRoute,
          routes: {
            splashRoute: (context) => SplashScreen(),
            loginRoute: (context) => LoginScreen(),
            homeRoute: (context) => HomeScreen(),
            pesanTiketRoute: (context) => PesanTiketScreen(),
            infoKeberangkatanRoute: (context) => InfoKeberangkatanScreen(),
          },
        );
      },
    );
  }
}
