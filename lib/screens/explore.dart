import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chirz/Model/SettingModel.dart';
import 'package:chirz/providers/auth-providers.dart';
import 'package:chirz/res.dart';
import 'package:chirz/screens/favourites.dart';
import 'package:chirz/screens/restaurant.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'login.dart';

class ExplorerScreen extends StatefulWidget {
  const ExplorerScreen({Key? key}) : super(key: key);

  @override
  _ExplorerScreenState createState() => _ExplorerScreenState();
}

class _ExplorerScreenState extends State<ExplorerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  SettingModel? settingModel;

  @override
  void initState() {
    getDetails();

    super.initState();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return commanScreen(
      scaffold: Scaffold(
        key: _scaffoldKey,
        drawer: drawerWidgets(context),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                margin: EdgeInsets.only(right: 1.h),
                child: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
            )
          ],
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
        body: SizedBox(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    currentIndex != 0 ? 'Wine Decanting' : 'Drinks Pair',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                height: 40.h,
                margin: EdgeInsets.symmetric(
                  vertical: 5.h,
                  horizontal: 2.h,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return VisibilityDetector(
                        key: Key(index.toString()),
                        onVisibilityChanged: (visibilityInfo) {
                          if (visibilityInfo.visibleFraction < 0.5) {
                            currentIndex = 0;
                          } else {
                            currentIndex = 1;
                          }
                          setState(() {});
                        },
                        child: index == 0
                            ? GestureDetector(
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3.h),
                                        ),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            settingModel?.data?.restaurant ??
                                                '',
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.sp),
                                            ),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          Res.londin,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 40.h,
                                      width: 40.h,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        height: 10.h,
                                        width: 40.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(3.h),
                                              bottomRight: Radius.circular(3.h),
                                            ),
                                            color:
                                                Colors.grey.withOpacity(0.5)),
                                        alignment: Alignment.bottomCenter,
                                        child: Center(
                                            child: Text(
                                          'Restaurants',
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RestaurantsScreen()));
                                },
                              )
                            : Container(
                                margin: EdgeInsets.only(left: 3.h),
                                child: GestureDetector(
                                  onTap: () {
                                    navigateUser(true);
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              settingModel?.data?.myTasking ??
                                                  '',
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.sp),
                                              ),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            Res.tasking,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.cyan,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(3.h),
                                          ),
                                        ),
                                        height: 40.h,
                                        width: 40.h,
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Container(
                                          clipBehavior: Clip.hardEdge,
                                          height: 10.h,
                                          width: 40.h,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(3.h),
                                                bottomRight:
                                                    Radius.circular(3.h),
                                              ),
                                              color:
                                                  Colors.grey.withOpacity(0.5)),
                                          alignment: Alignment.bottomCenter,
                                          child: Center(
                                              child: Text(
                                            'Decanting wine',
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
      isLoading: isLoading,
    );
  }

  getDetails() {
    Future.delayed(Duration.zero, () async {
      await determinePosition();
    });
    setState(() {
      isLoading = true;
    });

    checkInternet().then((internet) async {
      if (internet) {
        AuthProviders().getDetails().then((Response response) async {
          settingModel = SettingModel.fromJson(json.decode(response.body));

          if (response.statusCode == 200 && settingModel?.status == 1) {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            buildErrorDialog(context, 'Error', settingModel?.message ?? '');
          }
        }).catchError((onError) {
          setState(() {
            isLoading = false;
          });
          buildErrorDialog(context, 'Error', 'Something went wrong');
        });
      } else {
        setState(() {
          isLoading = false;
        });
        buildErrorDialog(context, 'Error', 'Internet Required');
      }
    });
  }

  navigateUser(isTasting) async {
    if (userData == null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else {
      if (isTasting)
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const FavouritesScreen()));
      else
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RestaurantsScreen()));
    }
  }
}
