/// status : 1
/// Subtotal : 640
/// date_and_time : "2022-02-09 15:14:33"
/// message : "Show cart detail"
/// data : {"Restaurant_id":"142","Restaurantname":"Le Pain Quotidien","Email":"testnew@gmail.com","Phonenumber":"5646545644","role":"Restaurant","location":"surat","Zipcode":"395004","state":"Gujarat","country":"india","Image":"http://restapp.fableadtechnolabs.com/img/profile_images/1642571960saurav-mahto-_q28qN7J7Sg-unsplash.jpg","Description":"test","Date":"2022-01-19 11:29:20","item_data":[{"item_id":"61","item_name":"DOMAINE CARNEROS BY TAITTINGER BRUT CUVÉE 2014","qty":"1","price":"240","note":"","type_of_grape":"DOMAINE CARNEROS BY TAITTINGER BRUT","item_type":"TAITTINGER BRUT CUVÉE 2014","price_per_glass":"240","price_per_bottle":"500","price_type":"glass","item_image":"http://restapp.fableadtechnolabs.com/img/items_images/1642498041Wine19.jpg","total_price":240},{"item_id":"51","item_name":"TABLAS CREEK VINEYARD ESPRIT DE TABLAS BLANC 2015","qty":"2","price":"200","note":"","type_of_grape":"TABLAS CREEK VINEYARD","item_type":"ESPRIT DE TABLAS BLANC 2015","price_per_glass":"200","price_per_bottle":"400","price_type":"glass","item_image":"http://restapp.fableadtechnolabs.com/img/items_images/1642493661Wine5.jpg","total_price":400}]}

class CheckoutModel {
  CheckoutModel({
      dynamic status, 
      dynamic subtotal, 
      dynamic dateAndTime, 
      dynamic message, 
      Data? data,}){
    _status = status;
    _subtotal = subtotal;
    _dateAndTime = dateAndTime;
    _message = message;
    _data = data;
}

  CheckoutModel.fromJson(dynamic json) {
    _status = json['status'];
    _subtotal = json['Subtotal'];
    _dateAndTime = json['date_and_time'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  dynamic _status;
  dynamic _subtotal;
  dynamic _dateAndTime;
  dynamic _message;
  Data? _data;

  dynamic get status => _status;
  dynamic get subtotal => _subtotal;
  dynamic get dateAndTime => _dateAndTime;
  dynamic get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['Subtotal'] = _subtotal;
    map['date_and_time'] = _dateAndTime;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// Restaurant_id : "142"
/// Restaurantname : "Le Pain Quotidien"
/// Email : "testnew@gmail.com"
/// Phonenumber : "5646545644"
/// role : "Restaurant"
/// location : "surat"
/// Zipcode : "395004"
/// state : "Gujarat"
/// country : "india"
/// Image : "http://restapp.fableadtechnolabs.com/img/profile_images/1642571960saurav-mahto-_q28qN7J7Sg-unsplash.jpg"
/// Description : "test"
/// Date : "2022-01-19 11:29:20"
/// item_data : [{"item_id":"61","item_name":"DOMAINE CARNEROS BY TAITTINGER BRUT CUVÉE 2014","qty":"1","price":"240","note":"","type_of_grape":"DOMAINE CARNEROS BY TAITTINGER BRUT","item_type":"TAITTINGER BRUT CUVÉE 2014","price_per_glass":"240","price_per_bottle":"500","price_type":"glass","item_image":"http://restapp.fableadtechnolabs.com/img/items_images/1642498041Wine19.jpg","total_price":240},{"item_id":"51","item_name":"TABLAS CREEK VINEYARD ESPRIT DE TABLAS BLANC 2015","qty":"2","price":"200","note":"","type_of_grape":"TABLAS CREEK VINEYARD","item_type":"ESPRIT DE TABLAS BLANC 2015","price_per_glass":"200","price_per_bottle":"400","price_type":"glass","item_image":"http://restapp.fableadtechnolabs.com/img/items_images/1642493661Wine5.jpg","total_price":400}]

class Data {
  Data({
      dynamic restaurantId, 
      dynamic restaurantname, 
      dynamic email, 
      dynamic phonenumber, 
      dynamic role, 
      dynamic location, 
      dynamic zipcode, 
      dynamic state, 
      dynamic country, 
      dynamic image, 
      dynamic description, 
      dynamic date, 
      List<Item_data>? itemData,}){
    _restaurantId = restaurantId;
    _restaurantname = restaurantname;
    _email = email;
    _phonenumber = phonenumber;
    _role = role;
    _location = location;
    _zipcode = zipcode;
    _state = state;
    _country = country;
    _image = image;
    _description = description;
    _date = date;
    _itemData = itemData;
}

  Data.fromJson(dynamic json) {
    _restaurantId = json['Restaurant_id'];
    _restaurantname = json['Restaurantname'];
    _email = json['Email'];
    _phonenumber = json['Phonenumber'];
    _role = json['role'];
    _location = json['location'];
    _zipcode = json['Zipcode'];
    _state = json['state'];
    _country = json['country'];
    _image = json['Image'];
    _description = json['Description'];
    _date = json['Date'];
    if (json['item_data'] != null) {
      _itemData = [];
      json['item_data'].forEach((v) {
        _itemData?.add(Item_data.fromJson(v));
      });
    }
  }
  dynamic _restaurantId;
  dynamic _restaurantname;
  dynamic _email;
  dynamic _phonenumber;
  dynamic _role;
  dynamic _location;
  dynamic _zipcode;
  dynamic _state;
  dynamic _country;
  dynamic _image;
  dynamic _description;
  dynamic _date;
  List<Item_data>? _itemData;

  dynamic get restaurantId => _restaurantId;
  dynamic get restaurantname => _restaurantname;
  dynamic get email => _email;
  dynamic get phonenumber => _phonenumber;
  dynamic get role => _role;
  dynamic get location => _location;
  dynamic get zipcode => _zipcode;
  dynamic get state => _state;
  dynamic get country => _country;
  dynamic get image => _image;
  dynamic get description => _description;
  dynamic get date => _date;
  List<Item_data>? get itemData => _itemData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Restaurant_id'] = _restaurantId;
    map['Restaurantname'] = _restaurantname;
    map['Email'] = _email;
    map['Phonenumber'] = _phonenumber;
    map['role'] = _role;
    map['location'] = _location;
    map['Zipcode'] = _zipcode;
    map['state'] = _state;
    map['country'] = _country;
    map['Image'] = _image;
    map['Description'] = _description;
    map['Date'] = _date;
    if (_itemData != null) {
      map['item_data'] = _itemData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// item_id : "61"
/// item_name : "DOMAINE CARNEROS BY TAITTINGER BRUT CUVÉE 2014"
/// qty : "1"
/// price : "240"
/// note : ""
/// type_of_grape : "DOMAINE CARNEROS BY TAITTINGER BRUT"
/// item_type : "TAITTINGER BRUT CUVÉE 2014"
/// price_per_glass : "240"
/// price_per_bottle : "500"
/// price_type : "glass"
/// item_image : "http://restapp.fableadtechnolabs.com/img/items_images/1642498041Wine19.jpg"
/// total_price : 240

class Item_data {
  Item_data({
      dynamic itemId, 
      dynamic itemName, 
      dynamic qty, 
      dynamic price, 
      dynamic note, 
      dynamic typeOfGrape, 
      dynamic itemType, 
      dynamic pricePerGlass, 
      dynamic pricePerBottle, 
      dynamic priceType, 
      dynamic itemImage, 
      dynamic totalPrice,}){
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

  Item_data.fromJson(dynamic json) {
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
  dynamic _itemId;
  dynamic _itemName;
  dynamic _qty;
  dynamic _price;
  dynamic _note;
  dynamic _typeOfGrape;
  dynamic _itemType;
  dynamic _pricePerGlass;
  dynamic _pricePerBottle;
  dynamic _priceType;
  dynamic _itemImage;
  dynamic _totalPrice;

  dynamic get itemId => _itemId;
  dynamic get itemName => _itemName;
  dynamic get qty => _qty;
  dynamic get price => _price;
  dynamic get note => _note;
  dynamic get typeOfGrape => _typeOfGrape;
  dynamic get itemType => _itemType;
  dynamic get pricePerGlass => _pricePerGlass;
  dynamic get pricePerBottle => _pricePerBottle;
  dynamic get priceType => _priceType;
  dynamic get itemImage => _itemImage;
  dynamic get totalPrice => _totalPrice;

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