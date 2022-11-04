/// status : "1"
/// message : "List Of restaurant details"
/// data : [{"Restaurant_id":"126","Restaurantname":"checkfree","profile_name":"checkfree","Email":"check@g.com","Phonenumber":"4654563456322","role":"Restaurant","location":"surat","Zipcode":"395004","state":"Gujrat","country":"US","Image":"https://restapp.fableadtechnolabs.com/img/profile_images/16409420501.jpeg","Description":"","Date":"2021-12-31 14:44:10"},{"Restaurant_id":"128","Restaurantname":"vinay","profile_name":"ghfhfh","Email":"vinayprajapati@gmail.com","Phonenumber":"9868867890","role":"Restaurant","location":"surat","Zipcode":"394602","state":"gujarat","country":"india","Image":"https://restapp.fableadtechnolabs.com/img/profile_images/164077763711.jpeg","Description":"fhf fdjdfj fjdjd fdjdfj fjryigj","Date":"2021-12-29 17:03:57"},{"Restaurant_id":"142","Restaurantname":"testnew","profile_name":"testnew","Email":"testnew@gmail.com","Phonenumber":"5646545644","role":"Restaurant","location":"surat","Zipcode":"395004","state":"Gujarat","country":"india","Image":"https://restapp.fableadtechnolabs.com/img/profile_images/1641210466avatar-3.png","Description":"test","Date":"2022-01-03 17:17:46"}]

class RestaurantData {
  RestaurantData({
      dynamic status, 
      dynamic message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  RestaurantData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  dynamic _status;
  dynamic _message;
  List<Data>? _data;

  dynamic get status => _status;
  dynamic get message => _message;
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

/// Restaurant_id : "126"
/// Restaurantname : "checkfree"
/// profile_name : "checkfree"
/// Email : "check@g.com"
/// Phonenumber : "4654563456322"
/// role : "Restaurant"
/// location : "surat"
/// Zipcode : "395004"
/// state : "Gujrat"
/// country : "US"
/// Image : "https://restapp.fableadtechnolabs.com/img/profile_images/16409420501.jpeg"
/// Description : ""
/// Date : "2021-12-31 14:44:10"

class Data {
  Data({
      dynamic restaurantId, 
      dynamic restaurantname, 
      dynamic profileName, 
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
    _profileName = profileName;
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

  Data.fromJson(dynamic json) {
    _restaurantId = json['Restaurant_id'];
    _restaurantname = json['Restaurantname'];
    _profileName = json['profile_name'];
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
  dynamic _profileName;
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
  dynamic get profileName => _profileName;
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
    map['profile_name'] = _profileName;
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