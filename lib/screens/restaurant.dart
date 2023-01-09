import 'dart:convert';
import 'dart:io';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chirz/Model/locations_list_model.dart';
import 'package:chirz/Model/restaurant_data.dart';
import 'package:chirz/Model/review_model.dart';
import 'package:chirz/providers/auth-providers.dart';
import 'package:chirz/providers/restaurent-provider.dart';
import 'package:chirz/res.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/shared-preference.dart';
import 'package:chirz/utils/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'cartScreen.dart';
import 'menu-screen.dart';

typedef void StringCallback(int val);
class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({Key? key}) : super(key: key);
  @override
  _RestaurantsScreenState createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  var rid;
  dynamic data;
dynamic  deviceid;

  // Future<String?> getDeviceIdentifier() async {
  //   String? deviceIdentifier;
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isAndroid) {
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     setState(() {
  //       deviceIdentifier = androidInfo.androidId!;
  //       deviceid=deviceIdentifier;
  //       print(deviceid);
  //       print("hiiii");
  //       print(deviceIdentifier);
  //     });
  //   } else if (Platform.isIOS) {
  //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //     setState(() {
  //       deviceIdentifier = iosInfo.identifierForVendor!;
  //       deviceid=deviceIdentifier;
  //       print(deviceid);
  //     });
  //   }
  //   return deviceIdentifier;
  // }
  bool isLoading = true;
    ReviewModel? reviewmodel;
   RestaurantData? restaurants;
   RestaurantData? newRestaurants;
   RestaurantData? nearRestaurants;
   LocationsListModel? restaurantLocationList;
  TextStyle textStyle = TextStyle(
    color: Colors.grey,
    fontSize: 12.sp,
  );
  final TextEditingController _searchQuery = TextEditingController();
  int? defaultChoiceIndex = 0;
  final List<String> _choicesList = [];
  @override
  void initState() {
   getPopular();
   getip();
    super.initState();
  }
  getip()async{
    try {
      /// Initialize Ip Address
      var ipAddress = IpAddress(type: RequestType.text);

      /// Get the IpAddress based on requestType.
      data =  await ipAddress.getIpAddress();
      print(data);
      setState(() {
        deviceid=data;

      });
      print(deviceid);
    } on IpAddressException catch (exception) {
      /// Handle the exception.
      print(exception.message);
    }
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int sliderIndex = 0;
  int index1=0;
  ScrollController nearController = ScrollController();
  ScrollController newController = ScrollController();
  ScrollController popularController = ScrollController();
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
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: false,
          title: const Text(
            'Restaurants',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: "Lato",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          actions: [
            if (userData != null)
           /*   Container(
                child: NamedIcon(
                  iconData: const Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ),
                    );
                  },
                ),
              ),*/
            SizedBox(
              width: 1.h,
            ),
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                margin: EdgeInsets.only(right: 2.h),
                child: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: isLoading
            ? Container()
            : Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.5.h),
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      autofocus: false,
                      controller: _searchQuery,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          getRestaurant(value);
                        }
                        else if(value.isEmpty){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RestaurantsScreen()));
                        }
                        else{
                        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RestaurantsScreen()));
                        }
                      },
                      decoration: InputDecoration(
                      //  fillColor: Colors.white,
                        hoverColor: Colors.white,
                        focusColor: Colors.white,
                        filled: false,
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Colors.grey,
                          size: 3.0.h,
                        ),
                        hintText: 'Search',
                        hintStyle: textStyle,
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                      /*border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.sp)),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.sp)),

                        ),*/
                      ),
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(top: 1.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _searchQuery.text.isNotEmpty
                                ? (restaurants == null
                                            ? SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: const Center(
                                                    child: Text(
                                                  'Restaurants Not Found',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )),
                                              )
                                            : restaurants?.data?.length ?? 0) ==
                                        0
                                    ? SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Center(
                                          child: Text(
                                            'Restaurants Not Found',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 2.h),
                                        child: GridView.builder(
                                            shrinkWrap: true,
                                            itemCount: restaurants == null
                                                ? 0
                                                : restaurants?.data?.length ??
                                                    0,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                height: 18.h,
                                                width: 20.h,
                                                margin: EdgeInsets.only(
                                                    right: 1.h, bottom: 1.h),
                                                child: GestureDetector(
                                                  onTap: () async {

                                                    String? search =
                                                        await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  RestaurantMenuScreen(
                                                                restaurantId: restaurants
                                                                        ?.data?[
                                                                            index]
                                                                        .restaurantId ??
                                                                    '',
                                                                restaurantName: restaurants
                                                                        ?.data?[
                                                                            index]
                                                                        .restaurantname ??
                                                                    '',
                                                              ),
                                                            ));
                                                    if (search != null) {
                                                      if (search.isNotEmpty) {
                                                        _searchQuery.text =
                                                            search;
                                                        getRestaurant(search);
                                                      }
                                                    }
                                                  },
                                                  child: Center(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 16.h,
                                                          width: 17.h,
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: restaurants
                                                                    ?.data?[
                                                                        index]
                                                                    .image ??
                                                                '',
                                                            imageBuilder: (context,
                                                                    imageProvider) =>
                                                                Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10.sp),
                                                                ),
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            placeholder: (context,
                                                                    url) =>
                                                                const Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Image.asset(Res
                                                                    .profile_pic_placeholder),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Flexible(
                                                            child: Text(
                                                              restaurants
                                                                      ?.data?[
                                                                          index]
                                                                      .restaurantname ??
                                                                  '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            restaurants
                                                                    ?.data?[
                                                                        index]
                                                                    .location ??
                                                                '',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2)),
                                      )
                                : Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 2.h, horizontal: 4.5.h),
                                        child: Text(
                                          'Nearby',
                                          style: TextStyle(
                                            fontFamily: "Lato",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                      (nearRestaurants == null
                                                  ? 0
                                                  : nearRestaurants
                                                          ?.data?.length ??
                                                      0) ==
                                              0
                                          ? Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2.h),
                                              child: const Text(
                                                  'Restaurants Not Found'),
                                            )
                                          : Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 22.h,
                                              alignment: Alignment.centerLeft,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 1.h),
                                              child: Row(
                                                children: [
                                              /*    GestureDetector(
                                                      onTap: () {
                                                        nearController.animateTo(
                                                            nearController
                                                                    .offset -
                                                                30.h,
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        500),
                                                            curve: Curves
                                                                .easeInOut);
                                                      },
                                                      child: const Padding(
                                                        padding: EdgeInsets.all(
                                                            16.0),
                                                        child: Icon(
                                                          Icons.navigate_before,
                                                        ),
                                                      )),*/
                                                  Expanded(
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      controller:
                                                          nearController,
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount:
                                                          nearRestaurants ==
                                                                  null
                                                              ? 0
                                                              : nearRestaurants
                                                                      ?.data
                                                                      ?.length ?? 0,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                          height: 19.h,
                                                          width: 18.h,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 0.h,
                                                                  bottom: 0.h),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () async {
                                                              // print(nearRestaurants?.data?[index].restaurantId);
                                                              // print(nearRestaurants?.data?[index].restaurantname);

                                                              setState((){
                                                                index1=index;
                                                                // print(deviceid);
                                                                rid=nearRestaurants?.data?[index].restaurantId.toString();

                                                              });
                                                              getreview();
                                                              String? search =
                                                                  await Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                RestaurantMenuScreen(
                                                                          restaurantId:
                                                                              nearRestaurants?.data?[index].restaurantId ?? '',
                                                                          restaurantName:
                                                                              nearRestaurants?.data?[index].restaurantname ?? '',
                                                                        ),
                                                                      ));

                                                             if (search !=
                                                                  null) {
                                                                if (search
                                                                    .isNotEmpty) {
                                                                  _searchQuery
                                                                          .text =
                                                                      search;
                                                                  getRestaurant(
                                                                      search);
                                                                }
                                                              }
                                                            },
                                                            child: Center(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        13.h,
                                                                    width: 13.h,
                                                                    child:
                                                                    
                                                                    CachedNetworkImage(
                                                                      imageUrl:
                                                                          nearRestaurants?.data?[index].image ??
                                                                              '',
                                                                      imageBuilder:
                                                                          (context, imageProvider) =>
                                                                              Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.all(
                                                                            Radius.circular(10.sp),
                                                                          ),
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                imageProvider,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      placeholder: (context,
                                                                              url) =>
                                                                          const Center(
                                                                              child: CircularProgressIndicator()),
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>

                                                                          Image.asset(
                                                                              Res.profile_pic_placeholder),
                                                                    ),
                                                                  ),
                                                                  SizedBox(height: 1.h,),
                                                                  Container(
                                                                    child:
                                                                        Flexible(
                                                                      child:
                                                                          Text(
                                                                        nearRestaurants?.data?[index].restaurantname ??
                                                                            '',
                                                                        textAlign:
                                                                            TextAlign.center,style: TextStyle(
                                                                              fontSize: 16.0,
                                                                              fontFamily:'Lato',fontWeight: FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),SizedBox(height: 1.h,),
                                                                  Flexible(
                                                                    child: Text(
                                                                      nearRestaurants
                                                                              ?.data?[index]
                                                                              .location ??
                                                                          '',
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                               /*   GestureDetector(
                                                      onTap: () {
                                                        nearController.animateTo(
                                                            nearController
                                                                    .offset +
                                                                30.h,
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        500),
                                                            curve: Curves
                                                                .easeInOut);
                                                      },
                                                      child: const Padding(
                                                        padding: EdgeInsets.all(
                                                            16.0),
                                                        child: Icon(
                                                          Icons.navigate_next,
                                                        ),
                                                      )),*/
                                                ],
                                              ),
                                            ),
                                  /*  Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 2.h, horizontal: 4.5.h),
                                        child: Text(
                                          'Suggested',
                                          style: TextStyle(
                                              fontFamily: "Lato",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.sp),
                                        ),
                                      ),
                                      if ((restaurants == null
                                              ? 0
                                              : restaurants?.data?.length ??
                                                  0) ==
                                          0)
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 2.h),
                                          child: const Text(
                                              'Restaurants Not Found'),
                                        )
                                      else
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 22.h,
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 2.h),
                                          child: Row(
                                            children: [
                                            /* GestureDetector(
                                                  onTap: () {
                                                    popularController.animateTo(
                                                        popularController
                                                                .offset -
                                                            30.h,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        curve:
                                                            Curves.easeInOut);
                                                  },
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    child: Icon(
                                                      Icons.navigate_before,
                                                    ),
                                                  )),*/
                                              Expanded(
                                                child: ListView.builder(
                                                  controller: popularController,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: restaurants == null
                                                      ? 0
                                                      : restaurants
                                                              ?.data?.length ??
                                                          0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      height: 18.h,
                                                      width: 18.h,
                                                      margin: EdgeInsets.only(
                                                          right: 1.h,
                                                          bottom: 1.h),
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          String? search =
                                                              await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            RestaurantMenuScreen(
                                                                      restaurantId:
                                                                          restaurants?.data?[index].restaurantId ??
                                                                              '',
                                                                      restaurantName:
                                                                          restaurants?.data?[index].restaurantname ??
                                                                              '',
                                                                    ),
                                                                  ));
                                                          if (search != null) {
                                                            if (search
                                                                .isNotEmpty) {
                                                              _searchQuery
                                                                      .text =
                                                                  search;
                                                              getRestaurant(
                                                                  search);
                                                            }
                                                          }
                                                        },
                                                        child: Center(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                height: 13.h,
                                                                width: 13.h,
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: restaurants
                                                                          ?.data?[
                                                                              index]
                                                                          .image ??
                                                                      '',
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            10.sp),
                                                                      ),
                                                                      image:
                                                                          DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      const Center(
                                                                          child:
                                                                              CircularProgressIndicator()),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Image.asset(
                                                                          Res.profile_pic_placeholder),
                                                                ),
                                                              ),
                                                              SizedBox(height: 1.h,),
                                                              Container(
                                                                child: Flexible(
                                                                  child: Text(
                                                                    restaurants
                                                                            ?.data?[index]
                                                                            .restaurantname ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,style: TextStyle(fontSize: 16.0,
                                                                      fontFamily:'Lato',fontWeight: FontWeight.bold)
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(height: 1.h,),
                                                              Flexible(
                                                                child: Text(
                                                                  restaurants
                                                                          ?.data?[
                                                                              index]
                                                                          .location ??
                                                                      '',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                          /*    GestureDetector(
                                                  onTap: () {
                                                    popularController.animateTo(
                                                        popularController
                                                                .offset +
                                                            30.h,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        curve:
                                                            Curves.easeInOut);
                                                  },
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    child: Icon(
                                                      Icons.navigate_next,
                                                    ),
                                                  )),*/
                                            ],
                                          ),
                                        ),*/
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 2.h, horizontal: 4.5.h),
                                        child: Text(
                                          'Suggested',
                                          style: TextStyle(
                                              fontFamily: "Lato",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                      (newRestaurants == null
                                                  ? 0
                                                  : newRestaurants
                                                          ?.data?.length ??
                                                      0) ==
                                              0
                                          ? Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2.h),
                                              child: const Text(
                                                'Restaurants Not Found',
                                              ),
                                            )
                                          : Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 25.h,
                                              alignment: Alignment.centerLeft,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 1.h),
                                              child: Row(
                                                children: [
                                               //   GestureDetector(
                                             //         onTap: () {
                                             //           newController.animateTo(
                                            //                newController
                                            //                        .offset -
                                            //                    30.h,
                                            //                duration:
                                            //                    const Duration(
                                           //                         milliseconds:
                                           //                             500),
                                           //                 curve: Curves
                                           //                     .easeInOut);
                                           //           },
                                           //           child: const Padding(
                                          //              padding: EdgeInsets.all(
                                          //                  16.0),
                                         //               child: Icon(
                                           //               Icons.navigate_before,
                                         //               ),
                                        //             )),
                                                  Expanded(child:
                                                    ListView.builder(
                                                      controller: newController,
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount:
                                                          newRestaurants == null
                                                              ? 0
                                                              : newRestaurants
                                                                      ?.data
                                                                      ?.length ??
                                                                  0,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(

                                                          height: 25.h,
                                                          width: 18.h,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 0.h,
                                                                  bottom:0.h),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () async {
                                                              // print( newRestaurants!.data![index].restaurantId ?? '');
                                                              // print(newRestaurants!.data![index].zipcode ?? '');
                                                             setState(() {
                                                                rid=newRestaurants!.data![index].restaurantId ?? '';

                                                              });

                                                              getreview();
                                                              String? search =
                                                                  await Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                RestaurantMenuScreen(
                                                                          restaurantId:
                                                                              newRestaurants?.data?[index].restaurantId ?? '',
                                                                          restaurantName:
                                                                              newRestaurants?.data?[index].restaurantname ?? '',
                                                                        ),
                                                                      )) ;
                                                              if (search !=
                                                                  null) {
                                                                if (search
                                                                    .isNotEmpty) {
                                                                  _searchQuery
                                                                          .text =
                                                                      search;
                                                                  getRestaurant(
                                                                      search);
                                                                }
                                                              }
                                                            },
                                                            child: Center(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    height:13.h,
                                                                    width: 13.h,
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      imageUrl:
                                                                          newRestaurants?.data?[index].image ??
                                                                              '',
                                                                      imageBuilder:
                                                                          (context, imageProvider) =>
                                                                              Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.all(
                                                                            Radius.circular(10.sp),
                                                                          ),
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                imageProvider,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      placeholder: (context,
                                                                              url) =>
                                                                          const Center(
                                                                              child: CircularProgressIndicator()),
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          Image.asset(
                                                                              Res.profile_pic_placeholder),
                                                                    ),
                                                                  ),SizedBox(height: 1.h,),
                                                                  Container(
                                                                    child:
                                                                        Flexible(
                                                                      child:
                                                                          Text(
                                                                        newRestaurants?.data?[index].restaurantname ??
                                                                            '',
                                                                        overflow: TextOverflow.ellipsis,
                                                                        maxLines: 2,
                                                                        textAlign: TextAlign.center,
                                                                              style: TextStyle(fontSize: 16.0,
                                                                              fontFamily:'Lato',fontWeight: FontWeight.bold)
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(height: 1.h,),
                                                                  Flexible(
                                                                    child: Text(
                                                                      newRestaurants
                                                                              ?.data?[index]
                                                                              .location ??
                                                                          '',
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                //  GestureDetector(
                                                   //   onTap: () {
                                                      //  newController.animateTo(
                                                      //     newController
                                                       //             .offset +
                                                       //         30.h,
                                                      //      duration:
                                                        //       const Duration(
                                                      //              milliseconds:
                                                       //                 500),
                                                     //      curve: Curves
                                                      //          .easeInOut);
                                                    //  },
                                                     // child: const Padding(
                                                    //    padding: EdgeInsets.all(
                                                   //         16.0),
                                                    //    child: Icon(
                                                      //    Icons.navigate_next,
                                                      //  ),
                                                    //  )),
                                                ],
                                              ),
                                            ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      isLoading: isLoading,
    );
  }

  Widget corasalLengthScroll({List<String>? list, required int sliderIndex}) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: list?.length ?? 0,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: sliderIndex == index ? Colors.yellow : Colors.grey,
        ),
        margin: EdgeInsets.symmetric(horizontal: 1.w),
        width: 2.w,
        height: 1.h,
      ),
    );
  }

  Widget corasalScroll({
    List<String>? list,
    double? height,
    bool isShadow = true,
    StringCallback? callback,
  }) {
    return CarouselSlider(
      items: (list ?? [])
          .map(
            (item) => Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 3.5.h),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.red,
                boxShadow: isShadow
                    ? [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 0), // changes position of shadow
                        ),
                      ]
                    : [],
                borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                // border: Border.symmetric(
                //   horizontal: BorderSide(
                //     color: Colors.black,
                //     width: 2,
                //   ),
                // ),
              ),
              child: Image.asset(
                item,
                fit: BoxFit.cover,
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: height ?? 0,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        viewportFraction: 1,
        onPageChanged: (index, reason) {
          if (callback != null) callback(index);

          // setState(() {
          //   sliderIndex = index;
          // });
        },
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: false,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  getRestaurant(body) {
    checkInternet().then((internet) async {
      if (internet) {
        RestaurantProviders()
            .getRestaurantLocationWise(body: body)
            .then((Response response) async {
          RestaurantData restaurantData =
              RestaurantData.fromJson(json.decode(response.body));

          print(restaurantData.toJson());
          if (response.statusCode == 200 && restaurantData.status == 1) {
            restaurants = restaurantData;
            setState(() {
              isLoading = false;
            });
          } else {
            restaurants = restaurantData;
            setState(() {
              isLoading = false;
            });
          }
          print(restaurants?.data);
        }).catchError((onError) {
          setState(() {
            isLoading = false;
          });
          buildErrorDialog(
              context, 'Error', 'Something went wrong' + onError.toString());
        });
      } else {
        setState(() {
          isLoading = false;
        });
        buildErrorDialog(context, 'Error', 'Internet Required');
      }
    });
  }

 getPopular() async {
    setState(() {
      isLoading = true;
    });

    checkInternet().then((internet) async {
      if (internet) {
        RestaurantProviders()
            .getPopularRestaurant()
            .then((Response response) async {
          RestaurantData restaurantData =
              RestaurantData.fromJson(json.decode(response.body));
          getNew();
          if (response.statusCode == 200 && restaurantData.status == 1) {
            restaurants = restaurantData;
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
          //  buildErrorDialog(context, '', restaurantData.message.toString());
          }
        }).catchError((onError) {
          getNew();
          print('ad' + onError.toString());
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

  getNew() {
    checkInternet().then((internet) async {
      if (internet) {
        RestaurantProviders()
            .getNewRestaurant()
            .then((Response response) async {
          RestaurantData restaurantData =
              RestaurantData.fromJson(json.decode(response.body));
          getNearRest();

          if (response.statusCode == 200 && restaurantData.status == 1) {
            newRestaurants = restaurantData;
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
          }
        }).catchError((onError) {
          getNearRest();
          print('ad' + onError.toString());
          setState(() {
            isLoading = false;
          });
        });
      } else {
        setState(() {
          isLoading = false;
        });
        buildErrorDialog(context, 'Error', 'Internet Required');
      }
    });
  }

  getNearRest() {
    print(nearRestaurants?.data?[index1].restaurantname);
    checkInternet().then((internet) async {
      if (internet) {
        RestaurantProviders()
            .getNearestRestaurant()
            .then((Response response) async {
          RestaurantData restaurantData =
              RestaurantData.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && restaurantData.status == 1) {
            nearRestaurants = restaurantData;
           // print(nearRestaurants?.message.toString());
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
          }
        }).catchError((onError) {
          print('ad' + onError.toString());
          setState(() {
            isLoading = false;
          });
        });
      } else {
        setState(() {
          isLoading = false;
        });
        buildErrorDialog(context, 'Error', 'Internet Required');
      }
    });
  }
  getreview() {
  print(deviceid.toString());
    setState(() {
      isLoading = false;
    });
    checkInternet().then((internet) async {
      if (internet) {
        AuthProviders()
            .review(rid,deviceid)
            .then((Response response) async {
          ReviewModel reviewmodel = ReviewModel.fromJson(json.decode(response.body));
            print(reviewmodel.status);
            if (response.statusCode == 200 && reviewmodel.status == "Success") {
            setState(() {
              isLoading = false;
            });
            /*buildErrorDialog(
              context,
              '',
              'Profile Updated',
              callback: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            );*/
            // }
            // else {
            //   setState(() {
            //     isLoading = false;
            //   });
            //   buildErrorDialog(context, 'Error', userDataModel?.message ?? '');
            // }
          }
        }).catchError((onError) {
          setState(() {
            isLoading = false;
          });
//          buildErrorDialog(context, 'Error', 'Something went wrong');
        });
      } else {
        setState(() {
          isLoading = false;
        });
  //      buildErrorDialog(context, 'Error', 'Internet Required');
      }
    });
  }
}
