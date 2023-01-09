import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chirz/Model/NewWinePairModel.dart';



import 'package:chirz/providers/food_providers.dart';
import 'package:chirz/screens/restaurant.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

import 'cartScreen.dart';
import 'item-details-screen.dart';
import 'items-screeen.dart';

class RestaurantMenuScreen extends StatefulWidget {
  final dynamic restaurantName, restaurantId;

  const RestaurantMenuScreen({Key? key, this.restaurantName, this.restaurantId})
      : super(key: key);

  @override
  _RestaurantMenuScreenState createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {

  bool isLoading = true;
  NwWinePairModel? foodItems;

  final TextEditingController _searchQuery = TextEditingController();
  //search
  List<Food> search = [];

  @override
  void initState() {

    getRestaurantMenu();

    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedIndex = 0;

  TextStyle textStyle = TextStyle(
    color: Colors.grey,
    fontSize: 12.sp,
  );

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: const CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : commanScreen(
            scaffold: Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.white,
              drawer: drawerWidgets(context),
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
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                ),
                actions: [
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => const CartScreen()));
                  //   },
                  //   child: Container(
                  //     margin: EdgeInsets.only(right: 1.h),
                  //     child: const Icon(
                  //       Icons.shopping_cart_outlined,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  // ),
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
                title: Text(
                  (widget.restaurantName) ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Lato",
                    fontSize: 24.0,
                    color: Colors.black,
                  ),
                ),
              ),
              body: Container(
                margin: EdgeInsets.only(left: 2.h, right: 2.h),
                child: Column(
                  children: [
                    TextField(
                      autofocus: false,
                      controller: _searchQuery,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      onChanged: (value) {
                        setState(() {
                          search.clear();
                          if (value.isEmpty) {
                            search = [];
                          } else {
                            //search
                           // log(value.toString());
                            foodItems?.data?[selectedIndex].food?.forEach((e) {
                              if (e.foodName!
                                  .toLowerCase()
                                  .contains(value.toLowerCase())) {
                                log(e.foodName.toString());
                                search.add(e);
                              }
                            });
                          }
                        });
                      },
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        fillColor: Colors.white,
                        hoverColor: Colors.white,
                        focusColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Colors.grey,
                          size: 4.0.h,
                        ),
                        hintText: 'Search',
                        hintStyle: textStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: ListView.builder(
                             // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                               //   crossAxisCount: 3),
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: foodItems?.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    selectedIndex = index;
                                    search = [];
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Container(
                                      padding: EdgeInsets.only(top: 0.0,bottom: 0.0,
                                          left: 5.w, right: 5.w),
                                      decoration: BoxDecoration(
                                        color: index != selectedIndex
                                            ? Colors.grey.withOpacity(0.1)
                                            : backGroundColor.withOpacity(0.2),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          foodItems?.data?[index].menuName ??
                                              '',
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: index != selectedIndex
                                                ? Colors.grey
                                                : const Color(0xFFB41712),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                              fontFamily: "Lato" ,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    //search
                    _searchQuery.text.isNotEmpty && search.isEmpty
                        ? Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Coudn\'t find item',
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ],
                            ),
                          )
                        : Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: item(
                                  search.isNotEmpty
                                      ? Data(
                                          food: search,
                                          menuName: foodItems
                                              !.data![selectedIndex].menuName)
                                      : foodItems!.data![selectedIndex],
                                  selectedIndex),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            isLoading: isLoading,
          );
  }

  Widget item(Data data, index) {
    log(search.length.toString());
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.food?.length ?? 0,
      itemBuilder: (context, index1) {
        //log(data.menuName.toString());
        return InkWell(

          onTap: () {
            var wid=data.food?[index1].isCocktail;
            var resid=widget.restaurantId;

              print("object");
              print(data.food?[index1].aboutWine);
            if (data.menuName.toString().toLowerCase().contains('wine') ||
                data.menuName.toString().toLowerCase().contains('cocktail')) {
              // log(data.food![index1].toString());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ItemDetailsScreen(wineId: data.food?[index1].id),
                ),
              );
            } else {
              // log(data.food![index1].toString());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemScreen(
                    foodId: data.food?[index1].pairId,
                    isWineList: true,
                    menuName: data.food?[index1].foodName,
                    foodImage: data.food?[index1].image,
                    discription: data.food?[index1].description,
                    priceBottle: data.food?[index1].pricePerBott,
                    priceGlass: data.food?[index1].pricePerGlass,
                    foodPrice: data.food?[index1].price,
                  ),
                ),
              );
            }
          },
          child: data.menuName.toString().toLowerCase().contains("wine") ||
                  data.menuName.toString().toLowerCase().contains("cocktail")
              ?
              // wine & cocktail design
              Container(
               // color: Colors.red,
                  height:64.0,
                 margin: EdgeInsets.symmetric( vertical: 1.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 64.0,
                        width: 64.0,
                        child: data.menuName
                                .toString()
                                .toLowerCase()
                                .contains("wine")
                            ? Image.asset(
                                "assets/images/mdi_bottle-wine (1).png",
                                width: 64.0,
                                height: 64.0,
                              )
                            : Image.asset(
                                "assets/images/Vector.png",
                                width: 64.0,
                                height: 64.0,
                              ),
                      ),
                     // Expanded(
                      //SizedBox(width: 5.w,),
                      SizedBox(width:16.0),
                Container(
                         // margin: EdgeInsets.only(left: 1.5.h),
                          //padding: EdgeInsets.symmetric(vertical: 2.h),
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                           // width: 45.w,
                            width:195.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  data.food?[index1].foodName ?? '',
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp,
                                    fontFamily: fontFamily,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data.food?[index1].aboutWine ??
                                      'No description',
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13.sp,
                                    fontFamily: fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      //),
                     // SizedBox(width: 3.w,),
                      SizedBox(width:16.0),
                      (data.food?[index1].isCocktail == "0")?
                      Container(
                       // width: 20.w,
                        width: 70.0,
                        child: Text(
                          "£ ${data.food?[index1].pricePerGlass} / ${data.food?[index1].pricePerBott}",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: fontFamily,
                          ),
                        ),
                      ):Container(
                        // width: 20.w,
                        width: 70.0,
                        child: Text(
                          "£ ${data.food?[index1].pricePerCocktail }",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: fontFamily,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              :
              // food design
              Container(
               // color: Colors.red,
                //  width: MediaQuery.of(context).size.width,
                  height: 65.0,
                  margin: EdgeInsets.symmetric(vertical: 1.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    //  Expanded(
                         Container(
                           //width:18.w,
                         width: 64.0,
                          clipBehavior: Clip.hardEdge,
                          height: 64.0,
                         decoration: BoxDecoration(
                            /* image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/Rectangle 51.png"),
                                  fit: BoxFit.cover),*/
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.7)
                          ),

                          child: CachedNetworkImage(
                            imageUrl: data.food?[index1].image ?? '',
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Image.asset('assets/images/Vector (2).png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                   //   ),
                     // SizedBox(width: 3.w,),
                      SizedBox(width:16.0),
                     // Expanded(
                       // flex:5,
                Container(
                         // width: 47.w,
                              width:195.0,
                       //   margin: const EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.food?[index1].foodName ?? '',
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.sp,
                                  fontFamily: fontFamily,
                                ),
                              ),
                              Text(
                                data.food?[index1].description ??
                                    "no description",
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp,
                                    fontFamily: fontFamily,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                      //),
                      //SizedBox(width: 10.w,),
                      SizedBox(width:30.0),
                      Container(
                       // width: 20.w,
                        width:50.0,
                      //  padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '£${data.food?[index1].price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                              color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  getRestaurantMenu() {
    print(widget.restaurantId);

    checkInternet().then((internet) async {
    //  log(widget.restaurantId);
      if (internet) {
        FoodItemsProviders().foodListingAPi({

         'restaurant_id': widget.restaurantId,
        }).then((Response response) async {

          foodItems = NwWinePairModel.fromJson(json.decode(response.body));
         //   print(foodItems!.message.toString());
          if (response.statusCode == 200 && foodItems?.status == 1) {
            setState(() {
              isLoading = false;
            });
          }
          else {

        //    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RestaurantsScreen()));


            setState(() {
              isLoading = false;
            });
           BuildErrorDialog(context, '', foodItems?.message.toString() ?? '');


          }
        }).catchError((onError) {
          setState(() {
            isLoading = false;
          });
          buildErrorDialog(context, 'Error', 'Something went wrong');
        //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RestaurantsScreen()));
        });
      } else {
        setState(() {
          isLoading = false;
        });
        buildErrorDialog(context, 'Error', 'Internet Required');
      }
    });
  }
  BuildErrorDialog(BuildContext context,String title, String contant,
      {VoidCallback? callback, String? buttonname}) {
    Widget okButton = TextButton(
      child: Container(
        height: 40.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20.0),
            color:Color(0xFFB41712)
        ),
        child: Center(
          child: Text(buttonname ?? 'OK',
              // textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.black,
                  fontFamily: 'poppins')),
        ),
      ),
      onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RestaurantsScreen()));
      },
    );
    if (Platform.isAndroid) {
      AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        titlePadding: EdgeInsets.all(0.0),
        contentPadding: EdgeInsets.only(top: 0.0,bottom: 0.0,left: 20.0),
        title: Text(title,
            style: const TextStyle(
                color: Colors.black,
                decorationColor: Colors.black,
                fontFamily: 'poppins')),
        content: Text(contant,
            style: const TextStyle(
                color: Colors.black,
                decorationColor: Colors.black,
                fontFamily: 'poppins')),
        actions: [
          okButton,
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
        title: Text(title,
            style: const TextStyle(
                color: Colors.black,
                decorationColor: Colors.black,
                fontFamily: 'poppins')),
        content: Text(contant,
            style: const TextStyle(
                color: Colors.black,
                decorationColor: Colors.black,
                fontFamily: 'poppins')),
        actions: [
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return cupertinoAlertDialog;
        },
      );
    }
    // show the dialog
  }
}


