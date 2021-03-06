
import 'adress_user_model.dart';
import 'orders_model.dart';

class UserOrderModel{
  late String orderState;
  late String orderDate;
  late String orderPhoto;
  late double orderPrice;
  late String orderId;
  late String userOrderId;
  late String userId;
  late AddressModel addressModel;
  late List<OrderModel> orders;
  UserOrderModel({
    required this.orderState,
    required this.orderDate,
    required this.userId,
    required this.orderPhoto,
    required this.orderPrice,
    required this.orders,
    required this.addressModel,
  });
  void setBrandId(String id){
    this.orderId=id;
  }
  void setUserOrderId(String uID){
    this.userOrderId=uID;
  }

  UserOrderModel.fromJson(Map<String,dynamic>? json,String id) {
    orderState=json!['orderState'];
    orderDate=json['orderDate'];
    orderPhoto=json['orderPhoto'];
    orderPrice=double.parse(json['orderPrice'].toString());
    userId=json['userId'];
    orderId=json['brandOrderId'];
    userOrderId=json['userOrderId'];
    orders= json['orders'].map((e) =>OrderModel.fromJson(e)).toList().cast<OrderModel>() ;
    addressModel=AddressModel.fromJson(json['address']);
  }

  Map<String,dynamic> toMap(){
    return
      {'orderState':orderState,
        'orderDate':orderDate,
        'orderPhoto':orderPhoto,
        'orderPrice':orderPrice,
        'brandOrderId':orderId,
        'userOrderId':userOrderId,
        'userId':userId,
        'orders':orders.map((e) => e.toMap()).toList(),
        'address':addressModel.toMap(),
      };
  }
}
