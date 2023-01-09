class Reviewwine {
  Reviewwine({
    dynamic status,

    Data? data,}){
    _status = status;
    _data = data;

  }

  Reviewwine.fromJson(dynamic json) {
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
    dynamic wid,
    dynamic click,

  }){
    _id = id;
    _rid = rid;
    _wid= wid;
    _click = click;
  }

  Data.fromJson(dynamic json) {
    _id = json['device_id'];
    _rid = json['r_id'];
    _wid = json['w_id'];
    _click = json['clicks'];
  }
  dynamic _id;
  dynamic _rid;
  dynamic _wid;
  dynamic _click;

  dynamic get id => _id;
  dynamic get rid => _rid;
  dynamic get wid => _wid;
  dynamic get click => _click;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['device_id'] = _id;
    map['r_id'] = _rid;
    map['w_id'] = _wid;
    map['clicks'] = _click;
    return map;
  }

}