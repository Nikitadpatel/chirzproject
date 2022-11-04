/// status : 1
/// message : "Wine list"
/// data : [{"id":"1","user_id":"22","category_id":"10","item_name":"desert","type_of_grape":"3","item_type":"cold drink","year":"2020","region":"hindu","price_per_glass":"150","price_per_bott":"30","item_image":"https://restapp.fableadtechnolabs.com/img/items_images/1621525760Tulips.jpg","about_wine":null,"is_active":"0","is_delete":"1","created_date":"2021-12-18 12:08:25","updated_date":"0000-00-00 00:00:00"},{"id":"2","user_id":"114","category_id":"12","item_name":"toast","type_of_grape":"4","item_type":"fast  food","year":"2019","region":"hindu","price_per_glass":"230","price_per_bott":"126","item_image":"https://restapp.fableadtechnolabs.com/img/items_images/","about_wine":null,"is_active":"1","is_delete":"1","created_date":"2022-01-03 17:53:49","updated_date":"0000-00-00 00:00:00"},{"id":"9","user_id":"116","category_id":"15","item_name":"pears","type_of_grape":"green","item_type":"red","year":"2021","region":"gujarat","price_per_glass":"50","price_per_bott":"500","item_image":"https://restapp.fableadtechnolabs.com/img/items_images/16393818591639139144600x200.jpg","about_wine":null,"is_active":"1","is_delete":"0","created_date":"2021-12-17 11:14:08","updated_date":"0000-00-00 00:00:00"}]

class WineListModel {
  WineListModel({
      int? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  WineListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  int? _status;
  String? _message;
  List<Data>? _data;

  int? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// user_id : "22"
/// category_id : "10"
/// item_name : "desert"
/// type_of_grape : "3"
/// item_type : "cold drink"
/// year : "2020"
/// region : "hindu"
/// price_per_glass : "150"
/// price_per_bott : "30"
/// item_image : "https://restapp.fableadtechnolabs.com/img/items_images/1621525760Tulips.jpg"
/// about_wine : null
/// is_active : "0"
/// is_delete : "1"
/// created_date : "2021-12-18 12:08:25"
/// updated_date : "0000-00-00 00:00:00"

class Data {
  Data({
      String? id, 
      String? userId, 
      String? categoryId, 
      String? itemName, 
      String? typeOfGrape, 
      String? itemType, 
      String? year, 
      String? region, 
      String? pricePerGlass, 
      String? pricePerBott, 
      String? pricePeCocktail,
      String? itemImage,
      dynamic aboutWine, 
      String? isActive, 
      String? isDelete, 
      String? createdDate,
      String? updatedDate,}){
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
    _aboutWine = aboutWine;
    _isActive = isActive;
    _isDelete = isDelete;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _pricePeCocktail = pricePeCocktail;
}

  Data.fromJson(dynamic json) {
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
    _aboutWine = json['about_wine'];
    _isActive = json['is_active'];
    _isDelete = json['is_delete'];
    _createdDate = json['created_date'];
    _updatedDate = json['updated_date'];
    _pricePeCocktail = json['price_per_cocktail'];
  }
  String? _id;
  String? _userId;
  String? _categoryId;
  String? _itemName;
  String? _typeOfGrape;
  String? _itemType;
  String? _year;
  String? _region;
  String? _pricePerGlass;
  String? _pricePerBott;
  String? _itemImage;
  dynamic _aboutWine;
  String? _isActive;
  String? _isDelete;
  String? _createdDate;
  String? _updatedDate;
  String? _pricePeCocktail;

  String? get id => _id;
  String? get userId => _userId;
  String? get categoryId => _categoryId;
  String? get itemName => _itemName;
  String? get typeOfGrape => _typeOfGrape;
  String? get itemType => _itemType;
  String? get year => _year;
  String? get region => _region;
  String? get pricePerGlass => _pricePerGlass;
  String? get pricePerBott => _pricePerBott;
  String? get itemImage => _itemImage;
  dynamic get aboutWine => _aboutWine;
  String? get isActive => _isActive;
  String? get isDelete => _isDelete;
  String? get createdDate => _createdDate;
  String? get updatedDate => _updatedDate;
  String? get pricePeCocktail => _pricePeCocktail;

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
    map['about_wine'] = _aboutWine;
    map['is_active'] = _isActive;
    map['is_delete'] = _isDelete;
    map['created_date'] = _createdDate;
    map['updated_date'] = _updatedDate;
    map['price_per_cocktail'] = _pricePeCocktail;
    return map;
  }

}