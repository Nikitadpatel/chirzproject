import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chirz/Model/base_model.dart';
import 'package:chirz/Model/item_detail_model.dart';
import 'package:chirz/Model/rating_model.dart';
import 'package:chirz/providers/cart-provider.dart';
import 'package:chirz/providers/food_providers.dart';
import 'package:chirz/screens/login.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';
import 'cartScreen.dart';
import 'items-screeen.dart';

class ItemDetailsScreen extends StatefulWidget {
  final dynamic wineId;

  const ItemDetailsScreen({Key? key, required this.wineId}) : super(key: key);

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  ItemDetailModel? itemDetailModel;
  bool descTextShowFlag = false;
  double _value = 0;
  double _lowerValue = 0;
  double _upperValue = 0;
  double _lowerValue1 = 0;
  double _upperValue1 = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    itemDetails();
    getRatings();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return commanScreen(
      scaffold: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        // drawer: drawerWidgets(context),
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(right: 1.h),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
            ),
          ),
          actions: [
            Container(
              child: (userData == null)
                  ? Container()
                  : IconButton(
                      onPressed: () {
                        addToFavourites();
                      },
                      icon: ((itemDetailModel?.data?.isFavourite ?? 1) == 1)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border_rounded,
                              color: Colors.black,
                            ),
                    ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     _scaffoldKey.currentState?.openDrawer();
            //   },
            //   child: Container(
            //     margin: EdgeInsets.only(right: 1.h),
            //     child: const Icon(
            //       Icons.menu,
            //       color: Colors.black,
            //     ),
            //   ),
            // )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          // title: Text(
          //   itemDetailModel?.data?.itemName ?? '',
          //   style: const TextStyle(
          //     fontWeight: FontWeight.bold,
          //     color: Colors.black,
          //   ),
          // ),
        ),
        body: SingleChildScrollView(
          child: Container(
            // margin: EdgeInsets.all(10.0),
            child: isLoading
                ? Container()
                : itemDetailModel?.data == null
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.h, vertical: 1.5),
                            child: Center(
                              child: Text(
                                (itemDetailModel?.data?.itemName ?? ''),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18.5.sp),
                              ),
                            ),
                            // margin: EdgeInsets.only(
                            //     top: (userData == null) ? 2.h : 6.h),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.h, vertical: 1.5),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              // borderRadius: BorderRadius.circular(20.0),
                              color: Colors.grey.shade100,
                            ),
                            // margin: EdgeInsets.symmetric(
                            //     horizontal: 3.h, vertical: 1.5),
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 5.h, right: 5.h, top: 4.h),
                                    child: Text(
                                      itemDetailModel?.data?.aboutWine ?? '',
                                      overflow: descTextShowFlag
                                          ? TextOverflow.visible
                                          : TextOverflow.ellipsis,
                                      maxLines: descTextShowFlag ? 8 : 2,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 25.h, right: 5.h),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        descTextShowFlag = !descTextShowFlag;
                                      });
                                    },
                                    child: Container(
                                        child: descTextShowFlag
                                            ? const Text(
                                                "Read Less",
                                                style: TextStyle(
                                                    color: Color(0xFFB41712),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : const Text("Read More",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xFFB41712),
                                                    fontWeight:
                                                        FontWeight.bold))),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  // padding: EdgeInsets.only(bottom: 1.h),
                                  // margin: EdgeInsets.only(top: 0.5.h),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 80.0,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                'Grape',
                                                style: textstyle,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20.0,
                                            ),
                                            Container(
                                              width: 100.0,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                itemDetailModel
                                                        ?.data?.typeOfGrape ??
                                                    '',
                                                style: textstyle1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                width: 80.0,
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  'Type',
                                                  style: textstyle,
                                                )),
                                            const SizedBox(
                                              width: 20.0,
                                            ),
                                            Container(
                                              width: 100.0,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  itemDetailModel
                                                          ?.data?.itemType ??
                                                      '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: textstyle1),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                width: 100.0,
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  'Region',
                                                  style: textstyle,
                                                )),
                                            const SizedBox(
                                              width: 20.0,
                                            ),
                                            Container(
                                              width: 100.0,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  itemDetailModel
                                                          ?.data?.region ??
                                                      '',
                                                  style: textstyle1),
                                            ),
                                            const SizedBox(
                                              width: 20.0,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 100.0,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                'Alcohol',
                                                style: textstyle,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20.0,
                                            ),
                                            Container(
                                              width: 100.0,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  itemDetailModel?.data
                                                              ?.alcoholPercentage +
                                                          "%" ??
                                                      '',
                                                  style: textstyle1),
                                            ),
                                            const SizedBox(
                                              width: 20.0,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                width: 100.0,
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  'year',
                                                  style: textstyle,
                                                )),
                                            const SizedBox(
                                              width: 20.0,
                                            ),
                                            Container(
                                              width: 100.0,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  itemDetailModel?.data?.year ??
                                                      '',
                                                  style: textstyle1),
                                            ),
                                            const SizedBox(
                                              width: 20.0,
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.h, vertical: 1.5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Sweetness",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.info_outline,
                                          color: Colors.red,
                                          size: 15.0,
                                        ))
                                  ],
                                ),
                                Container(
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0, vertical: 1.5),
                                        width: 300.0,
                                        height: 8.0,
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                  color: Color(0xffb66ffff),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  50.0),
                                                          bottomLeft:
                                                              const Radius
                                                                      .circular(
                                                                  50.0))),
                                              width: 5.0,
                                            ),
                                            Container(
                                                width: 10.0,
                                                color:
                                                    const Color(0xffb00ffcc)),
                                            Container(
                                                width: 20.0,
                                                color:
                                                    const Color(0xffb99ff99)),
                                            Container(
                                                width: 115.0,
                                                color:
                                                    const Color(0xffbffff99)),
                                            Container(
                                              width: 150.0,
                                              decoration: const BoxDecoration(
                                                  color: Color(0xffbffcc00),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  50.0),
                                                          bottomRight:
                                                              const Radius
                                                                      .circular(
                                                                  50.0))),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          height: 8.0,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0.0, vertical: 1.5),
                                          child: FlutterSlider(
                                            values: [_lowerValue],
                                            min: 0.0,
                                            max: 100.0,
                                            onDragging: (handlerIndex,
                                                lowerValue, upperValue) {
                                              setState(() {
                                                _upperValue = upperValue;
                                                _lowerValue = lowerValue;
                                              });
                                            },
                                            handlerWidth: 30.0,
                                            trackBar: FlutterSliderTrackBar(
                                              inactiveTrackBar: BoxDecoration(
                                                // borderRadius: BorderRadius.circular(20),
                                                // color: Colors.black12,
                                                border: Border.all(
                                                    width: 0,
                                                    color: Colors.transparent),
                                              ),
                                              activeTrackBar: const BoxDecoration(
                                                  // borderRadius: BorderRadius.circular(4),
                                                  color: Colors.transparent),
                                            ),
                                            handler: FlutterSliderHandler(
                                              decoration: const BoxDecoration(),
                                              child: Material(
                                                type: MaterialType.canvas,
                                                color: Colors.transparent,
                                                elevation: 1,
                                                child: Container(
                                                  height: 50.0,
                                                  width: 5.0,
                                                  color: Colors.red.shade900,
                                                ),
                                              ),
                                            ),
                                            // rightHandler: FlutterSliderHandler(
                                            //   child:  Container(height: 50.0,
                                            //     width: 5.0,
                                            //     color: Colors.black,),
                                            // ),
                                            // handlerHeight: 50.0,
                                          )),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Acidity",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.info_outline,
                                          color: Colors.red,
                                          size: 15.0,
                                        ))
                                  ],
                                ),
                                Container(
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0, vertical: 1.5),
                                        width: 300.0,
                                        height: 8.0,
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                  color:
                                                      const Color(0xffbffff99),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  50.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  50.0))),
                                              width: 100.0,
                                            ),
                                            Container(
                                              width: 200.0,
                                              decoration: BoxDecoration(
                                                  color: Colors.red.shade200,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  50.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  50.0))),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          height: 8.0,
                                          // color: Colors.black,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0.0, vertical: 1.5),
                                          child: FlutterSlider(
                                            handlerHeight: 50.0,

                                            values: [_lowerValue1],
                                            min: 0.0,
                                            max: 100.0,
                                            onDragging: (handlerIndex1,
                                                lowerValue1, upperValue1) {
                                              setState(() {
                                                _upperValue1 = upperValue1;
                                                _lowerValue1 = lowerValue1;
                                              });
                                            },
                                            handlerWidth: 30.0,
                                            trackBar:
                                                const FlutterSliderTrackBar(
                                              inactiveTrackBar: BoxDecoration(
                                                  // borderRadius: BorderRadius.circular(20),
                                                  // // color: Colors.black12,
                                                  // border: Border.all(width: 3, color: Colors.transparent),
                                                  ),
                                              activeTrackBar: BoxDecoration(
                                                  // borderRadius: BorderRadius.circular(0),
                                                  color: Colors.transparent),
                                            ),
                                            handler: FlutterSliderHandler(
                                              decoration: const BoxDecoration(),
                                              child: Material(
                                                type: MaterialType.canvas,
                                                color: Colors.transparent,
                                                elevation: 5,
                                                child: Container(
                                                  height: 50.0,
                                                  width: 5.0,
                                                  color: Colors.red.shade900,
                                                ),
                                              ),
                                            ),
                                            // rightHandler: FlutterSliderHandler(
                                            //   child:  Container(height: 50.0,
                                            //     width: 5.0,
                                            //     color: Colors.red.shade900,),
                                            // ),
                                            // handlerHeight: 50.0,
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.h, vertical: 1.5),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.grey.shade100,
                              ),
                              // margin: EdgeInsets.symmetric(horizontal: 3.h, vertical: 1.5),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Comments",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          child: IconButton(
                                            onPressed: () {
                                              (userData == null)
                                                  ? customeDialog()
                                                  : showRatingDialog();
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    (ratingModel?.data == null ||
                                            (ratingModel?.data?.isEmpty ??
                                                true))
                                        ? Container(
                                            alignment: Alignment.center,
                                            child: const Text(
                                                'No comments currently available'),
                                          )
                                        : Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 0.h),
                                            child: ListView.builder(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  ratingModel?.data?.length ??
                                                      0,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 1.h),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1.5.h,
                                                      horizontal: 1.5.h),
                                                  // decoration: BoxDecoration(
                                                  //     boxShadow: [
                                                  //       BoxShadow(
                                                  //         color:
                                                  //         Colors.grey.withOpacity(0.5),
                                                  //         spreadRadius: 5,
                                                  //         blurRadius: 7,
                                                  //         offset: const Offset(0,
                                                  //             3), // changes position of shadow
                                                  //       ),
                                                  //     ],
                                                  //     color: Colors.white,
                                                  //     borderRadius: const BorderRadius.all(
                                                  //         Radius.circular(15))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      // Container(
                                                      //   child: CachedNetworkImage(
                                                      //     imageUrl: ratingModel
                                                      //         ?.data?[index]
                                                      //         .profileImage ??
                                                      //         '',
                                                      //     alignment: Alignment.center,
                                                      //   ),
                                                      //   height: 5.h,
                                                      //   margin: EdgeInsets.symmetric(
                                                      //       horizontal: 1.h),
                                                      // ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    1.h),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                                (ratingModel
                                                                        ?.data?[
                                                                            index]
                                                                        .comment ??
                                                                    ''),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic)),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            RatingBar.builder(
                                                              itemSize: 20,
                                                              initialRating: double
                                                                  .parse(ratingModel
                                                                          ?.data?[
                                                                              index]
                                                                          .rate ??
                                                                      '1'),
                                                              minRating: 1,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              ignoreGestures:
                                                                  true,
                                                              itemCount: 5,
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                              onRatingUpdate:
                                                                  (ratings) {
                                                                rating = ratings
                                                                    .toString();
                                                                print(rating);
                                                              },
                                                            ),
                                                            Text(
                                                              ratingModel
                                                                      ?.data?[
                                                                          index]
                                                                      .username ??
                                                                  '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              // margin: EdgeInsets.only(bottom: 1.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.h),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: RaisedGradientButton(
                                          child: const Text(
                                            'Add to cart',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          gradient: const LinearGradient(
                                            colors: <Color>[
                                              Color(0xFFB41712),
                                              Color(0xFFB41712)
                                            ],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                          ),
                                          onPressed: () {
                                            if (userData == null) {
                                              customeDialog();
                                            } else {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              Map map = {
                                                'action': 'add_cart',
                                                'item_id':
                                                    itemDetailModel?.data?.id,
                                                'user_id':
                                                    userData?.data?.uId ?? '',
                                                'qty': '1',
                                                'price': groupValue == 0
                                                    ? itemDetailModel
                                                        ?.data?.pricePerGlass
                                                    : groupValue == 1
                                                        ? itemDetailModel
                                                            ?.data?.pricePerBott
                                                        : itemDetailModel?.data
                                                            ?.pricePerCocktail,
                                                'price_type': groupValue == 0
                                                    ? 'glass'
                                                    : groupValue == 1
                                                        ? 'bottle'
                                                        : 'cocktail1',
                                                'cart_action': 'add'
                                              };
                                              addToCart(map);
                                            }
                                          }),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
          ),
        ),
      ),
      isLoading: isLoading,
    );
  }

  String? rating = '5';
  TextEditingController commentController = TextEditingController();
  TextStyle textStyle = TextStyle(
    color: Colors.black,
    fontSize: 10.sp,
  );

  showRatingDialog() {
    Widget okButton = TextButton(
      child: Container(
        height: 40.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xFFB41712),
            borderRadius: BorderRadius.circular(20.0)),
        child: const Center(
          child: Text("Add Comment",
              style: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.black,
                  fontFamily: 'poppins')),
        ),
      ),
      onPressed: () async {
        Navigator.pop(context);
        await addRating();
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel",
          style: TextStyle(
              color: Color(0xFFB41712),
              decorationColor: Colors.black,
              fontFamily: 'poppins')),
      onPressed: () {
        Navigator.pop(context);
        commentController.clear();
      },
    );

    if (Platform.isAndroid) {
      AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        // titlePadding: EdgeInsets.all(10.0),

        title: const Center(
          child: Text('Share your thoughts',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decorationColor: Colors.black,
                  fontFamily: 'poppins')),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
                child: Text(
              "Your comment will be visible \n  within few hours",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
            )),
            const SizedBox(
              height: 10.0,
            ),
            RatingBar.builder(
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 5.h,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Color(0xFFB41712),
              ),
              onRatingUpdate: (ratings) {
                rating = ratings.toString();
                print(rating);
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: commentController,
              style: textStyle,
              validator: (value) {
                if (value!.isEmpty) {
                  return ' Comment';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(
                fillColor: Colors.white,
                hoverColor: Colors.white,
                focusColor: Colors.white,
                filled: true,
                hintText: 'Please add your comments',
                hintStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Column(
            children: [
              okButton,
              cancelButton,
            ],
          )
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    if (Platform.isIOS) {
      CupertinoAlertDialog cupertinoAlertDialog = CupertinoAlertDialog(
        title: const Text('Share your thoughts',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                decorationColor: Colors.black,
                fontFamily: 'poppins')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
                child: const Text(
              "Your comment will be visible \n  within few hours",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
            )),
            const SizedBox(
              height: 10.0,
            ),
            RatingBar.builder(
              initialRating: 5,
              minRating: 1,
              itemSize: 5.h,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: const Color(0xFFB41712),
              ),
              onRatingUpdate: (ratings) {
                rating = ratings.toString();
                print(rating);
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: commentController,
              style: textStyle,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter comments';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.white,
                hoverColor: Colors.white,
                focusColor: Colors.white,
                filled: true,
                hintText: 'Please add your comments',
                hintStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Column(
            children: [
              okButton,
              cancelButton,
            ],
          )
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return cupertinoAlertDialog;
        },
      );
    }
  }

  addToCart(body) {
    checkInternet().then((internet) async {
      if (internet) {
        CartProviders().addToCartAPi(body).then((Response response) async {
          BaseModel baseModel = BaseModel.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && baseModel.status == 1) {
            await updateCartItems(context);
            setState(() {
              isLoading = false;
            });

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ));
          } else if (response.statusCode == 200 && baseModel.status == 2) {
            Widget okButton = TextButton(
              child: const Text("OK",
                  style: TextStyle(
                      color: Colors.black,
                      decorationColor: Colors.black,
                      fontFamily: 'poppins')),
              onPressed: () {
                Navigator.pop(context);
                clearCart(body);
              },
            );
            Widget cancelButton = TextButton(
              child: const Text("Cancel",
                  style: TextStyle(
                      color: Colors.black,
                      decorationColor: Colors.black,
                      fontFamily: 'poppins')),
              onPressed: () {
                setState(() {
                  isLoading = false;
                });
                Navigator.pop(context);
              },
            );

            if (Platform.isAndroid) {
              AlertDialog alert = AlertDialog(
                title: const Text('',
                    style: TextStyle(
                        color: Colors.black,
                        decorationColor: Colors.black,
                        fontFamily: 'poppins')),
                content: Text(baseModel.message ?? '',
                    style: const TextStyle(
                        color: Colors.black,
                        decorationColor: Colors.black,
                        fontFamily: 'poppins')),
                actions: [
                  okButton,
                  cancelButton,
                ],
              );
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            }
            if (Platform.isIOS) {
              CupertinoAlertDialog cupertinoAlertDialog = CupertinoAlertDialog(
                title: const Text('',
                    style: TextStyle(
                        color: Colors.black,
                        decorationColor: Colors.black,
                        fontFamily: 'poppins')),
                content: Text(baseModel.message ?? '',
                    style: const TextStyle(
                        color: Colors.black,
                        decorationColor: Colors.black,
                        fontFamily: 'poppins')),
                actions: [
                  okButton,
                  cancelButton,
                ],
              );
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return cupertinoAlertDialog;
                },
              );
            }
          } else {
            setState(() {
              isLoading = false;
            });
            buildErrorDialog(context, '', baseModel.message.toString());
          }
        }).catchError((onError) {
          setState(() {
            isLoading = false;
          });
          print(onError.toString());
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

  clearCart(body) {
    checkInternet().then((internet) async {
      if (internet) {
        CartProviders().clearCartAPi().then((Response response) async {
          BaseModel baseModel = BaseModel.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && baseModel.status == 1) {
            setState(() {
              isLoading = false;
            });
            addToCart(body);
          } else {
            setState(() {
              isLoading = false;
            });
            buildErrorDialog(context, '', baseModel.message.toString());
          }
        }).catchError((onError) {
          setState(() {
            isLoading = false;
          });
          print(onError.toString());
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

  addToFavourites() {
    checkInternet().then((internet) async {
      if (internet) {
        FoodItemsProviders().addFavouritesWines({
          'action': 'add_favourite_item',
          'user_id': userData?.data?.uId ?? '',
          'item_id': widget.wineId ?? '',
          'favourite': '1',
        }).then((Response response) async {
          BaseModel baseModel = BaseModel.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && baseModel.status == 1) {
            setState(() {
              isLoading = false;
            });

            buildErrorDialog(context, '', baseModel.message.toString(),
                // buttonname: "Explore",
                callback: () {
              Navigator.pop(context);
              itemDetails();
            });
          } else {
            itemDetails();
            setState(() {
              isLoading = false;
            });
            buildErrorDialog(context, '', baseModel.message.toString());
          }
        }).catchError((onError) {
          setState(() {
            isLoading = false;
          });
          print(onError.toString());
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

  RatingModel? ratingModel;

  addRating() {
    checkInternet().then((internet) async {
      if (internet) {
        FoodItemsProviders().addRating({
          'action': 'add_rating',
          'user_id': userData?.data?.uId ?? '',
          'item_id': widget.wineId ?? '',
          'rate': rating ?? '',
          'comment': commentController.text.trim().toString(),
        }).then((Response response) async {
          commentController.clear();

          BaseModel baseModel = BaseModel.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && baseModel.status == 1) {
            setState(() {
              isLoading = false;
            });
            buildErrorDialog(
              context,
              '',
              baseModel.message.toString(),
              callback: () {
                Navigator.pop(context);
                getRatings();
              },
            );
          } else {
            setState(() {
              isLoading = false;
            });
            buildErrorDialog(context, '', baseModel.response.toString());
          }
        }).catchError((onError) {
          setState(() {
            isLoading = false;
          });
          print(onError.toString());
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

  getRatings() {
    checkInternet().then((internet) async {
      if (internet) {
        FoodItemsProviders().getRatings({
          'action': 'rating',
          'user_id': userData?.data?.uId ?? '',
          'item_id': widget.wineId ?? '',
        }).then((Response response) async {
          commentController.clear();

          ratingModel = RatingModel.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && ratingModel?.status == 1) {
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
          print(onError.toString());
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

  TextStyle textstyle = TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10.sp);
  TextStyle textstyle1 = TextStyle(
      color: Colors.black, fontWeight: FontWeight.w600, fontSize: 10.sp);

  customeDialog() {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      //this right here
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Center(
                child: Text(
                  "Login or register to complete this action",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //
              //
            ),
            // Padding(
            //   padding: EdgeInsets.all(15.0),
            //   child: Center(
            //     child: Text(
            //       'You are not Login',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontFamily: fontFamily,
            //         fontSize: 2.1.h,
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Text(
                  'You wii be able to save your favourite \n restaurent ,bookmark wines and leave comments',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontFamily: fontFamily,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),

            Center(
              child: Container(
                margin: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40.0,
                      width: MediaQuery.of(context).size.width,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFFB41712)),
                          // backgroundColor: Color(0xFFB41712),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: fontFamily,
                            fontSize: 2.1.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 40.0,
                      width: MediaQuery.of(context).size.width,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        },
                        style: ButtonStyle(
                          // backgroundColor: MaterialStateProperty.all(Colors.black),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                        ),
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: const Color(0xFFB41712),
                            fontWeight: FontWeight.w400,
                            fontFamily: fontFamily,
                            fontSize: 2.1.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }

  itemDetails() {
    setState(() {
      isLoading = true;
    });
    checkInternet().then((internet) async {
      if (internet) {
        FoodItemsProviders().itemDetailsAPi({
          'item_id': widget.wineId,
          'user_id': userData?.data?.uId ?? '',
        }).then((Response response) async {
          itemDetailModel =
              ItemDetailModel.fromJson(json.decode(response.body));

          if (response.statusCode == 200 && itemDetailModel?.status == 1) {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            buildErrorDialog(
                context, '', itemDetailModel?.message.toString() ?? '');
          }
        }).catchError((onError) {
          setState(() {
            isLoading = false;
          });
          print(onError.toString());
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
