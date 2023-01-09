class ReviewModel {
  ReviewModel({
    String? status,
    Data? data,}){
    _status = status;
    _data = data;
  }
  ReviewModel.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  Data? _data;
  String? get status => _status;
  Data? get data => _data;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}
class Data {
  Data({
    String? id,
    String? rid,
    String? click,
  }){
    _id = id;
    _rid = rid;
    _click = click;
  }
  Data.fromJson(dynamic json) {
    _id = json['device_id'];
    _rid = json['r_id'];
    _click = json['clicks'];
  }
  String? _id;
  String? _rid;
  String? _click;
  String? get id => _id;
  String? get rid => _rid;
  String? get click => _click;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['device_id'] = _id;
    map['r_id'] = _rid;
    map['clicks'] = _click;
    return map;
  }
}
