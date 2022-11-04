/// status : 1
/// message : "Cart added successfully"
/// cart_id : 15

class BaseModel {
  BaseModel({
    dynamic status,
    dynamic message,
    dynamic cartId,
    dynamic response,
  }) {
    _status = status;
    _message = message;
    _cartId = cartId;
    _response = response;
  }

  BaseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _cartId = json['cart_id'];
    _response = json['response'];
  }

  dynamic _status;
  dynamic _message;
  dynamic _cartId;
  dynamic _response;

  dynamic get status => _status;
  dynamic get response => _response;

  dynamic get message => _message;

  dynamic get cartId => _cartId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['cart_id'] = _cartId;
    map['response'] = _response;
    return map;
  }
}
