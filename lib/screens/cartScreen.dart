import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chirz/Model/base_model.dart';
import 'package:chirz/Model/cart_list_model.dart';
import 'package:chirz/providers/cart-provider.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

import '../res.dart';
import 'card_details_screen.dart';
import 'item-details-screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CartListModel? cartListModel;

  @override
  void initState() {
    getCartList();
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
            'My Cart',
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
          child: (cartListModel == null
                      ? 0
                      : cartListModel?.data?.length ?? 0) ==
                  0
              ? const SizedBox(
                  child: Center(child: Text('Your Cart is Empty')),
                )
              : Column(
                  children: [
                    Flexible(
                      child: ListView.builder(
                        itemCount: cartListModel == null
                            ? 0
                            : cartListModel?.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemDetailsScreen(
                                      wineId:
                                          cartListModel?.data?[index].itemId,
                                    ),
                                  ));
                              getCartList();
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 2.h, horizontal: 2.h),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 18.h,
                                    width: 17.h,
                                    child: CachedNetworkImage(
                                      imageUrl: cartListModel
                                              ?.data?[index].itemImage ??
                                          '',
                                      imageBuilder: (context, imageProvider) =>
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
                                  SizedBox(
                                    width: 3.h,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              flex: 3,
                                              child: Text(
                                                cartListModel?.data?[index]
                                                        .itemName ??
                                                    '',
                                                textAlign: TextAlign.start,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    height: 3.5.h,
                                                    width: 2.5.h,
                                                    child: TextButton(
                                                      style: ButtonStyle(
                                                        side:
                                                            MaterialStateProperty
                                                                .all(
                                                          const BorderSide(
                                                            color: Colors.black,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(
                                                          EdgeInsets.zero,
                                                        ),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(
                                                          Colors.white,
                                                        ),
                                                        textStyle:
                                                            MaterialStateProperty
                                                                .all(
                                                          TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 7.sp,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        Map map = {
                                                          'action': 'add_cart',
                                                          'item_id':
                                                              cartListModel
                                                                  ?.data?[index]
                                                                  .itemId,
                                                          'user_id': userData
                                                                  ?.data?.uId ??
                                                              '',
                                                          'qty': '1',
                                                          'price': cartListModel
                                                              ?.data?[index]
                                                              .pricePerGlass,
                                                          'price_type': 'glass',
                                                          'cart_action': 'minus'
                                                        };
                                                        addToCart(map);
                                                      },
                                                      child: const Text(
                                                        '-',
                                                        style: TextStyle(
                                                            color: Colors.blue),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2.5.w),
                                                    child: Text(
                                                      cartListModel
                                                              ?.data?[index].qty
                                                              .toString() ??
                                                          '',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3.5.h,
                                                    width: 2.5.h,
                                                    child: TextButton(
                                                      style: ButtonStyle(
                                                        side:
                                                            MaterialStateProperty
                                                                .all(
                                                          const BorderSide(
                                                            color: Colors.black,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(
                                                          EdgeInsets.zero,
                                                        ),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(
                                                          Colors.white,
                                                        ),
                                                        textStyle:
                                                            MaterialStateProperty
                                                                .all(
                                                          TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 7.sp,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        Map map = {
                                                          'action': 'add_cart',
                                                          'item_id':
                                                              cartListModel
                                                                  ?.data?[index]
                                                                  .itemId,
                                                          'user_id': userData
                                                                  ?.data?.uId ??
                                                              '',
                                                          'qty': '1',
                                                          'price': cartListModel
                                                              ?.data?[index]
                                                              .pricePerGlass,
                                                          'price_type': 'glass',
                                                          'cart_action': 'plus'
                                                        };
                                                        addToCart(map);
                                                      },
                                                      child: const Text(
                                                        '+',
                                                        style: TextStyle(
                                                            color: Colors.blue),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          (cartListModel
                                                      ?.data?[index].totalPrice
                                                      .toString() ??
                                                  '') +
                                              ' £',
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(
                            'Sub Total:-',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp),
                          ),
                        ),
                        SizedBox(
                          width: 1.0.h,
                        ),
                        SizedBox(
                          child: Text(
                            (cartListModel?.subtotal.toString() ?? '') + '£',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
                      alignment: Alignment.bottomCenter,
                      child: buttonWidget(
                        color: const Color(0xFFB41712),
                        callback: () async {
                          FocusScope.of(context).unfocus();
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CardDetailsScreen(
                                  price:
                                      cartListModel?.subtotal.toString() ?? '',
                                ),
                              ));
                        },
                        text: 'Checkout & Pay Now',
                      ),
                    ),
                  ],
                ),
        ),
      ),
      isLoading: isLoading,
    );
  }

  addToCart(body) {
    checkInternet().then((internet) async {
      if (internet) {
        CartProviders().addToCartAPi(body).then((Response response) async {
          BaseModel baseModel = BaseModel.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && baseModel.status == 1) {
            updateCartItems(context);

            setState(() {
              isLoading = false;
            });
            getCartList();
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
            getCartList();
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

  getCartList() {
    setState(() {
      isLoading = true;
    });

    checkInternet().then(
      (internet) async {
        if (internet) {
          CartProviders().cartListAPi().then(
            (Response response) async {
              cartListModel =
                  CartListModel.fromJson(json.decode(response.body));

              if (response.statusCode == 200 && cartListModel?.status == 1) {
                setState(() {
                  isLoading = false;
                });
              } else {
                setState(() {
                  isLoading = false;
                });
              }
            },
          ).catchError((onError) {
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
      },
    );
  }

  placeOrder() {}
}
