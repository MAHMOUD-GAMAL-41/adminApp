
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_states.dart';

class AdminLoginCubit extends Cubit<AdminLoginStates> {
  AdminLoginCubit() : super(AdminLoginInitState());

  static AdminLoginCubit get(context) => BlocProvider.of(context);

  void adminLogin({required email, required password}) {
    emit(AdminLoginLoadState());
    if (email=='admin@admin.com'&&password=='123456789'){
      emit(MainAdminLoginSuccessState());
    }
    else{
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print(value.user!.email);
        print(value.user!.uid);

        emit(AdminLoginSuccessState(value.user!.uid));
      }).catchError((error) {
        print(error.toString());
        emit(AdminLoginErrorState(error.toString()));
      });
    }
  }


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AdminChangePasswordVisibilityState());
  }

  void resetPassword({
    required String email
  })async{
    bool connected=await checkInternetConnection();
    if(connected) {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(
          email: email,
        )
            .then((value) => emit(AdminResetPasswordSuccessState()));
      } on FirebaseAuthException catch (e) {
        String message = '';
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else {
          message = e.message.toString();
        }
        emit(AdminResetPasswordErrorState(message));
      } catch (e) {
        emit(AdminResetPasswordErrorState(e.toString()));
      }
    }
  }
  Future<bool> checkInternetConnection() async{
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    bool res=(result == ConnectivityResult.wifi||result ==ConnectivityResult.mobile);
    if(res){
      emit(AdminInternetConnectedState());
    }
    else{
      emit(AdminInternetNotConnectedState());
    }
    return res;
  }

}
