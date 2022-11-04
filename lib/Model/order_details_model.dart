/// status : 1
/// message : "Booking summary"
/// data : {"order_id":"12","order_no":"CHIRZ00007","transaction_id":"ch_3KEBS9EiAmwplIy61BmIKKiz","total":"615","username":"jas","city":"surat","zipcode":"394602","state":"gujarat","country":"india","phone_number":"9868867890","profile_image":"http://restapp.fableadtechnolabs.com/img/profile_images/1641212319avatar-5.png","status":"0","created_date":"2022-01-20 12:32:54","restaurants_detail":{"Restaurant_id":"142","Restaurantname":"Le Pain Quotidien","Email":"testnew@gmail.com","Phonenumber":"5646545644","role":"Restaurant","location":"surat","Zipcode":"395004","state":"Gujarat","country":"india","Image":"http://restapp.fableadtechnolabs.com/img/profile_images/1642571960saurav-mahto-_q28qN7J7Sg-unsplash.jpg","Description":"test","Date":"2022-01-19 11:29:20"},"item_list":[{"id":"34","user_id":"142","item_name":"jachos creek","type_of_grape":"dfdf","item_type":"jachos","year":"2022","region":"gujarat","item_image":"http://restapp.fableadtechnolabs.com/img/items_images/1641289106pexels-photo-2912108.jpeg","price":"180","price_type":null,"qty":"2","created_date":"2022-01-04 17:14:16"},{"id":"31","user_id":"142","item_name":"Red Wine Vinegar","type_of_grape":"Dolce Vita","item_type":"vegetarians","year":"2002","region":"Spain","item_image":"http://restapp.fableadtechnolabs.com/img/items_images/164120552361ihrUHqC7L._SL1500_.jpg","price":"255","price_type":null,"qty":"1","created_date":"2022-01-04 17:14:16"}]}

class OrderDetailsModel {
  OrderDetailsModel({
      dynamic status, 
      dynamic message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  OrderDetailsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  dynamic _status;
  dynamic _message;
  Data? _data;

  dynamic get status => _status;
  dynamic get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// order_id : "12"
/// order_no : "CHIRZ00007"
/// transaction_id : "ch_3KEBS9EiAmwplIy61BmIKKiz"
/// total : "615"
/// username : "jas"
/// city : "surat"
/// zipcode : "394602"
/// state : "gujarat"
/// country : "india"
/// phone_number : "9868867890"
/// profile_image : "http://restapp.fableadtechnolabs.com/img/profile_images/1641212319avatar-5.png"
/// status : "0"
/// created_date : "2022-01-20 12:32:54"
/// restaurants_detail : {"Restaurant_id":"142","Restaurantname":"Le Pain Quotidien","Email":"testnew@gmail.com","Phonenumber":"5646545644","role":"Restaurant","location":"surat","Zipcode":"395004","state":"Gujarat","country":"india","Image":"http://restapp.fableadtechnolabs.com/img/profile_images/1642571960saurav-mahto-_q28qN7J7Sg-unsplash.jpg","Description":"test","Date":"2022-01-19 11:29:20"}
/// item_list : [{"id":"34","user_id":"142","item_name":"jachos creek","type_of_grape":"dfdf","item_type":"jachos","year":"2022","region":"gujarat","item_image":"http://restapp.fableadtechnolabs.com/img/items_images/1641289106pexels-photo-2912108.jpeg","price":"180","price_type":null,"qty":"2","created_date":"2022-01-04 17:14:16"},{"id":"31","user_id":"142","item_name":"Red Wine Vinegar","type_of_grape":"Dolce Vita","item_type":"vegetarians","year":"2002","region":"Spain","item_image":"http://restapp.fableadtechnolabs.com/img/items_images/164120552361ihrUHqC7L._SL1500_.jpg","price":"255","price_type":null,"qty":"1","created_date":"2022-01-04 17:14:16"}]

class Data {
  Data({
      dynamic orderId, 
      dynamic orderNo, 
      dynamic transactionId, 
      dynamic total, 
      dynamic username, 
      dynamic city, 
      dynamic zipcode, 
      dynamic state, 
      dynamic country, 
      dynamic phoneNumber, 
      dynamic profileImage, 
      dynamic status, 
      dynamic createdDate, 
      Restaurants_detail? restaurantsDetail, 
      List<Item_list>? itemList,}){
    _orderId = orderId;
    _orderNo = orderNo;
    _transactionId = transactionId;
    _total = total;
    _username = username;
    _city = city;
    _zipcode = zipcode;
    _state = state;
    _country = country;
    _phoneNumber = phoneNumber;
    _profileImage = profileImage;
    _status = status;
    _createdDate = createdDate;
    _restaurantsDetail = restaurantsDetail;
    _itemList = itemList;
}

  Data.fromJson(dynamic json) {
    _orderId = json['order_id'];
    _orderNo = json['order_no'];
    _transactionId = json['transaction_id'];
    _total = json['total'];
    _username = json['username'];
    _city = json['city'];
    _zipcode = json['zipcode'];
    _state = json['state'];
    _country = json['country'];
    _phoneNumber = json['phone_number'];
    _profileImage = json['profile_image'];
    _status = json['status'];
    _createdDate = json['created_date'];
    _restaurantsDetail = json['restaurants_detail'] != null ? Restaurants_detail.fromJson(json['restaurants_detail']) : null;
    if (json['item_list'] != null) {
      _itemList = [];
      json['item_list'].forEach((v) {
        _itemList?.add(Item_list.fromJson(v));
      });
    }
  }
  dynamic _orderId;
  dynamic _orderNo;
  dynamic _transactionId;
  dynamic _total;
  dynamic _username;
  dynamic _city;
  dynamic _zipcode;
  dynamic _state;
  dynamic _country;
  dynamic _phoneNumber;
  dynamic _profileImage;
  dynamic _status;
  dynamic _createdDate;
  Restaurants_detail? _restaurantsDetail;
  List<Item_list>? _itemList;

  dynamic get orderId => _orderId;
  dynamic get orderNo => _orderNo;
  dynamic get transactionId => _transactionId;
  dynamic get total => _total;
  dynamic get username => _username;
  dynamic get city => _city;
  dynamic get zipcode => _zipcode;
  dynamic get state => _state;
  dynamic get country => _country;
  dynamic get phoneNumber => _phoneNumber;
  dynamic get profileImage => _profileImage;
  dynamic get status => _status;
  dynamic get createdDate => _createdDate;
  Restaurants_detail? get restaurantsDetail => _restaurantsDetail;
  List<Item_list>? get itemList => _itemList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = _orderId;
    map['order_no'] = _orderNo;
    map['transaction_id'] = _transactionId;
    map['total'] = _total;
    map['username'] = _username;
    map['city'] = _city;
    map['zipcode'] = _zipcode;
    map['state'] = _state;
    map['country'] = _country;
    map['phone_number'] = _phoneNumber;
    map['profile_image'] = _profileImage;
    map['status'] = _status;
    map['created_date'] = _createdDate;
    if (_restaurantsDetail != null) {
      map['restaurants_detail'] = _restaurantsDetail?.toJson();
    }
    if (_itemList != null) {
      map['item_list'] = _itemList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "34"
/// user_id : "142"
/// item_name : "jachos creek"
/// type_of_grape : "dfdf"
/// item_type : "jachos"
/// year : "2022"
/// region : "gujarat"
/// item_image : "http://restapp.fableadtechnolabs.com/img/items_images/1641289106pexels-photo-2912108.jpeg"
/// price : "180"
/// price_type : null
/// qty : "2"
/// created_date : "2022-01-04 17:14:16"

class Item_list {
  Item_list({
      dynamic id, 
      dynamic userId, 
      dynamic itemName, 
      dynamic typeOfGrape, 
      dynamic itemType, 
      dynamic year, 
      dynamic region, 
      dynamic itemImage, 
      dynamic price, 
      dynamic priceType, 
      dynamic qty, 
      dynamic createdDate,}){
    _id = id;
    _userId = userId;
    _itemName = itemName;
    _typeOfGrape = typeOfGrape;
    _itemType = itemType;
    _year = year;
    _region = region;
    _itemImage = itemImage;
    _price = price;
    _priceType = priceType;
    _qty = qty;
    _createdDate = createdDate;
}

  Item_list.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _itemName = json['item_name'];
    _typeOfGrape = json['type_of_grape'];
    _itemType = json['item_type'];
    _year = json['year'];
    _region = json['region'];
    _itemImage = json['item_image'];
    _price = json['price'];
    _priceType = json['price_type'];
    _qty = json['qty'];
    _createdDate = json['created_date'];
  }
  dynamic _id;
  dynamic _userId;
  dynamic _itemName;
  dynamic _typeOfGrape;
  dynamic _itemType;
  dynamic _year;
  dynamic _region;
  dynamic _itemImage;
  dynamic _price;
  dynamic _priceType;
  dynamic _qty;
  dynamic _createdDate;

  dynamic get id => _id;
  dynamic get userId => _userId;
  dynamic get itemName => _itemName;
  dynamic get typeOfGrape => _typeOfGrape;
  dynamic get itemType => _itemType;
  dynamic get year => _year;
  dynamic get region => _region;
  dynamic get itemImage => _itemImage;
  dynamic get price => _price;
  dynamic get priceType => _priceType;
  dynamic get qty => _qty;
  dynamic get createdDate => _createdDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['item_name'] = _itemName;
    map['type_of_grape'] = _typeOfGrape;
    map['item_type'] = _itemType;
    map['year'] = _year;
    map['region'] = _region;
    map['item_image'] = _itemImage;
    map['price'] = _price;
    map['price_type'] = _priceType;
    map['qty'] = _qty;
    map['created_date'] = _createdDate;
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

class Restaurants_detail {
  Restaurants_detail({
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
      dynamic date,}){
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
}

  Restaurants_detail.fromJson(dynamic json) {
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
    return map;
  }

}