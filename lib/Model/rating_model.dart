/// status : 1
/// message : "Item Rating rating."
/// data : [{"r_id":"11","user_id":"143","item_id":"33","rate":"2","comment":"lorem ipsum","username":"jas","email":"jas@gmail.com","profile_image":"http://restapp.fableadtechnolabs.com/img/profile_images/1641212319avatar-5.png","created_date":"2022-02-02 10:50:42"},{"r_id":"14","user_id":"152","item_id":"33","rate":"2","comment":"lorem ipsum","username":"Nirav Kakadiya","email":"kakadiyanirav1@gmail.com","profile_image":"http://restapp.fableadtechnolabs.com/images/avatars/admin.png","created_date":"2022-02-02 12:00:19"}]

class RatingModel {
  RatingModel({
      dynamic status, 
      dynamic message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  RatingModel.fromJson(dynamic json) {
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

/// r_id : "11"
/// user_id : "143"
/// item_id : "33"
/// rate : "2"
/// comment : "lorem ipsum"
/// username : "jas"
/// email : "jas@gmail.com"
/// profile_image : "http://restapp.fableadtechnolabs.com/img/profile_images/1641212319avatar-5.png"
/// created_date : "2022-02-02 10:50:42"

class Data {
  Data({
      dynamic rId, 
      dynamic userId, 
      dynamic itemId, 
      dynamic rate, 
      dynamic comment, 
      dynamic username, 
      dynamic email, 
      dynamic profileImage, 
      dynamic createdDate,}){
    _rId = rId;
    _userId = userId;
    _itemId = itemId;
    _rate = rate;
    _comment = comment;
    _username = username;
    _email = email;
    _profileImage = profileImage;
    _createdDate = createdDate;
}

  Data.fromJson(dynamic json) {
    _rId = json['r_id'];
    _userId = json['user_id'];
    _itemId = json['item_id'];
    _rate = json['rate'];
    _comment = json['comment'];
    _username = json['username'];
    _email = json['email'];
    _profileImage = json['profile_image'];
    _createdDate = json['created_date'];
  }
  dynamic _rId;
  dynamic _userId;
  dynamic _itemId;
  dynamic _rate;
  dynamic _comment;
  dynamic _username;
  dynamic _email;
  dynamic _profileImage;
  dynamic _createdDate;

  dynamic get rId => _rId;
  dynamic get userId => _userId;
  dynamic get itemId => _itemId;
  dynamic get rate => _rate;
  dynamic get comment => _comment;
  dynamic get username => _username;
  dynamic get email => _email;
  dynamic get profileImage => _profileImage;
  dynamic get createdDate => _createdDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['r_id'] = _rId;
    map['user_id'] = _userId;
    map['item_id'] = _itemId;
    map['rate'] = _rate;
    map['comment'] = _comment;
    map['username'] = _username;
    map['email'] = _email;
    map['profile_image'] = _profileImage;
    map['created_date'] = _createdDate;
    return map;
  }

}