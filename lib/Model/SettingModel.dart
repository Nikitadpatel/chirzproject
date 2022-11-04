import 'Data.dart';

/// status : 1
/// message : "Settings details show successfully"
/// data : {"setting_id":"1","restaurant":"http://portal.chirz.co.uk/admin/assets/london/1649747995restaurant.png","my_tasking":"http://portal.chirz.co.uk/admin/assets/tasking/1649747995my_tasking.png"}

class SettingModel {
  SettingModel({
      dynamic status, 
      dynamic message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  SettingModel.fromJson(dynamic json) {
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