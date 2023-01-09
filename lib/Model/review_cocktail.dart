class Reviewcocktail {
  Reviewcocktail({
    dynamic status,
    Data? data,}){
    _status = status;
    _data = data;
  }

  Reviewcocktail.fromJson(dynamic json) {
    _status = json['status'];

    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  dynamic _status;

  Data? _data;

  dynamic get status => _status;

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
    dynamic id,
    dynamic rid,
    dynamic cid,
    dynamic click,

  }){
    _id = id;
    _rid = rid;
    _cid= cid;
    _click = click;
  }

  Data.fromJson(dynamic json) {
    _id = json['device_id'];
    _rid = json['r_id'];
    _cid = json['c_id'];
    _click = json['clicks'];
  }
  dynamic _id;
  dynamic _rid;
  dynamic _cid;
  dynamic _click;

  dynamic get id => _id;
  dynamic get rid => _rid;
  dynamic get cid => _cid;
  dynamic get click => _click;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['device_id'] = _id;
    map['r_id'] = _rid;
    map['c_id'] = _cid;
    map['clicks'] = _click;
    return map;
  }

}