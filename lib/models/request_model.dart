
class RequestModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? brandName;
  String? brandPhone;
  String? image;
  String? requestDate;
  String? password;
  RequestModel({
    this.phone,
    this.email,
    this.name,
    this.brandName,
    this.brandPhone,
    this.image,
    this.requestDate,
    this.password
  });
  void setUID(String uId){
    this.uId=uId;
  }
  RequestModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    brandName = json['brandName'];
    brandPhone = json['brandPhone'];
    image = json['image'];
    password = json['password'];
    requestDate = json['requestDate'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'brandName': brandName,
      'brandPhone': brandPhone,
      'image': image,
      'password': password,
      'requestDate': requestDate,
    };
  }
}
