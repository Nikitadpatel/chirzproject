import 'Data1.dart';

/// status : 1
/// message : "Item list"
/// data1 : [{"id":"129","user_id":"142","category_id":null,"item_name":"sadffa","type_of_grape":"NA","item_type":"NA","year":"0","region":"NA","price_per_glass":"NA","price_per_bott":"NA","item_image":"http://portal.chirz.co.uk/img/items_images/1648800657b.jpg","alcohol_percentage":"0","price_per_cocktail":"34","about_wine":"how are you?","is_cocktail":"1","is_active":"1","is_delete":"0","created_date":"2022-04-01 08:10:57","updated_date":null}]

class WineCockTailModel {
  WineCockTailModel({
      dynamic status, 
      dynamic message, 
      List<Data1>? data1,}){
    _status = status;
    _message = message;
    _data1 = data1;
}

  WineCockTailModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data1 = [];
      json['data'].forEach((v) {
        _data1?.add(Data1.fromJson(v));
      });
    }
  }
  dynamic _status;
  dynamic _message;
  List<Data1>? _data1;

  dynamic get status => _status;
  dynamic get message => _message;
  List<Data1>? get data1 => _data1;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data1 != null) {
      map['data'] = _data1?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}