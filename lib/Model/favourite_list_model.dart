/// status : 1
/// message : "favourite list"
/// data : [{"user_id":"143","item_id":"30","username":"jas","item_name":"Red Wine Vinegar","item_type":"vegetarians","item_image":"/home/dummyin2/restapp.fableadtechnolabs.com/admin/apiimg/items_images/164120552361ihrUHqC7L._SL1500_.jpg","is_favourite":"1","type_of_grape":"Dolce Vita","price_per_glass":"70","price_per_bottle":"255","comment":"lorem ipsum","Date":"2022-01-04 10:29:56"}]

class FavouriteListModel {
  FavouriteListModel({
      int? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  FavouriteListModel.fromJson(dynamic json) {
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

/// user_id : "143"
/// item_id : "30"
/// username : "jas"
/// item_name : "Red Wine Vinegar"
/// item_type : "vegetarians"
/// item_image : "/home/dummyin2/restapp.fableadtechnolabs.com/admin/apiimg/items_images/164120552361ihrUHqC7L._SL1500_.jpg"
/// is_favourite : "1"
/// type_of_grape : "Dolce Vita"
/// price_per_glass : "70"
/// price_per_bottle : "255"
/// comment : "lorem ipsum"
/// Date : "2022-01-04 10:29:56"

class Data {
  Data({
      String? userId, 
      String? itemId, 
      String? username, 
      String? itemName, 
      String? itemType, 
      String? itemImage, 
      String? isFavourite, 
      String? typeOfGrape, 
      String? pricePerGlass, 
      String? pricePerBottle, 
      String? comment, 
      String? date,}){
    _userId = userId;
    _itemId = itemId;
    _username = username;
    _itemName = itemName;
    _itemType = itemType;
    _itemImage = itemImage;
    _isFavourite = isFavourite;
    _typeOfGrape = typeOfGrape;
    _pricePerGlass = pricePerGlass;
    _pricePerBottle = pricePerBottle;
    _comment = comment;
    _date = date;
}

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _itemId = json['item_id'];
    _username = json['username'];
    _itemName = json['item_name'];
    _itemType = json['item_type'];
    _itemImage = json['item_image'];
    _isFavourite = json['is_favourite'];
    _typeOfGrape = json['type_of_grape'];
    _pricePerGlass = json['price_per_glass'];
    _pricePerBottle = json['price_per_bottle'];
    _comment = json['comment'];
    _date = json['Date'];
  }
  String? _userId;
  String? _itemId;
  String? _username;
  String? _itemName;
  String? _itemType;
  String? _itemImage;
  String? _isFavourite;
  String? _typeOfGrape;
  String? _pricePerGlass;
  String? _pricePerBottle;
  String? _comment;
  String? _date;

  String? get userId => _userId;
  String? get itemId => _itemId;
  String? get username => _username;
  String? get itemName => _itemName;
  String? get itemType => _itemType;
  String? get itemImage => _itemImage;
  String? get isFavourite => _isFavourite;
  String? get typeOfGrape => _typeOfGrape;
  String? get pricePerGlass => _pricePerGlass;
  String? get pricePerBottle => _pricePerBottle;
  String? get comment => _comment;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['item_id'] = _itemId;
    map['username'] = _username;
    map['item_name'] = _itemName;
    map['item_type'] = _itemType;
    map['item_image'] = _itemImage;
    map['is_favourite'] = _isFavourite;
    map['type_of_grape'] = _typeOfGrape;
    map['price_per_glass'] = _pricePerGlass;
    map['price_per_bottle'] = _pricePerBottle;
    map['comment'] = _comment;
    map['Date'] = _date;
    return map;
  }

}