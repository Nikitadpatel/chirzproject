import 'package:chirz/screens/login.dart';
import 'package:chirz/screens/splash-screen.dart';
import 'package:chirz/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
int? groupValue = -1;

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartCounterNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
      builder: (context, child) {
        return Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Sizer',
              theme: ThemeData(

                fontFamily: "Poppins",
                iconTheme: const IconThemeData(color: Colors.black),
              ),
              home:  SplashScreen(),
            );
          },
        );
      }
    );
  }
}
