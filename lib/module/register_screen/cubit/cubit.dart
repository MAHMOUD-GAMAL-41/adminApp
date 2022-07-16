// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:admin/models/request_model.dart';
import 'package:admin/module/register_screen/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AdminRegisterCubit extends Cubit<AdminRegisterStates> {
  AdminRegisterCubit() : super(AdminRegisterInitState());

  static AdminRegisterCubit get(context) => BlocProvider.of(context);

  void adminRequest({
    required String? name,
    required String? phone,
    required String? email,
    required String? brandName,
    required String? brandPhone,
    required String? password,
    required String? image,
  }) {
    var date = DateFormat.d().add_yMMM().add_Hm().format(DateTime.now());


    RequestModel requestModel =
    RequestModel(
      name: name,
      phone: phone,
      email: email,
      brandName: brandName,
      brandPhone: brandPhone,
      image: image,
      requestDate: date,
      password: password,
    );

    var doc = FirebaseFirestore.instance.collection('requests').doc();
    requestModel.setUID(doc.id);
    doc.set(requestModel.toMap()).then((value) {
      emit(AdminSendRequestSuccessState(''));
    }).catchError((error) {
      print(error.toString());
      emit(AdminSendRequestErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  bool isPasswordEightCharacter = false;
  bool isPasswordOneNumber = false;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AdminRegisterChangePasswordVisibilityState());
  }

  void onPasswordChange(String password) {
    final numricRegex = RegExp(r'[0-9]');
    isPasswordEightCharacter = false;
    if (password.length >= 8) isPasswordEightCharacter = true;

    isPasswordOneNumber = false;
    if (numricRegex.hasMatch(password)) isPasswordOneNumber = true;

    emit(AdminRegisterChangePasswordState());
  }

  Future getProfileImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedGallerySuccessState());
    } else {
      emit(ProfileImagePickedGalleryErrorState());
      print('No Image Selected.');
    }
  }

  File? profileImage;
  final ImagePicker picker = ImagePicker();

  Future getProfileImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      emit(ProfileImagePickedCameraSuccessState());
      profileImage = File(pickedFile.path);
      print(pickedFile.path
          .toString()
          .substring(pickedFile.path.lastIndexOf('/') + 1));
    } else {
      emit(ProfileImagePickedCameraErrorState());
      print('No Image Selected.');
    }
  }


  Future uploadProfileImage(String? name,
      String? phone,
      String? email, String? password,
      String? brandName,
      String? brandPhone,) async {
    emit(SocialUploadProfileImageLoadingState());
    EasyLoading.show(status: 'Loading...');

    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('admins/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // print(value);

        adminRequest(name: name,
            phone: phone,
            email: email,
            brandName: brandName,
            brandPhone: brandPhone,
            password: password,
            image: value);
        emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialGetdProfileImageUrlErrorState(error.toString()));
        print(error.toString());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState(error.toString()));
      print(error.toString());
    });
  }

  void removeProfileImage() {
    profileImage = null;
    emit(ProfileImageRemoveState());
  }
}
