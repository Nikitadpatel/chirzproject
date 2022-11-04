/// status : 1
/// Subtotal : 1275
/// message : "Show cart detail"
/// data : [{"item_id":"34","item_name":"jachos creek","qty":"2","price":"255","note":"20%of","type_of_grape":"dfdf","item_type":"jachos","price_per_glass":"90","price_per_bottle":"180","price_type":null,"item_image":"http://restapp.fableadtechnolabs.com/img/items_images/1641289106pexels-photo-2912108.jpeg","total_price":510},{"item_id":"31","item_name":"Red Wine Vinegar","qty":"2","price":"255","note":"20%of","type_of_grape":"Dolce Vita","item_type":"vegetarians","price_per_glass":"70","price_per_bottle":"255","price_type":null,"item_image":"http://restapp.fableadtechnolabs.com/img/items_images/164120552361ihrUHqC7L._SL1500_.jpg","total_price":510},{"item_id":"32","item_name":"Red wine","qty":"1","price":"255","note":"","type_of_grape":"wine","item_type":"Red","price_per_glass":"70","price_per_bottle":"100","price_type":null,"item_image":"http://restapp.fableadtechnolabs.com/img/items_images/164128883024b34033caeeeb29f40fa8efff634e8b.jpg","total_price":255}]

class CartListModel {
  CartListModel({
      int? status, 
      int? subtotal, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _subtotal = subtotal;
    _message = message;
    _data = data;
}

  CartListModel.fromJson(dynamic json) {
    _status = json['status'];
    _subtotal = json['Subtotal'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  int? _status;
  int? _subtotal;
  String? _message;
  List<Data>? _data;

  int? get status => _status;
  int? get subtotal => _subtotal;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['Subtotal'] = _subtotal;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// item_id : "34"
/// item_name : "jachos creek"
/// qty : "2"
/// price : "255"
/// note : "20%of"
/// type_of_grape : "dfdf"
/// item_type : "jachos"
/// price_per_glass : "90"
/// price_per_bottle : "180"
/// price_type : null
/// item_image : "http://restapp.fableadtechnolabs.com/img/items_images/1641289106pexels-photo-2912108.jpeg"
/// total_price : 510

class Data {
  Data({
      String? itemId, 
      String? itemName, 
      String? qty, 
      String? price, 
      String? note, 
      String? typeOfGrape, 
      String? itemType, 
      String? pricePerGlass, 
      String? pricePerBottle, 
      dynamic priceType, 
      String? itemImage, 
      int? totalPrice,}){
    _itemId = itemId;
    _itemName = itemName;
    _qty = qty;
    _price = price;
    _note = note;
    _typeOfGrape = typeOfGrape;
    _itemType = itemType;
    _pricePerGlass = pricePerGlass;
    _pricePerBottle = pricePerBottle;
    _priceType = priceType;
    _itemImage = itemImage;
    _totalPrice = totalPrice;
}

  Data.fromJson(dynamic json) {
    _itemId = json['item_id'];
    _itemName = json['item_name'];
    _qty = json['qty'];
    _price = json['price'];
    _note = json['note'];
    _typeOfGrape = json['type_of_grape'];
    _itemType = json['item_type'];
    _pricePerGlass = json['price_per_glass'];
    _pricePerBottle = json['price_per_bottle'];
    _priceType = json['price_type'];
    _itemImage = json['item_image'];
    _totalPrice = json['total_price'];
  }
  String? _itemId;
  String? _itemName;
  String? _qty;
  String? _price;
  String? _note;
  String? _typeOfGrape;
  String? _itemType;
  String? _pricePerGlass;
  String? _pricePerBottle;
  dynamic _priceType;
  String? _itemImage;
  int? _totalPrice;

  String? get itemId => _itemId;
  String? get itemName => _itemName;
  String? get qty => _qty;
  String? get price => _price;
  String? get note => _note;
  String? get typeOfGrape => _typeOfGrape;
  String? get itemType => _itemType;
  String? get pricePerGlass => _pricePerGlass;
  String? get pricePerBottle => _pricePerBottle;
  dynamic get priceType => _priceType;
  String? get itemImage => _itemImage;
  int? get totalPrice => _totalPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['item_id'] = _itemId;
    map['item_name'] = _itemName;
    map['qty'] = _qty;
    map['price'] = _price;
    map['note'] = _note;
    map['type_of_grape'] = _typeOfGrape;
    map['item_type'] = _itemType;
    map['price_per_glass'] = _pricePerGlass;
    map['price_per_bottle'] = _pricePerBottle;
    map['price_type'] = _priceType;
    map['item_image'] = _itemImage;
    map['total_price'] = _totalPrice;
    return map;
  }

}