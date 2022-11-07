import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chirz/Model/WineCockTailModel.dart';
import 'package:chirz/main.dart';
import 'package:chirz/providers/food_providers.dart';
import 'package:chirz/utils/const.dart';
import 'package:chirz/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import '../res.dart';
import 'item-details-screen.dart';

class CocktailOrWineScreen extends StatefulWidget {
  final bool isCocktail;
  final dynamic restaurantId;

  const CocktailOrWineScreen(
      {Key? key, required this.isCocktail, this.restaurantId})
      : super(key: key);

  @override
  State<CocktailOrWineScreen> createState() => _CocktailOrWineScreenState();
}

class _CocktailOrWineScreenState extends State<CocktailOrWineScreen> {
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  WineCockTailModel? wineCockTailModel;

  @override
  void initState() {
    groupValue = -1;
    setState(() {});
    getList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return commanScreen(
      scaffold: Scaffold(
        key: _scaffoldKey,
        drawer: drawerWidgets(context),
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
                Icons.arrow_back_sharp,
                color: Colors.black,
              ),
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
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            widget.isCocktail ? 'Cocktails' : 'Wines',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: SizedBox(
          child: ListView.builder(
            itemCount: wineCockTailModel?.data1?.length ?? 0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (widget.isCocktail) {
                    groupValue = 2;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetailsScreen(
                            wineId: wineCockTailModel?.data1?[index].id,
                          ),
                        ));
                  } else {
                    if (groupValue == -1) {
                      buildErrorDialog(context, '', 'Please select wine type');
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemDetailsScreen(
                                wineId: wineCockTailModel?.data1?[index].id),
                          ));
                    }
                  }
                },
                child: widget.isCocktail
                    ? Container(
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
                                  Res.cocktail,
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
                                  wineCockTailModel?.data1?[index].itemName ??
                                      '',
                                  maxLines: 1,
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
                      )
                    : Container(
                        height: 12.h,
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
                                height: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: wineCockTailModel
                                          ?.data1?[index].itemImage ??
                                      '',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.sp),
                                      ),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: Colors.grey,
                                    child: Image.asset(Res.bottle),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                margin: EdgeInsets.only(left: 1.5.h),
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      wineCockTailModel
                                              ?.data1?[index].itemName ??
                                          '',
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.sp,
                                        fontFamily: fontFamily,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() => groupValue = 0);
                                            await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ItemDetailsScreen(
                                                          wineId:
                                                              wineCockTailModel
                                                                  ?.data1?[
                                                                      index]
                                                                  .id),
                                                ));
                                            groupValue = -1;
                                            setState(() {});
                                          },
                                          child: SizedBox(
                                            child: Image.asset(
                                              Res.glass,
                                              width: 20,
                                              height: 20,
                                              color: groupValue != 0
                                                  ? null
                                                  : Colors.red,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() => groupValue = 1);
                                            await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ItemDetailsScreen(
                                                          wineId:
                                                              wineCockTailModel
                                                                  ?.data1?[
                                                                      index]
                                                                  .id),
                                                ));
                                            groupValue = -1;
                                            setState(() {});
                                          },
                                          child: SizedBox(
                                            child: Image.asset(
                                              Res.bottle,
                                              width: 20,
                                              height: 20,
                                              color: groupValue != 1
                                                  ? null
                                                  : Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
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

  getList() {
    checkInternet().then((internet) async {
      if (internet) {
        FoodItemsProviders()
            .getWinesOrCockTails(
                widget.isCocktail, widget.restaurantId.toString())
            .then((Response response) async {
          wineCockTailModel =
              WineCockTailModel.fromJson(json.decode(response.body));

          if (response.statusCode == 200 && wineCockTailModel?.status == 1) {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            buildErrorDialog(
                context, '', wineCockTailModel?.message.toString() ?? '');
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
