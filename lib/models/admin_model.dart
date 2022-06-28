
class adminModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? brandName;
  String? brandPhone;
  String? image;

  adminModel({
    this.phone,
    this.email,
    this.name,
    this.uId,
    this.brandName,
    this.brandPhone,
    this.image,
  });

  adminModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    brandName = json['brandName'];
    brandPhone = json['brandPhone'];
    image = json['image'];
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
    };
  }
}
