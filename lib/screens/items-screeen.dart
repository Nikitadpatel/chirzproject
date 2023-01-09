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
  String? winetype;
  WineListModel? wineList;
  @override
  void initState() {
    groupValue = 0;
    setState(() {
      print(widget.foodId);
      isselect1=false;
      isLoading = true;
      isselect2=false;
      isselect3=false;
      if (widget.isWineList ?? false) {
        getWineList();
      }
    });
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
                                        Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                errorWidget: (context, url, error) => Container(
                                  width: double.infinity,
                                  height: 26.h,
                                  decoration: const BoxDecoration(
                                   /* image: DecorationImage(
                                     image: AssetImage(
                                          "assets/images/Rectangle 51.png"),
                                    ),*/
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
                          height: 15,
                        ),
                        Text(
                          widget.menuName ?? '',
                          style: const TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Lato",
                            color: Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.discription ?? "no discription",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Lato",
                            color: Color(0xffb090A0A),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '£${widget.foodPrice}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Lato",
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                           // (wineList?.data ?? []).isEmpty
                           //    ? Container()
                           //   : Container(
                           //         margin: EdgeInsets.only(top: 8.h),
                            //        child: IconButton(
                               //       onPressed: () {
                                //       buttonCarouselController.nextPage(
                                //            duration: const Duration(
                                //               milliseconds: 300),
                                 //         curve: Curves.fastOutSlowIn);
                                 //     },
                                //    icon: const Icon(
                                 //      Icons.arrow_back_ios_rounded,
                                 //       color: Colors.black,
                                 //     ),
                                  //  ),
                                //  ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        GestureDetector(
                                            onTap: () {
                                              setState(()
                                                  {
                                                  groupValue = 0;
                                                  if (widget.isWineList ?? false) {
                                                    getWineList();
                                                  }
                                                  });
                                            },
                                            child: Container(
                                              height: 32.0,
                                              width: 80.0,
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
                                                    fontSize: 16,
                                                    fontFamily: "Lato",
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState((){ groupValue = 2;
                                            if (widget.isWineList ?? false) {
                                              getWineList();
                                            }
                                            });
                                          },
                                          child: Container(
                                            height: 32.0,
                                            width: 100.0,
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
                                                  fontSize: 16,
                                                  fontFamily: "Lato",
                                                  fontWeight:
                                                  FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CarouselSlider(
                                    carouselController:
                                        buttonCarouselController,
                                    items: (wineList?.data ?? [])
                                        .map(
                                          (item) => Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            elevation: 4,
                                            color: Colors.white,
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 10),
                                              width: 283,
                                              height: 45.h,
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
                                                                        fontFamily: "Lato",
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 5.0,
                                                              ),
                                                              (groupValue == 0) ? Text(
                                                                wineList?.data ==
                                                                    null
                                                                    ? ''
                                                                    : (wineList?.data?.isEmpty ??
                                                                    true)
                                                                    ? ''
                                                                    : (wineList?.data?[sliderIndex].itemType
                                                                    ??
                                                                    ''),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                    17,
                                                                    fontFamily: "Lato",
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                                textAlign:
                                                                TextAlign
                                                                    .center,
                                                              ) :Container(),
                                                              (groupValue == 0) ?  Text(
                                                                  wineList?.data ==
                                                                      null
                                                                      ? ''
                                                                      : (wineList?.data?.isEmpty ??
                                                                      true)
                                                                      ? ''
                                                                      : (wineList?.data?[sliderIndex].year ??
                                                                      ''),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily: "Lato",
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ) : Container(),
                                                              const SizedBox(
                                                                height: 17,
                                                              ),
                                                              groupValue == 0
                                                             ?
                                                                  //wine
                                                              (((wineList?.data?[sliderIndex].pricePerBott) == "") && ((wineList?.data?[sliderIndex].pricePerGlass) != "") ?
                                                             //if only wine per glass available
                                                              Container(
                                                              child: GestureDetector(
                                                                 /*onTap:(){
                                                                   print(wineList?.data?[sliderIndex].pricePerBott.toString());
                                                                    setState((){
                                                                      isselect1=!isselect1;
                                                                      /* if (widget.isWineList ?? false) {
                                                                          getWineList();
                                                                       }*/
                                                                    });

                                                                  },*/
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment.spaceAround,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment.center,
                                                                    children: [
                                                                      Container(
                                                                        height:60.0,
                                                                        width: 50.0,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(10.0),
                                                                          //  border:
                                                                           // isselect1 ?  Border.all(color: Colors.red,
                                                                              //  width: 2.0):null
                                                                          ),
                                                                        child: Image.asset(
                                                                          // groupValue == 0
                                                                          //     ? Res.glass
                                                                          //     : Res.cocktail,
                                                                          "assets/images/fa-solid_wine-glass.png",
                                                                          width: 50,
                                                                          height: 50,
                                                                        ),
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
                                                                ),
                                                              ):
                                                              (((wineList?.data?[sliderIndex].pricePerGlass) == "")  && (wineList?.data?[sliderIndex].pricePerBott) != "")?
                                                                  //if only wine per bottle available
                                                              Container(
                                                                child: GestureDetector(
                                                               /*   onTap: (){
                                                                    setState((){
                                                                      isselect2=!isselect2;
                                                                       /*if (widget.isWineList ?? false) {
                                                                           getWineList();
                                                                      }*/
                                                                    });
                                                                  },*/
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment.spaceBetween,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment.center,
                                                                    children: [
                                                                      Container(
                                                                        height:60.0,
                                                                        width: 50.0,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(10.0),
                                                                           // border:
                                                                           //isselect2?  Border.all(color: Colors.red,
                                                                            //    width: 2.0):null
                                                                        ),

                                                                        child: Image.asset(
                                                                          "assets/images/mdi_bottle-wine (1).png",
                                                                          width: 50,
                                                                          height: 50,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
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
                                                                  ),
                                                                ),
                                                              ):
                                                                  //if both available for wine type
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                      children: [
                                                                        GestureDetector(
                                                                         /* onTap:(){
                                                                            setState(() {
                                                                             // isselect = 0;
                                                                              isselect1=!isselect1;
                                                                              isselect2=false;


                                                                             /* if(widget.isWineList ==false){
                                                                                getWineList();
                                                                              }*/
                                                                            });

                                                                          },*/
                                                                          child: SingleChildScrollView(
                                                                            child: Column(
                                                                             mainAxisAlignment:
                                                                               MainAxisAlignment.spaceAround,
                                                                            crossAxisAlignment:
                                                                                 CrossAxisAlignment.center,
                                                                              children: [

                                                                                Container(
                                                                                  padding:EdgeInsets.only(top:25.0,bottom:15.0),
                                                                                  height:70.0,
                                                                                  width:50.0,
                                                                                  decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                                  //    border:
                                                                                    //  isselect1 ? Border.all(color: Colors.red,
                                                                                      //    width: 2.0):null
                                                                                  ),
                                                                                  child: Image.asset(
                                                                                    // groupValue == 0
                                                                                    //     ? Res.glass
                                                                                    //     : Res.cocktail,
                                                                                    "assets/images/fa-solid_wine-glass.png",
                                                                                    width: 25.0,
                                                                                    height: 30.0,
                                                                                  ),
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
                                                                                  style: const TextStyle(color: Colors.black, fontSize: 16,
                                                                                      fontFamily: "Lato",
                                                                                      fontWeight: FontWeight.bold),
                                                                                ),
                                                                                const Text(
                                                                                  "per glass",
                                                                                  style: TextStyle(color: Colors.black, fontSize: 13),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        GestureDetector(
                                                                        /* onTap:(){
                                                                            setState(() {
                                                                             // isselect=1;
                                                                              isselect2=!isselect2;
                                                                              isselect1=false;
                                                                             /* if(widget.isWineList ==false){
                                                                                getWineList();
                                                                              }*/
                                                                            });
                                                                          },*/
                                                                          child: SingleChildScrollView(
                                                                            child: Column(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment:
                                                                                  CrossAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  height:70.0,
                                                                                  width: 50.0,
                                                                                  padding:EdgeInsets.only(top:0.0,bottom:0.0),
                                                                                  decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                                     // border:
                                                                                     // isselect2 ?  Border.all(color: Colors.red,
                                                                                       //   width: 2.0):null
                                                                                  ),
                                                                                  child: Image.asset(
                                                                                    "assets/images/mdi_bottle-wine (1).png",
                                                                                    width: 50.0,
                                                                                    height: 70.0,
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
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
                                                                                  style: const TextStyle(color: Colors.black,
                                                                                      fontFamily: "Lato",
                                                                                      fontSize: 16, fontWeight: FontWeight.bold),
                                                                                ),
                                                                                const Text(
                                                                                  "per bottle",
                                                                                  style: TextStyle(color: Colors.black, fontSize: 13,
                                                                                    fontFamily: "Lato",
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    )
                                                              ):
                                                              //for cocktail
                                                              GestureDetector(
                                                              /*  onTap:(){
                                                                  //groupValue =2;
                                                                  setState(() {
                                                               groupValue=2;
                                                               isselect3=!isselect3;
                                                                    if(widget.isWineList==false){
                                                                      getWineList();
                                                                    }
                                                                  });
                                                                },*/
                                                                    child: SingleChildScrollView(
                                                                      child: Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment
                                                                                  .spaceAround,
                                                                          children: [
                                                                            Container(
                                                                              height:70.0,
                                                                              width: 50.0,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                          //        border:
                                                                           //   isselect3 ?  Border.all(color: Colors.red,
                                                                             //        width: 2.0):null
                                                                              ),
                                                                              child: Image
                                                                                  .asset(
                                                                                "assets/images/Vector.png",
                                                                                width:
                                                                                    50,
                                                                                height:
                                                                                    50,
                                                                              ),
                                                                            ),
                                                                              SizedBox(height: 10.0,),
                                                                            Text(
                                                                              "£${item.pricePeCocktail}",
                                                                              style: const TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 18,
                                                                                  fontWeight: FontWeight.bold),
                                                                            )
                                                                          ],
                                                                        ),
                                                                    ),
                                                                  ),
                                                              const SizedBox(
                                                                height: 13,
                                                              ),
                                                              SizedBox(
                                                               height: 45.0,
                                                               width: 130.0,
                                                                child: ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        padding: EdgeInsets.symmetric(horizontal: 1.h,
                                                                         vertical: 1.h),
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(40), // <-- Radius
                                                                        ),
                                                                     backgroundColor: Color(0xFFAC262C)
                                                                    ),

                                                                  onPressed: (){
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (
                                                                            context) =>
                                                                            ItemDetailsScreen(
                                                                              wineId: item
                                                                                  .id,),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child:Text("See more", style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 12.sp,
                                                                  ),)
                                                                )
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
                                      viewportFraction: 0.75,
                                      // aspectRatio: 16/11,
                                      enlargeStrategy:
                                          CenterPageEnlargeStrategy.scale,
                                      onPageChanged: (index, reason) {
                                        // if (callback != null) callback(index);
                                        setState(() {
                                          isselect1=false;
                                          isselect2=false;
                                          sliderIndex = index;
                                        });
                                      },
                                      initialPage: 0,
                                      enlargeCenterPage: true,
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
                           // (wineList?.data ?? []).isEmpty
                           //     ? Container()
                             // : Container(
                                  //  margin: EdgeInsets.only(top: 8.h),
                                  //  child: IconButton(
                                     // onPressed: () {
                                   //     buttonCarouselController.previousPage(
                                     //       duration: const Duration(
                                   //             milliseconds: 300),
                                 //           curve: Curves.fastOutSlowIn);
                                    //  },
                                  //    icon: Icon(
                                    //    Icons.navigate_next_rounded,
                                  //      color: Colors.black,
                                 //       size: 5.h,
                                   //   ),
                                 //   ),
                               //   ),
                          ],
                        ),
                        SizedBox(height: 3.h,),

                        SizedBox(height: 3.h,),
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
              .wineListingAPi( groupValue== -1
                  ? {
                      'food_id': widget.foodId,
                    }
                  : {
                      'food_id': widget.foodId,

            'wine_by': groupValue==0?(isselect1?"glass":"bottle"):"cocktail",


                      //'wine_by': groupValue == 1 ? 'bottle' : 'cocktail',
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
              print(wineList?.message?.toString());
            }
          }).catchError(
            (onError) {
              setState(
                () {
                  isLoading = false;
                },
              );
              buildErrorDialog(context, '', 'Something went wrong');
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
