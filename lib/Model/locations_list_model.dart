/// status : 1
/// message : "Location\nList."
/// data : [{"location":"dsds"},{"location":"patna"},{"location":"rajkot"},{"location":"surat"}]

class LocationsListModel {
  LocationsListModel({
    dynamic status,
    dynamic message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  LocationsListModel.fromJson(dynamic json) {
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

/// location : "dsds"

class Data {
  Data({
    dynamic location,
  }) {
    _location = location;
  }

  Data.fromJson(dynamic json) {
    _location = json['location'];
  }

  dynamic _location;

  dynamic get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['location'] = _location;
    return map;
  }
}
