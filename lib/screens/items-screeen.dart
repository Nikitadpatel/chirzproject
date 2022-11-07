import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chirz/Model/food_items_model.dart';
import 'package:chirz/Model/wine_list.dart';
import 'package:chirz/main.dart';
import 'package:chirz/providers/food_providers.dart';
import 'package:chirz/screens/item-details-screen.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import '../res.dart';

class ItemScreen extends StatefulWidget {
  final String? menuName;
  final MenuData? menuData;
  final bool? isWineList;
  final dynamic foodId;
  final dynamic? foodImage;
  final dynamic? discription;
  final dynamic? foodPrice;
  final dynamic? priceBottle;
  final dynamic? priceGlass;

  const ItemScreen({
    Key? key,
    this.menuName,
    this.menuData,
    this.isWineList = false,
    this.foodId,
    this.foodImage,
    this.discription,
    this.foodPrice,
    this.priceBottle,
    this.priceGlass,
  }) : super(key: key);

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  bool isLoading = true;

  WineListModel? wineList;

  @override
  void initState() {
    groupValue = 0;
    setState(() {
      isLoading = true;
    });
    if (widget.isWineList ?? false) {
      getWineList();
    }
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int sliderIndex = 0;
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return commanScreen(
      scaffold: Scaffold(
        key: _scaffoldKey,
        drawer: drawerWidgets(context),
        backgroundColor: Colors.white,
        body: Container(
          child: widget.isWineList ?? false
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              color: Colors.grey,
                              height: 26.h,
                              width: double.infinity,
                              child: CachedNetworkImage(
                                imageUrl: widget.foodImage,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) => Container(
                                  width: double.infinity,
                                  height: 26.h,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/Rectangle 51.png"),
                                    ),
                                  ),
                                  child: Image.asset(
                                    "assets/images/Vector (3).png",
                                  ),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(top: 50, left: 30),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.menuName ?? '',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.discription ?? "no discription",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          '£${widget.foodPrice}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            (wineList?.data ?? []).isEmpty
                                ? Container()
                                : Container(
                                    margin: EdgeInsets.only(top: 8.h),
                                    child: IconButton(
                                      onPressed: () {
                                        buttonCarouselController.nextPage(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.fastOutSlowIn);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios_rounded,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        GestureDetector(
                                            onTap: () {
                                              setState(() => groupValue = 0);
                                              if (widget.isWineList ?? false) {
                                                getWineList();
                                              }
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: groupValue != 0
                                                      ? Colors.grey
                                                          .withOpacity(0.1)
                                                      : backGroundColor
                                                          .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 7,
                                                      horizontal: 18),
                                              child: Text(
                                                "Wine",
                                                style: TextStyle(
                                                    color: groupValue != 0
                                                        ? null
                                                        : backGroundColor,
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() => groupValue = 2);
                                            if (widget.isWineList ?? false) {
                                              getWineList();
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: groupValue != 2
                                                    ? Colors.grey
                                                        .withOpacity(0.1)
                                                    : backGroundColor
                                                        .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7, horizontal: 18),
                                            child: Text(
                                              "Cocktail",
                                              style: TextStyle(
                                                  color: groupValue != 2
                                                      ? null
                                                      : backGroundColor,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  CarouselSlider(
                                    carouselController:
                                        buttonCarouselController,
                                    items: (wineList?.data ?? [])
                                        .map(
                                          (item) => Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            elevation: 5,
                                            color: Colors.white,
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 10),
                                              height: 50,
                                              width: 270,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              clipBehavior: Clip.hardEdge,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  isLoading
                                                      ? Container(
                                                          color: Colors.white,
                                                          child: const Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                            color: Colors.blue,
                                                          )),
                                                        )
                                                      : SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                child: Text(
                                                                  wineList?.data ==
                                                                          null
                                                                      ? ''
                                                                      : (wineList?.data?.isEmpty ??
                                                                              true)
                                                                          ? ''
                                                                          : (wineList?.data?[sliderIndex].itemName ??
                                                                              ''),
                                                                  maxLines: 2,

                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  // overflow: TextOverflow.ellipsis,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                                ),
                                                              ),
                                                              const Text(
                                                                " 2022",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              groupValue == 0
                                                                  ? Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Image.asset(
                                                                              // groupValue == 0
                                                                              //     ? Res.glass
                                                                              //     : Res.cocktail,

                                                                              "assets/images/fa-solid_wine-glass.png",
                                                                              width: 50,
                                                                              height: 50,
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Text(
                                                                              "£${item.pricePerGlass}",
                                                                              //     groupValue ==
                                                                              // 0
                                                                              // ? (item.pricePerGlass
                                                                              // .toString() +
                                                                              // '£')
                                                                              // : groupValue ==
                                                                              // 2
                                                                              // ? (item.pricePeCocktail.toString() +
                                                                              // '£')
                                                                              // : '',
                                                                              style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            const Text(
                                                                              "per glass",
                                                                              style: TextStyle(color: Colors.black, fontSize: 13),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Image.asset(
                                                                              "assets/images/mdi_bottle-wine.png",
                                                                              width: 50,
                                                                              height: 50,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Text(
                                                                              // "£${wineList?.data?[sliderIndex].pricePerBott}",

                                                                              '£${item.pricePerBott}',
                                                                              //     groupValue ==
                                                                              // 0
                                                                              // ? (item.pricePerBott
                                                                              // .toString() +
                                                                              // '£')
                                                                              // : groupValue ==
                                                                              // 2
                                                                              // ? (item.pricePeCocktail.toString() +
                                                                              // '£')
                                                                              // : '',
                                                                              style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            const Text(
                                                                              "per bottle",
                                                                              style: TextStyle(color: Colors.black, fontSize: 13),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    )
                                                                  : Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          "assets/images/Vector.png",
                                                                          width:
                                                                              60,
                                                                          height:
                                                                              60,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          "£${item.pricePeCocktail}",
                                                                          style: const TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold),
                                                                        )
                                                                      ],
                                                                    ),
                                                              const SizedBox(
                                                                height: 30,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    buttonWidget(
                                                                        callback:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => ItemDetailsScreen(wineId: item.id),
                                                                            ),
                                                                          );
                                                                        },
                                                                        text:
                                                                            "See more",
                                                                        radius:
                                                                            100,
                                                                        color:
                                                                            backGroundColor),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    options: CarouselOptions(
                                      height: 45.h,
                                      viewportFraction: 1,
                                      // aspectRatio: 16/11,
                                      // enlargeStrategy:
                                      //     CenterPageEnlargeStrategy.scale,
                                      onPageChanged: (index, reason) {
                                        // if (callback != null) callback(index);

                                        setState(() {
                                          sliderIndex = index;
                                        });
                                      },
                                      initialPage: 0,
                                      enlargeCenterPage: false,
                                      pageSnapping: true,
                                      enableInfiniteScroll: false,
                                      reverse: false,
                                      autoPlay: false,
                                      autoPlayInterval:
                                          const Duration(seconds: 3),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            (wineList?.data ?? []).isEmpty
                                ? Container()
                                : Container(
                                    margin: EdgeInsets.only(top: 8.h),
                                    child: IconButton(
                                      onPressed: () {
                                        buttonCarouselController.previousPage(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.fastOutSlowIn);
                                      },
                                      icon: Icon(
                                        Icons.navigate_next_rounded,
                                        color: Colors.black,
                                        size: 5.h,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: widget.menuData?.food?.length ?? 0,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemScreen(
                                foodId: widget.menuData?.food?[index].pairId,
                                isWineList: true,
                                menuName:
                                    widget.menuData?.food?[index].foodName,
                              ),
                            ));
                        if (kDebugMode) {
                          print('button clicked');
                        }
                      },
                      child: Container(
                        height: 10.h,
                        margin: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 1.h),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                padding: EdgeInsets.all(2.h),
                                height: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                  color: Color(0xFFB41712),
                                ),
                                child: Image.asset(
                                  Res.bottle,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                margin: EdgeInsets.only(left: 1.5.h),
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.menuData?.food?[index].foodName ?? '',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp,
                                    fontFamily: fontFamily,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
      isLoading: isLoading,
    );
  }

  getWineList() {
    checkInternet().then(
      (internet) async {
        if (internet) {
          sliderIndex = 0;

          FoodItemsProviders()
              .wineListingAPi(groupValue == -1
                  ? {
                      'food_id': widget.foodId,
                    }
                  : {
                      'food_id': widget.foodId,
                      'wine_by': groupValue == 0 ? 'bottle' : 'cocktail',
                    })
              .then((Response response) async {
            wineList = WineListModel.fromJson(json.decode(response.body));

            if (response.statusCode == 200 && wineList?.status == 1) {
              setState(() {
                isLoading = false;
              });
            } else {
              setState(() {
                isLoading = false;
              });
              buildErrorDialog(context, '', wineList?.message.toString() ?? '');
            }
          }).catchError(
            (onError) {
              setState(
                () {
                  isLoading = false;
                },
              );
              buildErrorDialog(context, 'Error', 'Something went wrong');
            },
          );
        } else {
          setState(() {
            isLoading = false;
          });
          buildErrorDialog(context, 'Error', 'Internet Required');
        }
      },
    );
  }
}
