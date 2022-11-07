import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chirz/Model/order_details_model.dart';
import 'package:chirz/providers/order_provider.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class OrderDetails extends StatefulWidget {
  final dynamic orderId;

  const OrderDetails({Key? key, this.orderId}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  OrderDetailsModel? orderDetailsModel;

  @override
  void initState() {
    getOrder();
    super.initState();
  }

  DateTime? dateFormat;

  @override
  Widget build(BuildContext context) {
    return commanScreen(
      scaffold: Scaffold(
        key: _scaffoldKey,
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
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text(
            'Booking Summery',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 1.h),
          child: (orderDetailsModel == null)
              ? Container(
                  child: Center(child: Text('Order Not FOund')),
                )
              : Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.h),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.h, vertical: 3.h),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Booking at'),
                            Row(
                              children: [
                                Icon(Icons.timer),
                                SizedBox(
                                  width: 1.h,
                                ),
                                Text(
                                  dateFormat == null
                                      ? ''
                                      : (DateFormat('EEEE')
                                              .format(dateFormat!)
                                              .toString()) +
                                          ', ' +
                                          date(dateFormat?.month)
                                              .substring(0, 3) +
                                          ' ${dateFormat?.day}${getDayOfMonthSuffix((dateFormat?.day ?? 0)) + ' ' + ' ' + (dateFormat?.year.toString() ?? '')}' +
                                          ', ${dateFormat?.hour}:${dateFormat?.minute}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30)),
                          ),
                          child: SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 2.h),
                              height: MediaQuery.of(context).size.height,
                              alignment: Alignment.topCenter,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Customer Details',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.h, vertical: 3.h),
                                    margin: EdgeInsets.symmetric(vertical: 1.h),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Column(
                                      children: [
                                        restaurentDetails('Customer Name',
                                            userData?.data?.username ?? ''),
                                        restaurentDetails('Customer Name',
                                            userData?.data?.email ?? ''),
                                      ],
                                    ),
                                  ),
                                  Text('Restaurant Details',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.h, vertical: 3.h),
                                    margin: EdgeInsets.symmetric(vertical: 1.h),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Column(
                                      children: [
                                        restaurentDetails(
                                            'Restaurant Name',
                                            orderDetailsModel
                                                    ?.data
                                                    ?.restaurantsDetail
                                                    ?.restaurantname ??
                                                ''),
                                        restaurentDetails(
                                            'Restaurant Email',
                                            orderDetailsModel
                                                    ?.data
                                                    ?.restaurantsDetail
                                                    ?.email ??
                                                ''),
                                      ],
                                    ),
                                  ),
                                  Text('Product/Service name',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.h, vertical: 3.h),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: orderDetailsModel?.data == null
                                          ? 0
                                          : orderDetailsModel
                                                  ?.data?.itemList?.length ??
                                              0,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            Container(
                                              child: CachedNetworkImage(
                                                imageUrl: orderDetailsModel
                                                        ?.data
                                                        ?.itemList?[index]
                                                        .itemImage ??
                                                    '',
                                                alignment: Alignment.center,
                                              ),
                                              height: 80,
                                              width: 80,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    child: Text(
                                                      orderDetailsModel
                                                              ?.data
                                                              ?.itemList?[index]
                                                              .itemName ??
                                                          '',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.7),
                                                Text(
                                                  'Qty:- ' +
                                                      (orderDetailsModel
                                                              ?.data
                                                              ?.itemList?[index]
                                                              .qty ??
                                                          ''),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  'Item Type:- ' +
                                                      (orderDetailsModel
                                                              ?.data
                                                              ?.itemList?[index]
                                                              .priceType ??
                                                          ''),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  'Price:- ' +
                                                      (orderDetailsModel
                                                              ?.data
                                                              ?.itemList?[index]
                                                              .price ??
                                                          '') +
                                                      '£',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 11.sp),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Divider(
                                          height: 10,
                                          color: Colors.grey,
                                          thickness: 1,
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text('Sub Total',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.sp))),
                                      SizedBox(
                                        width: 10,
                                        height: 20,
                                      ),
                                      Expanded(
                                        child: Text(
                                          (orderDetailsModel?.data?.total ??
                                                  '') +
                                              ' £',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
      isLoading: isLoading,
    );
  }

  Widget restaurentDetails(text, text1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(text), Text(text1)],
    );
  }

  getOrder() {
    setState(() {
      isLoading = true;
    });

    checkInternet().then((internet) async {
      if (internet) {
        print(widget.orderId);
        OrdersProviders()
            .orderDetailsList(widget.orderId)
            .then((Response response) async {
          orderDetailsModel =
              OrderDetailsModel.fromJson(json.decode(response.body));

          if (response.statusCode == 200 && orderDetailsModel?.status == 1) {
            dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss")
                .parse(orderDetailsModel?.data?.createdDate ?? '');
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
          }
        }).catchError((onError) {
          print(onError.toString());
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
