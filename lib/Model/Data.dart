/// setting_id : "1"
/// restaurant : "http://portal.chirz.co.uk/admin/assets/london/1649747995restaurant.png"
/// my_tasking : "http://portal.chirz.co.uk/admin/assets/tasking/1649747995my_tasking.png"

class Data {
  Data({
      String? settingId, 
      String? restaurant, 
      String? myTasking,}){
    _settingId = settingId;
    _restaurant = restaurant;
    _myTasking = myTasking;
}

  Data.fromJson(dynamic json) {
    _settingId = json['setting_id'];
    _restaurant = json['restaurant'];
    _myTasking = json['my_tasking'];
  }
  String? _settingId;
  String? _restaurant;
  String? _myTasking;

  String? get settingId => _settingId;
  String? get restaurant => _restaurant;
  String? get myTasking => _myTasking;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['setting_id'] = _settingId;
    map['restaurant'] = _restaurant;
    map['my_tasking'] = _myTasking;
    return map;
  }

}