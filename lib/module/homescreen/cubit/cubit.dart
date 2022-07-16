import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:admin/models/admin_model.dart';
import 'package:admin/models/user_order_model.dart';
import 'package:admin/module/Admin_screens/dashboard_screen.dart';
import 'package:admin/module/Admin_screens/view_product.dart';
import 'package:admin/module/Admin_screens/approve_orders.dart';
import 'package:admin/module/Admin_screens/add_product.dart';
import 'package:admin/module/homescreen/cubit/states.dart';
import 'package:admin/module/login_screen/login_screen.dart';
import 'package:admin/shared/components/component.dart';
import 'package:admin/shared/components/constant.dart';
import 'package:admin/shared/network/local/cache_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/orders_model.dart';
import '../../../models/products_model.dart';
import '../../../models/request_model.dart';
import '../../../shared/Styles/colors.dart';
import 'dart:core';
import '../../Admin_screens/inprogress_orders.dart';
import '../home_screen.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitialState());

  static AdminCubit get(context) => BlocProvider.of(context);
  adminModel? model;
  List<String> categoriesNameList = [
    'Shirts',
    'T-shirts',
    'Pants',
    'Shorts',
    'Jackets',
  ];

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    // ..customAnimation = CustomAnimation(tween: null,);
  }

  Timer? _timer;

  void Loading() {
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    // EasyLoading.showSuccess('Use in initState');
  }

  List<XFile> photos = [];
  List<Uint8List> webPhotos = [];
  Map<String, Map<String, dynamic>> data = {};

  Future getAdminData() async {
    model = null;
    emit(AdminGetAdminLoadingState());
    await FirebaseFirestore.instance
        .collection('admins')
        .doc(uId)
        .get()
        .then((value) {
      model = adminModel.fromJson(value.data()!);
      emit(AdminGetAdminSuccessState());
      print(value.data());
    }).catchError((error) {
      emit(AdminGetAdminErrorState(error.toString()));
    });
  }

  signOut(context) {
    FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.removeDate(key: 'uID').then((value) {
        if (value) {
          emit(UserLoggedOutSuccessState());
          Navigator.pushReplacementNamed(context, LoginScreen.id);
          print(uId);
          model = null;
        }
      });
    });
  }

  mainAdminSignOut(context) {
    CacheHelper.removeDate(key: 'uID').then((value) {
      if (value) {
        CacheHelper.removeDate(key: 'IsAdmin').then((value) {
          emit(UserLoggedOutSuccessState());
          Navigator.pushReplacementNamed(context, LoginScreen.id);
          print(uId);
          model = null;
        });
      }
    });
  }

  //Homescreen state second design
  Widget selectedScreen2 = DashboardScreen();

  currentScreen(item) {
    switch (item.route) {
      case DashboardScreen.id:
        {
          selectedScreen2 = DashboardScreen();

          emit(AdminChangeScreenRouteState());
        }
        break;
      case ApprovedOrdersScreen.id:
        {
          selectedScreen2 = ApprovedOrdersScreen();
          emit(AdminChangeScreenRouteState());
        }
        break;
      case InprogressOrdersScreen.id:
        {
          selectedScreen2 = InprogressOrdersScreen();
          emit(AdminChangeScreenRouteState());
        }
        break;
      case AddProductScreen.id:
        {
          selectedScreen2 = AddProductScreen();
          emit(AdminChangeScreenRouteState());
        }
        break;
      case ViewProductScreen.id:
        {
          selectedScreen2 = ViewProductScreen();
          emit(AdminChangeScreenRouteState());
        }
        break;
    }
  }

// dashboard analytic
  firebaseAnalytic(title, stream) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print('Helllllllllllllllllllp');
          print(snapshot.data.toString());
          print('zzzzzzzzzz' + snapshot.error.toString());

          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.orange),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Something went wrong',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.orange),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        }

        if (snapshot.hasData) {
          return analyticWedget(
              title: title, value: snapshot.data!.size.toString());
        }
        return const SizedBox();
      },
    );
  }

// Manage Products
  final _firestore = FirebaseFirestore.instance;

  Future addProduct(
      {productName,
      description,
      category,
      brandName,
      price,
      offer,
      photos,
      virtual,
      required Map<String, Map<String, dynamic>> data}) async {
    emit(AdminAddProductsLoadingState());
    EasyLoading.show(status: 'Loading...');

    ProductModel product = ProductModel(
        productName: productName,
        description: description,
        category: category,
        price: price,
        offer: offer,
        photos: photos,
        data: data,
        virtualImage: virtual);
    _firestore
        .collection('admins')
        .doc(uId)
        .collection('products')
        .add(product.toMap())
        .then((value) {
      emit(AdminAddProductsSuccessState());
    }).catchError((error) {
      emit(AdminAddProductsErrorState(error.toString()));
      print('There is Error here : ${error.toString()}');
      print('There is product map here : ${product.toMap().toString()}');
    });
  }

  Future editProduct(
      {productUid,
      productName,
      description,
      category,
      brandName,
      price,
      offer,
      photos,
      context,
      virtual,
      required Map<String, Map<String, dynamic>> data}) async {
    emit(AdminEditProductsLoadingState());
    EasyLoading.show(status: 'Loading...');
    ProductModel product = ProductModel(
        productName: productName,
        description: description,
        category: category,
        price: price,
        offer: offer,
        photos: photos,
        data: data,
        virtualImage: virtual
    );
    _firestore
        .collection('admins')
        .doc(uId)
        .collection('products')
        .doc(productUid)
        .update(product.toMap())
        .then((value) {
      removePhotoFBStorage();
      EasyLoading.showSuccess('Uploading product Success!');
      emit(AdminEditProductsSuccessState());
      Navigator.pushNamed(context, HomeScreen.id);
    }).catchError((error) {
      emit(AdminEditProductsErrorState(error.toString()));
      print('There is Error here : ${error.toString()}');
      print('There is product map here : ${product.toMap().toString()}');
    });
  }

  Stream<List<ProductModel>> loadProducts() {
    emit(AdminGetProductsLoadingState());
    return _firestore
        .collection('admins')
        .doc(uId)
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        emit(AdminGetProductsSuccessState());
        print(doc.data());
        return ProductModel.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }

  Stream<List<UserOrderModel>> loadOrdersInProgress() {
    emit(AdminGetOrdersInProgressLoadingState());
    return _firestore
        .collection('admins')
        .doc(uId)
        .collection('orders')
        .doc('orders')
        .collection('In Progress')
        .orderBy('orderDate')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        emit(AdminGetOrdersInProgressSuccessState());
        print(doc.data());
        return UserOrderModel.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }

  Stream<List<UserOrderModel>> loadOrdersApprove() {
    emit(AdminGetOrdersApprovedLoadingState());
    return _firestore
        .collection('admins')
        .doc(uId)
        .collection('orders')
        .doc('orders')
        .collection('Approve')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        emit(AdminGetOrdersApprovedSuccessState());
        print(doc.data());
        return UserOrderModel.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }

  CancelOrder(docID, userOrderId, userId) {
    _firestore
        .collection('admins')
        .doc(uId)
        .collection('orders')
        .doc('orders')
        .collection('In Progress')
        .doc(docID)
        .delete()
        .then((value) {
      FirebaseFirestore.instance
          .collection('customers')
          .doc(userId)
          .collection('orders')
          .doc(userOrderId)
          .update({'orderState': 'Canceled'});

      emit(AdminCancelOrderSuccessState());
    });
  }

  approveOrder(order, docID, userOrderId, userId, orders) {
    _firestore
        .collection('admins')
        .doc(uId)
        .collection('orders')
        .doc('orders')
        .collection('Approve')
        .doc(docID)
        .set(order.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('customers')
          .doc(userId)
          .collection('orders')
          .doc(userOrderId)
          .update({'orderState': 'Approved'});
      bestSellerFunc(orders);
      _firestore
          .collection('admins')
          .doc(uId)
          .collection('orders')
          .doc('orders')
          .collection('In Progress')
          .doc(docID)
          .delete();

      emit(AdminApproveOrderSuccessState());
    });
  }

  bestSellerFunc(List<OrderModel> orders) {
    for (var order in orders) {
      var doc = _firestore
          .collection('admins')
          .doc(uId)
          .collection('products')
          .doc(order.productUid);
      int bestSeller = 0;
      doc.get().then((value) {
        print('firebase q ${value.data()!['bestSeller']}');
        bestSeller = value.data()!['bestSeller'] ?? 0;
        print('after $bestSeller');
        doc.update({'bestSeller': bestSeller + order.quantity});
      });
    }
  }

  deleteProduct(docID) {
    _firestore
        .collection('admins')
        .doc(uId)
        .collection('products')
        .doc(docID)
        .delete();
    emit(AdminRemoveProductsSuccessState());
  }

  deleteAdmin(docID) {
    _firestore.collection('admins').doc(uId).delete();
    emit(AdminRemoveProductsSuccessState());
  }

  addPhotosToList(photo) {
    this.photos.addAll(photo);
    emit(AddingProductPhotoSuccessState());
  }

  addWebPhotosToList(photo) {
    this.webPhotos.addAll(photo);
    emit(AddingProductWebPhotoSuccessState());
  }

  removePhotoFromList(index) {
    photos.removeAt(index);
    emit(RemoveProductPhotoSuccessState());
  }

  removeWebPhotoFromList(index) {
    webPhotos.removeAt(index);
    emit(RemoveProductWebPhotoSuccessState());
  }

  List<String> removeUrl = [];

  removePhotoFromUrlLocal(index) {
    removeUrl.add(PhotosURL[index]);
    PhotosURL.removeAt(index);
    emit(RemoveProductPhotolocalSuccessState());
  }

  removePhotoFBStorage() {
    removeUrl.forEach((element) {
      FirebaseStorage.instance.refFromURL(element).delete().then((value) {
        emit(RemoveProductPhotoFBSuccessState());
      }).catchError((error) {
        emit(RemoveProductPhotoFBErrorState(error.toString()));
      });
    });
  }

  String? SelecetedCategory;
  Set<String> colors = {};

  selectedCategory(category) {
    SelecetedCategory = category as String;
    print(SelecetedCategory.toString());
    emit(SelecetCategoryState());
  }

  addSizetoMap(size, Map color) {
    data['$size'] = {};
    emit(AddingSizeToMapState());
    print('$data');
  }

  addColortoMap(size, int color, String quantity) {
    data['$size']![color.toString()] = quantity;
    emit(AddingColorToMapState());
    print('$data');
  }

  removeColortoMap(size, color) {
    data['$size']!.remove(color);
    emit(RemoveColorToMapState());
    print('$data');
  }

  removeSize(size) {
    data.remove(size);
    emit(RemoveSizeState());
    print('$data');
  }

  List<String> PhotosURL = [];

  Future uploadProductPhoto() async {
    emit(UploadPhotostofirebaseLoadingState());
    EasyLoading.show(status: 'Loading...');
    for (var img in photos) {
      File file = File(img.path);
      String? downloadURL;
      try {
        await FirebaseStorage.instance
            .ref(
                'admins/products/productImage/${Uri.file(img.path).pathSegments.last}')
            .putFile(file);
        downloadURL = await FirebaseStorage.instance
            .ref(
                'admins/products/productImage/${Uri.file(img.path).pathSegments.last}')
            .getDownloadURL();
        if (downloadURL != null) {
          PhotosURL.add(downloadURL);
          print(PhotosURL);

          emit(UploadPhotostofirebaseSuccessState());
        }
      } on FirebaseException catch (e) {
        emit(UploadPhotostofirebaseErrorState());
        EasyLoading.showError('Failed with Error');
      }
    }
  }

  Future<bool> validatePassword({required String currentPassword}) async {
    bool connected = await checkInternetConnection();
    if (connected) {
      var fireBaseUser = FirebaseAuth.instance.currentUser;
      var authCredentials = EmailAuthProvider.credential(
          email: fireBaseUser!.email.toString(), password: currentPassword);
      try {
        var authResult =
            await fireBaseUser.reauthenticateWithCredential(authCredentials);
        emit(AdminVerifyPasswordSuccessState());
        return authResult.user != null;
      } on Exception catch (e) {
        emit(AdminVerifyPasswordErrorState(e.toString()));
        print(e);
        return false;
      }
    }
    return false;
  }

  void changePassword({required String password}) async {
    bool connected = await checkInternetConnection();
    if (connected) {
      emit(AdminChangePasswordLoadingState());
      FirebaseAuth.instance.currentUser!.updatePassword(password).then((value) {
        emit(AdminChangePasswordSuccessState());
      }).catchError((error) {
        emit(AdminChangePasswordErrorState(error.toString()));
        print(error.toString());
      });
    }
  }

  Future<bool> checkInternetConnection() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    bool res = (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile);
    if (res) {
      emit(AdminInternetConnectedState());
    } else {
      emit(AdminInternetNotConnectedState());
    }
    return res;
  }

  bool isPassword = true;
  bool isPassword2 = true;
  bool isPassword3 = true;
  IconData icon = Icons.visibility_outlined;
  IconData icon2 = Icons.visibility_outlined;
  IconData icon3 = Icons.visibility_outlined;

  void changePasswordVisibility(int num) {
    if (num == 1) {
      isPassword = !isPassword;
      icon = isPassword
          ? Icons.visibility_outlined
          : Icons.visibility_off_outlined;
    } else if (num == 2) {
      isPassword2 = !isPassword2;
      icon2 = isPassword2
          ? Icons.visibility_outlined
          : Icons.visibility_off_outlined;
    } else if (num == 3) {
      isPassword3 = !isPassword3;
      icon3 = isPassword3
          ? Icons.visibility_outlined
          : Icons.visibility_off_outlined;
    }
    emit(AdminChangePasswordVisibilityState());
  }

  void changeName({required String name}) async {
    bool connected = await checkInternetConnection();
    if (connected) {
      if (name == model!.name)
        emit(AdminChangeNameErrorState('New Name Mustn\'t be Same as old'));
      else {
        model!.name = name;

        emit(AdminChangeNameLoadingState());
        _firestore
            .collection('admins')
            .doc(uId)
            .update({'name': name}).then((value) {
          emit(AdminChangeNameSuccessState());
        }).catchError((error) {
          emit(AdminChangeNameErrorState(error.toString()));
          print(error.toString());
        });
      }
    }
  }

  Stream<List<adminModel>> getStores() {
    return _firestore.collection('admins').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        emit(AdminGetStoresSuccessState());
        print(doc.data());
        return adminModel.fromJson(doc.data());
      }).toList();
    });
  }

  void getData(String adminUId) {
    emit(AdminGetAdminLoadingState());
    FirebaseFirestore.instance
        .collection('admins')
        .doc(adminUId)
        .get()
        .then((value) {
      model = adminModel.fromJson(value.data()!);
      emit(AdminGetAdminSuccessState());
      print(value.data());
    }).catchError((error) {
      emit(AdminGetAdminErrorState(error.toString()));
    });
  }

  Stream<List<RequestModel>> getRequests() {
    return _firestore.collection('requests').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        emit(AdminGetRequestsSuccessState());
        print(doc.data());
        return RequestModel.fromJson(doc.data());
      }).toList();
    });
  }

  Stream<RequestModel> checkRequest(String? uid) {
    return _firestore.collection('requests').doc(uid).snapshots().map((event) {
      return RequestModel.fromJson(event.data()!);
    });
  }

  Future adminRegister({
    required String? name,
    required String? phone,
    required String? email,
    required String? password,
    required String? brandName,
    required String? brandPhone,
    required String? image,
    required String? uid,
  }) async {
    emit(AdminRegisterLoadState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      print(value.user!.email);
      adminCreate(
        name: name,
        phone: phone,
        email: email,
        brandName: brandName,
        brandPhone: brandPhone,
        uId: value.user!.uid,
        uid: uid,
        image: image,
      );
    }).catchError((error) {
      print(error.toString());
      emit(AdminRegisterErrorState(error.toString()));
    });
  }

  void adminCreate(
      {required String? name,
      required String? phone,
      required String? email,
      required String? brandName,
      required String? brandPhone,
      required String? uId,
      required String? uid,
      required String? image}) {
    adminModel model = adminModel(
        name: name,
        phone: phone,
        email: email,
        brandName: brandName,
        brandPhone: brandPhone,
        uId: uId,
        image: image);
    FirebaseFirestore.instance
        .collection('admins')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('requests')
          .doc(uid)
          .delete()
          .then((value) {
        emit(AdminCreateSuccessState(uId!));
      }).catchError((error) {
        print(error.toString());
        emit(AdminCreateErrorState(error.toString()));
      });
    }).catchError((error) {
      print(error.toString());
      emit(AdminCreateErrorState(error.toString()));
    });
  }

  Future<void> send(String email) async {
    final Email _email = Email(
      body:
          'we pleased to inform you that\'s your account has been approved \n Login Now and Go On',
      subject: 'Shoppy Request Approval',
      recipients: [email],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(_email);
      emit(AdminSendEmailSuccessState());
    } catch (error) {
      print(error);
      emit(AdminSendEmailErrorState(error.toString()));
    }
  }

  Future acceptRequest({
    required RequestModel? request,
  }) async {
    adminRegister(
            name: request!.name,
            phone: request.phone,
            email: request.email,
            password: request.password,
            brandName: request.brandName,
            brandPhone: request.brandPhone,
            uid: request.uId,
            image: request.image)
        .then((value) {
      send(request.email!);
    });
  }

  Future refuseRequest({
    required RequestModel? request,
  }) async {
    FirebaseFirestore.instance
        .collection('requests')
        .doc(request!.uId)
        .delete()
        .then((value) {
      emit(AdminRefuseRequestSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AdminRefuseRequestErrorState(error.toString()));
    });
  }

  bool switchVirtualImage = false;

  void switchboolval(bool val) {
    switchVirtualImage = val;
    print(switchVirtualImage);
    emit(SwitchVirtualImageSuccessState());
  }

  Map<int, XFile> virtualPhoto = {};

  void getVirtualImages(color, image) {
    virtualPhoto[color] = image as XFile;

    print(virtualPhoto);
    emit(AddingVirtualImageToMapSuccessState());
  }

  void removeVirtualPhoto(color) {
    virtualPhoto.remove(color);
    emit(RemovingVirtualImageToMapSuccessState());
  }

  Map<String, String> virphotos = {};

  Future uploadVirtualPhotoStorage() async {
    emit(UploadVirtualPhotostofirebaseLoadingState());
    EasyLoading.show(status: 'Loading...');
    virtualPhoto.forEach((key, value) async {
      File file = File(value.path);
      String? downloadURL;
      try {
        await FirebaseStorage.instance
            .ref(
                'admins/products/virtualImage/${Uri.file(value.path).pathSegments.last}')
            .putFile(file);
        downloadURL = await FirebaseStorage.instance
            .ref(
                'admins/products/virtualImage/${Uri.file(value.path).pathSegments.last}')
            .getDownloadURL();
        if (downloadURL != null) {
          virphotos[key.toString()] = downloadURL;
          print(virphotos);

          emit(UploadVirtualPhotostofirebaseSuccessState());
        }
      } on FirebaseException catch (e) {
        emit(UploadVirtualPhotostofirebaseErrorState());
        EasyLoading.showError('Failed with Error');
      }
    });
  }
}
