
import 'package:chirz/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../res.dart';
import 'explore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return commanScreen(
      scaffold: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text(
            '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                Res.splash,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.symmetric(
                vertical: 1.h,
                horizontal: 1.h,
              ),
              child: buttonWidget(
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExplorerScreen(),
                      ));
                },
                text: 'Explore Chirz',
                radius: 2.h,
              ),
            )
          ],
        ),
      ),
      isLoading: false,
    );
  }
}
