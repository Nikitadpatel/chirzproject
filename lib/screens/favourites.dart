import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chirz/Model/favourite_list_model.dart';
import 'package:chirz/providers/food_providers.dart';
import 'package:chirz/screens/item-details-screen.dart';
import 'package:chirz/screens/restaurant.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

import '../Res.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FavouriteListModel? restaurants;

  @override
  void initState() {
    getFavouritesWines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return commanScreen(
      scaffold: Scaffold(
        key: _scaffoldKey,
        endDrawerEnableOpenDragGesture: false,
        drawerScrimColor: Colors.transparent,
        drawer: drawerWidgets(context),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(right: 1.h),
              child: const Icon(
                Icons.arrow_back_sharp,
                color: Colors.black,
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text(
            'Favourites',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
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
        ),
        body: Container(
          margin: EdgeInsets.only(top: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.5.h),
              //   child: Text(
              //     'Favourites',
              //     style:
              //         TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              //   ),
              // ),
              isLoading == true
                  ? Container()
                  : Expanded(
                      child: (restaurants == null
                                  ? 0
                                  : restaurants?.data?.length ?? 0) ==
                              0
                          ? SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                      child: Text(
                                    'No Favourites yet ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  )),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  const Center(
                                      child: Text(
                                    'Tap the star icon near any restaurent and \n  we will save it here for you',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                        color: Colors.grey),
                                  )),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RestaurantsScreen()));
                                    },
                                    child: Container(
                                        height: 40.0,
                                        width: 150.0,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: const Color(0xFFB41712)),
                                        child: const Center(
                                            child: Text(
                                          "Explore",
                                          style: TextStyle(color: Colors.white),
                                        ))),
                                  )
                                ],
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 2.h),
                              child: ListView.builder(
                                itemCount: restaurants == null
                                    ? 0
                                    : restaurants?.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    height: 70.0,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.sp),
                                      ),
                                      color: Colors.grey.shade200,
                                    ),

                                    // margin: EdgeInsets.only(right: 1.h, bottom: 1.h),
                                    child: GestureDetector(
                                      onTap: () async {
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ItemDetailsScreen(
                                                wineId: restaurants
                                                    ?.data?[index].itemId,
                                              ),
                                            ));
                                        getFavouritesWines();
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: 50.0,
                                            width: 50.0,
                                            // height: 18.h,
                                            // width: 17.h,
                                            child: CachedNetworkImage(
                                              imageUrl: restaurants
                                                      ?.data?[index]
                                                      .itemImage ??
                                                  '',
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  // borderRadius: BorderRadius.all(
                                                  //   Radius.circular(10.sp),
                                                  // ),
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
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                color: Colors.grey,
                                                child: Image.asset(Res
                                                    .profile_pic_placeholder),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            height: 70,
                                            child: Text(
                                              restaurants
                                                      ?.data?[index].itemName ??
                                                  '',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.0),
                                              // textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Icon(
                                              Icons.favorite_outlined,
                                              color: Colors.red,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                // gridDelegate:
                                //     const SliverGridDelegateWithFixedCrossAxisCount(
                                //         crossAxisCount: 2),
                              ),
                            ),
                    ),
            ],
          ),
        ),
      ),
      isLoading: isLoading,
    );
  }

  getFavouritesWines() {
    setState(() {
      isLoading = true;
    });

    checkInternet().then((internet) async {
      if (internet) {
        FoodItemsProviders().getFavouritesWines({
          'user_id': userData?.data?.uId ?? '',
          'action': 'favourite_list'
        }).then((Response response) async {
          FavouriteListModel restaurantData =
              FavouriteListModel.fromJson(json.decode(response.body));

          if (response.statusCode == 200 && restaurantData.status == 1) {
            restaurants = restaurantData;
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
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
}
