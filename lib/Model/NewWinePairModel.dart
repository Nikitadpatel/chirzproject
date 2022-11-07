// /// status : 1


class NwWinePairModel {
  int? status;
  String? message;
  List<Data>? data;

  NwWinePairModel({this.status, this.message, this.data});

  NwWinePairModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? menuName;
  int? count;
  String? menuImg;
  List<Food>? food;
  List<Wine>? wine;

  Data({this.menuName, this.count, this.menuImg, this.food, this.wine});

  Data.fromJson(Map<String, dynamic> json) {
    menuName = json['menu_name'];
    count = json['count'];
    menuImg = json['menu_img'];
    if (json['food'] != null) {
      food = <Food>[];
      json['food'].forEach((v) {
        food!.add(new Food.fromJson(v));
      });
    }
    if (json['wine'] != null) {
      wine = <Wine>[];
      json['wine'].forEach((v) {
        wine!.add(new Wine.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_name'] = this.menuName;
    data['count'] = this.count;
    data['menu_img'] = this.menuImg;
    if (this.food != null) {
      data['food'] = this.food!.map((v) => v.toJson()).toList();
    }
    if (this.wine != null) {
      data['wine'] = this.wine!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Food {
  String? pairId;
  String? foodName;
  String? image;
  String? price;
  String? description;
  String? id;
  String? userId;
  Null? categoryId;
  String? itemName;
  String? typeOfGrape;
  String? itemType;
  String? year;
  String? region;
  String? pricePerGlass;
  String? pricePerBott;
  String? binNo;
  String? itemImage;
  String? alcoholPercentage;
  String? pricePerCocktail;
  String? aboutWine;
  String? isCocktail;
  String? isActive;
  String? isDelete;
  String? createdDate;
  Null? updatedDate;

  Food(
      {this.pairId,
        this.foodName,
        this.image,
        this.price,
        this.description,
        this.id,
        this.userId,
        this.categoryId,
        this.itemName,
        this.typeOfGrape,
        this.itemType,
        this.year,
        this.region,
        this.pricePerGlass,
        this.pricePerBott,
        this.binNo,
        this.itemImage,
        this.alcoholPercentage,
        this.pricePerCocktail,
        this.aboutWine,
        this.isCocktail,
        this.isActive,
        this.isDelete,
        this.createdDate,
        this.updatedDate});

  Food.fromJson(Map<String, dynamic> json) {
    pairId = json['pair_id'];
    foodName = json['food_name'];
    image = json['image'];
    price = json['price'];
    description = json['description'];
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    itemName = json['item_name'];
    typeOfGrape = json['type_of_grape'];
    itemType = json['item_type'];
    year = json['year'];
    region = json['region'];
    pricePerGlass = json['price_per_glass'];
    pricePerBott = json['price_per_bott'];
    binNo = json['bin_no'];
    itemImage = json['item_image'];
    alcoholPercentage = json['alcohol_percentage'];
    pricePerCocktail = json['price_per_cocktail'];
    aboutWine = json['about_wine'];
    isCocktail = json['is_cocktail'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pair_id'] = this.pairId;
    data['food_name'] = this.foodName;
    data['image'] = this.image;
    data['price'] = this.price;
    data['description'] = this.description;
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['item_name'] = this.itemName;
    data['type_of_grape'] = this.typeOfGrape;
    data['item_type'] = this.itemType;
    data['year'] = this.year;
    data['region'] = this.region;
    data['price_per_glass'] = this.pricePerGlass;
    data['price_per_bott'] = this.pricePerBott;
    data['bin_no'] = this.binNo;
    data['item_image'] = this.itemImage;
    data['alcohol_percentage'] = this.alcoholPercentage;
    data['price_per_cocktail'] = this.pricePerCocktail;
    data['about_wine'] = this.aboutWine;
    data['is_cocktail'] = this.isCocktail;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    return data;
  }
}

class Wine {
  String? id;
  String? userId;
  Null? categoryId;
  String? itemName;
  String? typeOfGrape;
  String? itemType;
  String? year;
  String? region;
  String? pricePerGlass;
  String? pricePerBott;
  String? binNo;
  String? itemImage;
  String? alcoholPercentage;
  String? pricePerCocktail;
  String? aboutWine;
  String? isCocktail;
  String? isActive;
  String? isDelete;
  String? createdDate;
  Null? updatedDate;

  Wine(
      {this.id,
        this.userId,
        this.categoryId,
        this.itemName,
        this.typeOfGrape,
        this.itemType,
        this.year,
        this.region,
        this.pricePerGlass,
        this.pricePerBott,
        this.binNo,
        this.itemImage,
        this.alcoholPercentage,
        this.pricePerCocktail,
        this.aboutWine,
        this.isCocktail,
        this.isActive,
        this.isDelete,
        this.createdDate,
        this.updatedDate});

  Wine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    itemName = json['item_name'];
    typeOfGrape = json['type_of_grape'];
    itemType = json['item_type'];
    year = json['year'];
    region = json['region'];
    pricePerGlass = json['price_per_glass'];
    pricePerBott = json['price_per_bott'];
    binNo = json['bin_no'];
    itemImage = json['item_image'];
    alcoholPercentage = json['alcohol_percentage'];
    pricePerCocktail = json['price_per_cocktail'];
    aboutWine = json['about_wine'];
    isCocktail = json['is_cocktail'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['item_name'] = this.itemName;
    data['type_of_grape'] = this.typeOfGrape;
    data['item_type'] = this.itemType;
    data['year'] = this.year;
    data['region'] = this.region;
    data['price_per_glass'] = this.pricePerGlass;
    data['price_per_bott'] = this.pricePerBott;
    data['bin_no'] = this.binNo;
    data['item_image'] = this.itemImage;
    data['alcohol_percentage'] = this.alcoholPercentage;
    data['price_per_cocktail'] = this.pricePerCocktail;
    data['about_wine'] = this.aboutWine;
    data['is_cocktail'] = this.isCocktail;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    return data;
  }
}