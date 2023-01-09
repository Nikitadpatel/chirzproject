/// status : 1
/// message : "Item Detail."
/// data : {"id":"32","user_id":"142","category_id":null,"item_name":"Red wine","type_of_grape":"wine","item_type":"Red","year":"2022","region":"gujarat","price_per_glass":"70","price_per_bott":"100","item_image":"http://restapp.fableadtechnolabs.com/img/items_images/164128883024b34033caeeeb29f40fa8efff634e8b.jpg","alcohol_percentage":"0","price_per_cocktail":"0","about_wine":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. ","is_active":"1","is_delete":"0","created_date":"2022-01-13 13:18:37","updated_date":"2022-01-04 15:03:50","is_favourite":0,"restaurants_detail":{"Restaurant_id":"142","Restaurantname":"Le Pain Quotidien","Email":"testnew@gmail.com","Phonenumber":"5646545644","role":"Restaurant","location":"surat","Zipcode":"395004","state":"Gujarat","country":"india","Image":"http://restapp.fableadtechnolabs.com/img/profile_images/1642571960saurav-mahto-_q28qN7J7Sg-unsplash.jpg","Description":"test","Date":"2022-01-19 11:29:20"}}

class ItemDetailModel {
  ItemDetailModel({
      dynamic status, 
      dynamic message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  ItemDetailModel.fromJson(dynamic json) {
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

/// id : "32"
/// user_id : "142"
/// category_id : null
/// item_name : "Red wine"
/// type_of_grape : "wine"
/// item_type : "Red"
/// year : "2022"
/// region : "gujarat"
/// price_per_glass : "70"
/// price_per_bott : "100"
/// item_image : "http://restapp.fableadtechnolabs.com/img/items_images/164128883024b34033caeeeb29f40fa8efff634e8b.jpg"
/// alcohol_percentage : "0"
/// price_per_cocktail : "0"
/// about_wine : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
/// is_active : "1"
/// is_delete : "0"
/// created_date : "2022-01-13 13:18:37"
/// updated_date : "2022-01-04 15:03:50"
/// is_favourite : 0
/// restaurants_detail : {"Restaurant_id":"142","Restaurantname":"Le Pain Quotidien","Email":"testnew@gmail.com","Phonenumber":"5646545644","role":"Restaurant","location":"surat","Zipcode":"395004","state":"Gujarat","country":"india","Image":"http://restapp.fableadtechnolabs.com/img/profile_images/1642571960saurav-mahto-_q28qN7J7Sg-unsplash.jpg","Description":"test","Date":"2022-01-19 11:29:20"}

class Data {
  Data({
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
      dynamic isActive, 
      dynamic isDelete, 
      dynamic createdDate, 
      dynamic updatedDate, 
      dynamic isFavourite,
      dynamic isCocktail,
      Restaurants_detail? restaurantsDetail,}){
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
    _isActive = isActive;
    _isDelete = isDelete;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _isFavourite = isFavourite;
    _isCocktail = isCocktail;
    _restaurantsDetail = restaurantsDetail;
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
    _alcoholPercentage = json['alcohol_percentage'];
    _pricePerCocktail = json['price_per_cocktail'];
    _aboutWine = json['about_wine'];
    _isActive = json['is_active'];
    _isDelete = json['is_delete'];
    _createdDate = json['created_date'];
    _updatedDate = json['updated_date'];
    _isFavourite = json['is_favourite'];
    _isCocktail = json['is_cocktail'];
    _restaurantsDetail = json['restaurants_detail'] != null ? Restaurants_detail.fromJson(json['restaurants_detail']) : null;
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
  dynamic _isActive;
  dynamic _isDelete;
  dynamic _createdDate;
  dynamic _updatedDate;
  dynamic _isFavourite;
  dynamic _isCocktail;
  Restaurants_detail? _restaurantsDetail;

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
  dynamic get isActive => _isActive;
  dynamic get isDelete => _isDelete;
  dynamic get createdDate => _createdDate;
  dynamic get updatedDate => _updatedDate;
  dynamic get isFavourite => _isFavourite;
  dynamic get isCocktail => _isCocktail;
  Restaurants_detail? get restaurantsDetail => _restaurantsDetail;

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
    map['is_active'] = _isActive;
    map['is_delete'] = _isDelete;
    map['created_date'] = _createdDate;
    map['updated_date'] = _updatedDate;
    map['is_favourite'] = _isFavourite;
    map['is_cocktail'] = _isCocktail;
    if (_restaurantsDetail != null) {
      map['restaurants_detail'] = _restaurantsDetail?.toJson();
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