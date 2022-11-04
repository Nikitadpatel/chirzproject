/// status : 1
/// message : "You have login successfully"
/// data : {"u_id":"143","username":"jas","email":"jas@gmail.com","phone_number":"9868867890","user_role":"Customer","city":"surat","Image":"https://restapp.fableadtechnolabs.com/img/profile_images/1641212319avatar-5.png","zipcode":"394602","state":"gujarat","country":"india"}

class UserModel {
  UserModel({
      int? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  UserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _status;
  String? _message;
  Data? _data;

  int? get status => _status;
  String? get message => _message;
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

/// u_id : "143"
/// username : "jas"
/// email : "jas@gmail.com"
/// phone_number : "9868867890"
/// user_role : "Customer"
/// city : "surat"
/// Image : "https://restapp.fableadtechnolabs.com/img/profile_images/1641212319avatar-5.png"
/// zipcode : "394602"
/// state : "gujarat"
/// country : "india"

class Data {
  Data({
      String? uId, 
      String? username, 
      String? email, 
      String? phoneNumber, 
      String? userRole, 
      String? city, 
      String? image, 
      String? zipcode, 
      String? state, 
      String? country,}){
    _uId = uId;
    _username = username;
    _email = email;
    _phoneNumber = phoneNumber;
    _userRole = userRole;
    _city = city;
    _image = image;
    _zipcode = zipcode;
    _state = state;
    _country = country;
}

  Data.fromJson(dynamic json) {
    _uId = json['u_id'];
    _username = json['username'];
    _email = json['email'];
    _phoneNumber = json['phone_number'];
    _userRole = json['user_role'];
    _city = json['city'];
    _image = json['Image'];
    _zipcode = json['zipcode'];
    _state = json['state'];
    _country = json['country'];
  }
  String? _uId;
  String? _username;
  String? _email;
  String? _phoneNumber;
  String? _userRole;
  String? _city;
  String? _image;
  String? _zipcode;
  String? _state;
  String? _country;

  String? get uId => _uId;
  String? get username => _username;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get userRole => _userRole;
  String? get city => _city;
  String? get image => _image;
  String? get zipcode => _zipcode;
  String? get state => _state;
  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['u_id'] = _uId;
    map['username'] = _username;
    map['email'] = _email;
    map['phone_number'] = _phoneNumber;
    map['user_role'] = _userRole;
    map['city'] = _city;
    map['Image'] = _image;
    map['zipcode'] = _zipcode;
    map['state'] = _state;
    map['country'] = _country;
    return map;
  }

}