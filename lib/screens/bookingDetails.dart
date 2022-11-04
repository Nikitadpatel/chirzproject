import 'dart:convert' show json;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chirz/Model/order_booking_model.dart';
import 'package:chirz/providers/order_provider.dart';
import 'package:chirz/screens/order_details.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../res.dart';

class BookingDetails extends StatefulWidget {
  const BookingDetails({Key? key}) : super(key: key);

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  OrderBookingModel? orderBookingModel;

  @override
  void initState() {
    getBookingList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return commanScreen(
      scaffold: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        endDrawerEnableOpenDragGesture: false,
        drawerScrimColor: Colors.transparent,
        drawer: drawerWidgets(context),
        appBar: AppBar(
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
            'Orders',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 1.h),
          child: (orderBookingModel == null
                      ? 0
                      : orderBookingModel?.data?.length ?? 0) ==
                  0
              ? const SizedBox(
                  child: Center(child:  Text('Orders Not Found')),
                )
              : ListView.builder(
                  itemCount: orderBookingModel == null
                      ? 0
                      : orderBookingModel?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    DateTime dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss")
                        .parse(
                            orderBookingModel?.data?[index].createdDate ?? '');
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetails(
                                orderId:
                                    orderBookingModel?.data?[index].orderId,
                              ),
                            ));
                      },
                      child: Container(
                        height: 27.h,
                        padding: EdgeInsets.all(2.h),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        margin: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.h),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.sp),
                                ),
                                color: Colors.pink,
                              ),
                              child: SizedBox(
                                height: 25.h,
                                width: 17.h,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      child: CachedNetworkImage(
                                        imageUrl: orderBookingModel
                                                ?.data?[index].itemImage ??
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
                                            Container(
                                          color: Colors.grey,
                                          child: Image.asset(
                                              Res.profile_pic_placeholder),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          color: Colors.teal.shade300,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10.sp),
                                            bottomRight: Radius.circular(10.sp),
                                          ),
                                        ),
                                        height: 12.h,
                                        width: 17.h,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${dateFormat.hour}:${dateFormat.minute}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11.sp,
                                              ),
                                            ),
                                            Text(
                                              '${dateFormat.day}${getDayOfMonthSuffix(dateFormat.day)}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              date(dateFormat.month)
                                                  .substring(0, 3),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 3.h,
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          orderBookingModel
                                                  ?.data?[index].username ??
                                              '',
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        Text(
                                          orderBookingModel
                                                  ?.data?[index].itemName
                                                  .toString()
                                                  .trim() ??
                                              '',
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          orderBookingModel
                                                  ?.data?[index].phoneNumber
                                                  .toString() ??
                                              '',
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              top:  BorderSide(
                                                  color: Colors.grey))),
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Total',
                                              textAlign: TextAlign.start,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.sp),
                                            ),
                                            Text(
                                                (orderBookingModel
                                                            ?.data?[index].total
                                                            .toString() ??
                                                        '') +
                                                    ' £',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.sp)),
                                          ],
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
                  },
                ),
        ),
      ),
      isLoading: isLoading,
    );
  }

  getBookingList() {
    setState(() {
      isLoading = true;
    });

    checkInternet().then((internet) async {
      if (internet) {
        OrdersProviders().orderBookingsList().then((Response response) async {
          orderBookingModel =
              OrderBookingModel.fromJson(json.decode(response.body));

          if (response.statusCode == 200 && orderBookingModel?.status == 1) {
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
