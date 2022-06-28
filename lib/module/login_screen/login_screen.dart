
import 'package:admin/module/homescreen/cubit/cubit.dart';
import 'package:admin/module/homescreen/home_screen.dart';
import 'package:admin/module/register_screen/register_screen.dart';
import 'package:admin/module/stores_screen/stores_screen.dart';
import 'package:admin/shared/Styles/colors.dart';
import 'package:admin/shared/components/component.dart';
import 'package:admin/shared/components/constant.dart';
import 'package:admin/shared/network/local/cache_helper.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String id ='login-screen';

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminLoginCubit(),
      child: BlocConsumer<AdminLoginCubit, AdminLoginStates>(
          listener: (context, state) {
            if (state is AdminLoginErrorState) {
              showToast(text: 'you don\'t have an account or your account isn\'t reviewed yet', state: ToastStates.ERROR);
            }
            if (state is AdminLoginSuccessState) {
              CacheHelper.saveData(key:'uID', value: state.uID).then((value) async{
                uId=await CacheHelper.getData(key: 'uID');
                AdminCubit.get(context).getAdminData().then((value) {
                  if(AdminCubit.get(context).model!=null){
                    Navigator.pushReplacementNamed(context, HomeScreen.id);
                  }
                });
              });
            }
            if (state is MainAdminLoginSuccessState) {
              CacheHelper.saveData(key:'uID', value: 'mainAdmin').then((value) {
                uId=CacheHelper.getData(key: 'uID');
                print(uId);
                CacheHelper.saveData(key:'IsAdmin', value: true).then((value){
                  Navigator.pushReplacementNamed(context, StoresScreen.id);
                });
              });
            }
          },
          builder: (context, state) => Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      FadeInDown(
                          delay: Duration(milliseconds: 1000),
                          duration: Duration(milliseconds: 1500),
                          child: BuildLogo(context, 'Login', .4)),
                      Form(
                        key: formKey,
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 40),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              BuildTextForm(
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your Email Address';
                                    }
                                  },
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  hint: Text('Email'),
                                  icon: Icons.email),
                              BuildTextForm(
                                  suffixIcon: IconButton(
                                      color: AdminLoginCubit.get(context)
                                              .isPassword
                                          ? Colors.black38
                                          : MyColors.orange,
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      onPressed: () {
                                        AdminLoginCubit.get(context)
                                            .changePasswordVisibility();
                                      },
                                      icon: AdminLoginCubit.get(context)
                                              .isPassword
                                          ? Icon(Icons.visibility_off_outlined)
                                          : Icon(
                                              Icons.visibility_outlined,
                                            )),
                                  controller: passwordController,
                                  obscureText:
                                      AdminLoginCubit.get(context).isPassword,
                                  keyboardType: TextInputType.visiblePassword,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Password is too short';
                                    }
                                  },
                                  hint: Text('Password'),
                                  icon: Icons.vpn_key),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordScreen()));
                                },
                                child: Container(
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.only(top: 15),
                                    child: Text(
                                      'Forget Password ?',
                                      style: TextStyle(
                                          color: MyColors.orange,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              FadeInUp(
                                delay: Duration(milliseconds: 1000),
                                duration: Duration(milliseconds: 1500),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 40),
                                  child: Center(
                                    child: BuildButton('LOGIN', () {
                                      if (formKey.currentState!.validate()) {
                                        AdminLoginCubit.get(context).adminLogin(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    }, context),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, RegisterScreen.id);
                                    },
                                    child: Text(
                                      'REGISTER',
                                      style: TextStyle(
                                          color: MyColors.orange, fontSize: 14),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}
