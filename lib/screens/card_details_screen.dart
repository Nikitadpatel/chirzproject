import 'dart:convert';
import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chirz/Model/base_model.dart';
import 'package:chirz/Model/checkout_model.dart';
import 'package:chirz/providers/cart-provider.dart';
import 'package:chirz/providers/order_provider.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:math' as math;
import 'package:sizer/sizer.dart';
import 'final_order_screen.dart';
import 'item-details-screen.dart';

class CardDetailsScreen extends StatefulWidget {
  final String price;
  const CardDetailsScreen({Key? key, required this.price}) : super(key: key);

  @override
  _CardDetailsScreenState createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  bool showBack = false;

  late FocusNode _focusNode;
  TextEditingController cardNumberCtrl = TextEditingController();
  TextEditingController expiryFieldCtrl = TextEditingController();
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  CheckoutModel? checkoutModel;

  @override
  void initState() {
    getCheckoutsDetails();
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return commanScreen(
      scaffold: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFB41712),
          title: Text(
            checkoutModel?.data?.restaurantname ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: isLoading
            ? Container()
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 3.h),
                      child: Text(
                        'Restaurant Details',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.h, vertical: 3.h),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      margin:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
                      child: Column(
                        children: [
                          restaurentDetails('Restaurant Name',
                              checkoutModel?.data?.restaurantname ?? ''),
                          restaurentDetails('Restaurant Email',
                              checkoutModel?.data?.email ?? ''),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 3.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Item Details',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 1.h),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: checkoutModel == null
                                  ? 0
                                  : checkoutModel?.data?.itemData?.length ?? 0,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ItemDetailsScreen(
                                            wineId: checkoutModel
                                                ?.data?.itemData?[index].itemId,
                                          ),
                                        ));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(
                                      vertical: 2.h,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          child: CachedNetworkImage(
                                            imageUrl: checkoutModel
                                                    ?.data
                                                    ?.itemData?[index]
                                                    .itemImage ??
                                                '',
                                            alignment: Alignment.center,
                                          ),
                                          height: 80,
                                          width: 80,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.8,
                                          child: Text(
                                            (checkoutModel
                                                        ?.data
                                                        ?.itemData?[index]
                                                        .itemName ??
                                                    '')
                                                .toString()
                                                .trim(),
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  const Text(
                                                    'qty:- ',
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2.5.w),
                                                    child: Text(
                                                      checkoutModel
                                                              ?.data
                                                              ?.itemData?[index]
                                                              .qty
                                                              .toString() ??
                                                          '',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  (checkoutModel
                                                              ?.data
                                                              ?.itemData?[index]
                                                              .totalPrice
                                                              .toString() ??
                                                          '') +
                                                      ' £',
                                                  textAlign: TextAlign.end,
                                                ),
                                              )
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 3.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
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
                              (widget.price) + '£',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CreditCard(
                      cardNumber: cardNumber,
                      cardExpiry: expiryDate,
                      cardHolderName: cardHolderName,
                      cvv: cvv,
                      bankName: '',
                      showBackSide: showBack,
                      frontBackground: CardBackgrounds.custom(0xFFB41712),
                      backBackground: CardBackgrounds.custom(0xFFB41712),
                      showShadow: true,

                      // mask: getCardTypeMask(cardType: CardType.americanExpress),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please Enter Card Holder Name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: 'Card Holder Name'),
                              onChanged: (value) {
                                setState(() {
                                  cardHolderName = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: TextFormField(
                              controller: cardNumberCtrl,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: 'Card Number',
                                  counter: Container()),
                              maxLength: 16,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please Enter card number';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                final newCardNumber = value.trim();
                                var newStr = '';
                                const step = 4;

                                for (var i = 0;
                                    i < newCardNumber.length;
                                    i += step) {
                                  newStr += newCardNumber.substring(i,
                                      math.min(i + step, newCardNumber.length));
                                  if (i + step < newCardNumber.length) {
                                    newStr += ' ';
                                  }
                                }
                                setState(() {
                                  cardNumber = newStr;
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: TextFormField(
                              controller: expiryFieldCtrl,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: 'Card Expiry',
                                  counter: Container()),
                              maxLength: 5,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please Enter Card Expiry Date';
                                } else if (!(value?.contains('/') ?? true)) {
                                  return 'Please Valid Expiry Date';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                var newDateValue = value.trim();
                                final isPressingBackspace =
                                    expiryDate.length > newDateValue.length;
                                final containsSlash =
                                    newDateValue.contains('/');

                                if (newDateValue.length >= 2 &&
                                    !containsSlash &&
                                    !isPressingBackspace) {
                                  newDateValue = newDateValue.substring(0, 2) +
                                      '/' +
                                      newDateValue.substring(2);
                                }
                                setState(() {
                                  expiryFieldCtrl.text = newDateValue;
                                  expiryFieldCtrl.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: newDateValue.length));
                                  expiryDate = newDateValue;
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'CVV', counter: Container()),
                              keyboardType: TextInputType.number,
                              maxLength: 3,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please Enter CVV';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  cvv = value;
                                });
                              },
                              focusNode: _focusNode,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
                      alignment: Alignment.bottomCenter,
                      child: buttonWidget(
                        color: const Color(0xFFB41712),
                        callback: () async {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            placeOrder({
                              'action': 'place_order',
                              'payment_type': 'stripe',
                              'user_id': userData?.data?.uId ?? '',
                              'note': '20% off',
                              'price': widget.price,
                              'card_number': cardNumber,
                              'cvc': cvv,
                              'exp_month': expiryDate.split('/').first,
                              'exp_year': expiryDate.split('/').last,
                              'address': '',
                            });
                          }
                        },
                        text: 'Place Order',
                      ),
                    ),
                  ],
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

  placeOrder(body) {
    setState(() {
      isLoading = true;
    });
    checkInternet().then((internet) async {
      if (internet) {
        OrdersProviders().placeOrder(body).then((Response response) async {
          BaseModel baseModel = BaseModel.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && baseModel.status == 1) {
            setState(() {
              isLoading = false;
            });
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderSuccessFullyScreen(),
                  fullscreenDialog: true,
                ),
                (route) => false);
          } else {
            setState(() {
              isLoading = false;
            });
            buildErrorDialog(
                context, '', json.decode(response.body)['message'].toString());
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

  getCheckoutsDetails() {
    CartProviders().checkoutAPi().then((Response response) async {
      checkoutModel = CheckoutModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200 && checkoutModel?.status == 1) {
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        buildErrorDialog(context, '', checkoutModel?.message.toString() ?? '');
      }
    }).catchError((onError) {
      setState(() {
        isLoading = false;
      });
      print(onError.toString());
      buildErrorDialog(context, 'Error', 'Something went wrong');
    });
  }
}
