
class ProductModel {
  String? productName; //
  String? description; //
  String? productUid;
  String? category; //
  String? brandId;
  String? brandName;
  String? price; //
  String? offer; //
  List? photos; //
  int bestSeller=0; //
  double ?rate;
  late Map<String, Map<String, dynamic>> data; //
  late Map<String,String> ? virtualImage; //

  ProductModel({
    required this.productName,
    required this.description,
    required this.category,
    required this.price,
    required this.offer,
    required this.photos,
    required this.data,
    required this.virtualImage,
  });

  ProductModel.fromJson(Map<String, dynamic>? json, String uid) {
    productName = json!['name'];
    description = json['description'];
    productUid = uid;
    category = json['category'];
    price = json['price'];
    offer = json['offer'];
    photos = json['photos'] ;
    data =json['data'].cast<String, Map<String, String>>();
    bestSeller=json['bestSeller']??0;
    rate=json['rate']??5;
    brandName=json['brandName'];
    virtualImage=json['virtualImage'].cast<String,String>();
  }

  Map<String, dynamic> toMap() {
    return {
      'name': productName,
      'description': description,
      'category': category,
      'price': price,
      'offer': offer,
      'photos': photos,
      'data': data,
      'virtualImage': virtualImage,
    };
  }
}
