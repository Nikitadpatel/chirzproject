/// id : "129"
/// user_id : "142"
/// category_id : null
/// item_name : "sadffa"
/// type_of_grape : "NA"
/// item_type : "NA"
/// year : "0"
/// region : "NA"
/// price_per_glass : "NA"
/// price_per_bott : "NA"
/// item_image : "http://portal.chirz.co.uk/img/items_images/1648800657b.jpg"
/// alcohol_percentage : "0"
/// price_per_cocktail : "34"
/// about_wine : "how are you?"
/// is_cocktail : "1"
/// is_active : "1"
/// is_delete : "0"
/// created_date : "2022-04-01 08:10:57"
/// updated_date : null

class Data1 {
  Data1({
    dynamic id,
    dynamic userId,
    dynamic categoryId,
    dynamic itemName,
    dynamic typeOfGrape,
    dynamic itemType,
    dynamic year,
    dynamic region,
    dynamic pricePerGlass,
    dynamic pricePerBott,
    dynamic itemImage,
    dynamic alcoholPercentage,
    dynamic pricePerCocktail,
    dynamic aboutWine,
    dynamic isCocktail,
    dynamic isActive,
    dynamic isDelete,
    dynamic createdDate,
    dynamic updatedDate,
  }) {
    _id = id;
    _userId = userId;
    _categoryId = categoryId;
    _itemName = itemName;
    _typeOfGrape = typeOfGrape;
    _itemType = itemType;
    _year = year;
    _region = region;
    _pricePerGlass = pricePerGlass;
    _pricePerBott = pricePerBott;
    _itemImage = itemImage;
    _alcoholPercentage = alcoholPercentage;
    _pricePerCocktail = pricePerCocktail;
    _aboutWine = aboutWine;
    _isCocktail = isCocktail;
    _isActive = isActive;
    _isDelete = isDelete;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
  }

  Data1.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _categoryId = json['category_id'];
    _itemName = json['item_name'];
    _typeOfGrape = json['type_of_grape'];
    _itemType = json['item_type'];
    _year = json['year'];
    _region = json['region'];
    _pricePerGlass = json['price_per_glass'];
    _pricePerBott = json['price_per_bott'];
    _itemImage = json['item_image'];
    _alcoholPercentage = json['alcohol_percentage'];
    _pricePerCocktail = json['price_per_cocktail'];
    _aboutWine = json['about_wine'];
    _isCocktail = json['is_cocktail'];
    _isActive = json['is_active'];
    _isDelete = json['is_delete'];
    _createdDate = json['created_date'];
    _updatedDate = json['updated_date'];
  }

  dynamic _id;
  dynamic _userId;
  dynamic _categoryId;
  dynamic _itemName;
  dynamic _typeOfGrape;
  dynamic _itemType;
  dynamic _year;
  dynamic _region;
  dynamic _pricePerGlass;
  dynamic _pricePerBott;
  dynamic _itemImage;
  dynamic _alcoholPercentage;
  dynamic _pricePerCocktail;
  dynamic _aboutWine;
  dynamic _isCocktail;
  dynamic _isActive;
  dynamic _isDelete;
  dynamic _createdDate;
  dynamic _updatedDate;

  dynamic get id => _id;

  dynamic get userId => _userId;

  dynamic get categoryId => _categoryId;

  dynamic get itemName => _itemName;

  dynamic get typeOfGrape => _typeOfGrape;

  dynamic get itemType => _itemType;

  dynamic get year => _year;

  dynamic get region => _region;

  dynamic get pricePerGlass => _pricePerGlass;

  dynamic get pricePerBott => _pricePerBott;

  dynamic get itemImage => _itemImage;

  dynamic get alcoholPercentage => _alcoholPercentage;

  dynamic get pricePerCocktail => _pricePerCocktail;

  dynamic get aboutWine => _aboutWine;

  dynamic get isCocktail => _isCocktail;

  dynamic get isActive => _isActive;

  dynamic get isDelete => _isDelete;

  dynamic get createdDate => _createdDate;

  dynamic get updatedDate => _updatedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['category_id'] = _categoryId;
    map['item_name'] = _itemName;
    map['type_of_grape'] = _typeOfGrape;
    map['item_type'] = _itemType;
    map['year'] = _year;
    map['region'] = _region;
    map['price_per_glass'] = _pricePerGlass;
    map['price_per_bott'] = _pricePerBott;
    map['item_image'] = _itemImage;
    map['alcohol_percentage'] = _alcoholPercentage;
    map['price_per_cocktail'] = _pricePerCocktail;
    map['about_wine'] = _aboutWine;
    map['is_cocktail'] = _isCocktail;
    map['is_active'] = _isActive;
    map['is_delete'] = _isDelete;
    map['created_date'] = _createdDate;
    map['updated_date'] = _updatedDate;
    return map;
  }
}
