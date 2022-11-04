/// status : 1
/// message : "Pairing list"
/// data : [{"menu_name":"Lunch","menu_img":"https://restapp.fableadtechnolabs.com/images/category_image/6.jpg","food":[{"pair_id":"66","food_name":"Roti","image":"https://restapp.fableadtechnolabs.com/images/food_images/1641203904dish_thumbnail.jpg","price":"5"},{"pair_id":"67","food_name":"Sabji","image":"https://restapp.fableadtechnolabs.com/images/food_images/1641203904Recipe-in-12.jpg","price":"60"}],"wine":[{"id":"32","user_id":"142","category_id":null,"item_name":"Red wine","type_of_grape":"wine","item_type":"Red","year":"2022","region":"gujarat","price_per_glass":"70","price_per_bott":"100","item_image":"https://restapp.fableadtechnolabs.com/img/items_images/164128883024b34033caeeeb29f40fa8efff634e8b.jpg","about_wine":null,"is_active":"1","is_delete":"0","created_date":"2022-01-04 15:03:50","updated_date":"2022-01-04 15:03:50"}]},{"menu_name":"Lunch","menu_img":"https://restapp.fableadtechnolabs.com/images/category_image/6.jpg","food":[{"pair_id":"66","food_name":"Roti","image":"https://restapp.fableadtechnolabs.com/images/food_images/1641203904dish_thumbnail.jpg","price":"5"},{"pair_id":"67","food_name":"Sabji","image":"https://restapp.fableadtechnolabs.com/images/food_images/1641203904Recipe-in-12.jpg","price":"60"}],"wine":[{"id":"35","user_id":"142","category_id":null,"item_name":"nobel savage","type_of_grape":"nobel wine","item_type":"nobel","year":"2022","region":"gujarat","price_per_glass":"70","price_per_bott":"140","item_image":"https://restapp.fableadtechnolabs.com/img/items_images/1641289310pexels-photo-2912108.jpeg","about_wine":null,"is_active":"1","is_delete":"0","created_date":"2022-01-04 15:11:50","updated_date":"2022-01-04 15:11:50"}]}]

class FoodItemsModel {
  FoodItemsModel({
    dynamic status,
    dynamic message,
    List<MenuData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FoodItemsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MenuData.fromJson(v));
      });
    }
  }

  dynamic _status;
  dynamic _message;
  List<MenuData>? _data;

  dynamic get status => _status;

  dynamic get message => _message;

  List<MenuData>? get data => _data;

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

/// menu_name : "Lunch"
/// menu_img : "https://restapp.fableadtechnolabs.com/images/category_image/6.jpg"
/// food : [{"pair_id":"66","food_name":"Roti","image":"https://restapp.fableadtechnolabs.com/images/food_images/1641203904dish_thumbnail.jpg","price":"5"},{"pair_id":"67","food_name":"Sabji","image":"https://restapp.fableadtechnolabs.com/images/food_images/1641203904Recipe-in-12.jpg","price":"60"}]
/// wine : [{"id":"32","user_id":"142","category_id":null,"item_name":"Red wine","type_of_grape":"wine","item_type":"Red","year":"2022","region":"gujarat","price_per_glass":"70","price_per_bott":"100","item_image":"https://restapp.fableadtechnolabs.com/img/items_images/164128883024b34033caeeeb29f40fa8efff634e8b.jpg","about_wine":null,"is_active":"1","is_delete":"0","created_date":"2022-01-04 15:03:50","updated_date":"2022-01-04 15:03:50"}]

class MenuData {
  MenuData({
    dynamic menuName,
    dynamic menuImg,
    List<Food>? food,
    List<Wine>? wine,
  }) {
    _menuName = menuName;
    _menuImg = menuImg;
    _food = food;
    _wine = wine;
  }

  MenuData.fromJson(dynamic json) {
    _menuName = json['menu_name'];
    _menuImg = json['menu_img'];
    if (json['food'] != null) {
      _food = [];
      json['food'].forEach((v) {
        _food?.add(Food.fromJson(v));
      });
    }
    if (json['wine'] != null) {
      _wine = [];
      json['wine'].forEach((v) {
        _wine?.add(Wine.fromJson(v));
      });
    }
  }

  dynamic _menuName;
  dynamic _menuImg;
  List<Food>? _food;
  List<Wine>? _wine;

  dynamic get menuName => _menuName;

  dynamic get menuImg => _menuImg;

  List<Food>? get food => _food;

  List<Wine>? get wine => _wine;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['menu_name'] = _menuName;
    map['menu_img'] = _menuImg;
    if (_food != null) {
      map['food'] = _food?.map((v) => v.toJson()).toList();
    }
    if (_wine != null) {
      map['wine'] = _wine?.map((v) => v.toJson()).toList();
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
/// item_image : "https://restapp.fableadtechnolabs.com/img/items_images/164128883024b34033caeeeb29f40fa8efff634e8b.jpg"
/// about_wine : null
/// is_active : "1"
/// is_delete : "0"
/// created_date : "2022-01-04 15:03:50"
/// updated_date : "2022-01-04 15:03:50"

class Wine {
  Wine({
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
    dynamic aboutWine,
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
    _aboutWine = aboutWine;
    _isActive = isActive;
    _isDelete = isDelete;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
  }

  Wine.fromJson(dynamic json) {
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
  dynamic _aboutWine;
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

  dynamic get aboutWine => _aboutWine;

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
    map['about_wine'] = _aboutWine;
    map['is_active'] = _isActive;
    map['is_delete'] = _isDelete;
    map['created_date'] = _createdDate;
    map['updated_date'] = _updatedDate;
    return map;
  }
}

/// pair_id : "66"
/// food_name : "Roti"
/// image : "https://restapp.fableadtechnolabs.com/images/food_images/1641203904dish_thumbnail.jpg"
/// price : "5"

class Food {
  Food({
    dynamic pairId,
    dynamic foodName,
    dynamic image,
    dynamic price,
  }) {
    _pairId = pairId;
    _foodName = foodName;
    _image = image;
    _price = price;
  }

  Food.fromJson(dynamic json) {
    _pairId = json['pair_id'];
    _foodName = json['food_name'];
    _image = json['image'];
    _price = json['price'];
  }

  dynamic _pairId;
  dynamic _foodName;
  dynamic _image;
  dynamic _price;

  dynamic get pairId => _pairId;

  dynamic get foodName => _foodName;

  dynamic get image => _image;

  dynamic get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pair_id'] = _pairId;
    map['food_name'] = _foodName;
    map['image'] = _image;
    map['price'] = _price;
    return map;
  }
}
