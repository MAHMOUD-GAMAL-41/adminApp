import 'dart:io';

import 'package:admin/module/login_screen/login_screen.dart';
import 'package:admin/shared/Styles/colors.dart';
import 'package:admin/shared/components/component.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  static const String id = 'register-screen';

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var brandPhoneController = TextEditingController();

  var brandNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminRegisterCubit(),
      child: BlocConsumer<AdminRegisterCubit, AdminRegisterStates>(
        listener: (context, state) {
          if (state is AdminRegisterErrorState) {
            showToast(text: state.error.toString(), state: ToastStates.ERROR);
          } else if (state is AdminSendRequestSuccessState) {
            defaultSnackBar(
                context: context,
                title: 'wait for Acceptance email',
                color: Colors.green);
            Navigator.pushReplacementNamed(context, LoginScreen.id);
          }
          if (state is SocialUploadProfileImageSuccessState) {
            showToast(
                text: 'Picture set successfully', state: ToastStates.SUCCESS);
          } else if (state is SocialUploadProfileImageErrorState) {
            showToast(text: state.error.toString(), state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          final File? profileImage =
              AdminRegisterCubit.get(context).profileImage;

          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  FadeInDown(
                      delay: Duration(milliseconds: 1000),
                      duration: Duration(milliseconds: 1500),
                      child: BuildLogo(context, 'Register', .3)),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 15),
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.orange,
                            child: CircleAvatar(
                                radius: 75,
                                backgroundImage: profileImage == null
                                    ? const AssetImage(
                                        'assets/images/default_login.jpg')
                                    : FileImage(profileImage) as ImageProvider),
                          ),
                        ),
                        Positioned(
                          bottom: 25,
                          right: -15,
                          child: RawMaterialButton(
                            padding: const EdgeInsets.all(10),
                            shape: const CircleBorder(),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Choose option',
                                        style: TextStyle(
                                            color: MyColors.lightOrange,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                AdminRegisterCubit.get(context)
                                                    .getProfileImageCamera();
                                                Navigator.pop(context);
                                              },
                                              splashColor: MyColors.orange,
                                              child: Row(
                                                children: const [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Icon(
                                                      Icons.camera,
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Camera',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                AdminRegisterCubit.get(context)
                                                    .getProfileImageGallery();
                                                Navigator.pop(context);
                                              },
                                              splashColor: MyColors.orange,
                                              child: Row(
                                                children: const [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Icon(
                                                      Icons.image,
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Gallery',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                AdminRegisterCubit.get(context)
                                                    .removeProfileImage();
                                                Navigator.pop(context);
                                              },
                                              splashColor: MyColors.orange,
                                              child: Row(
                                                children: const [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Icon(
                                                      Icons.remove_circle,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Remove',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            elevation: 10,
                            fillColor: Colors.orange,
                            child: const Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          BuildTextForm(
                            hint: const Text('Name'),
                            icon: Icons.person,
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your Name ';
                              }
                            },
                          ),
                          BuildTextForm(
                            hint: const Text('phone'),
                            icon: Icons.phone,
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your Phone Number';
                              }
                            },
                          ),
                          BuildTextForm(
                            hint: const Text('Email'),
                            icon: Icons.email,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your Email Address';
                              }
                            },
                          ),
                          BuildTextForm(
                            onChanged: (password) {
                              AdminRegisterCubit.get(context)
                                  .onPasswordChange(password);
                            },
                            hint: const Text('Password'),
                            icon: Icons.lock,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Password is empty';
                              }
                              if (AdminRegisterCubit.get(context)
                                      .isPasswordEightCharacter ==
                                  false) return 'Password is too short';
                              if (AdminRegisterCubit.get(context)
                                      .isPasswordOneNumber ==
                                  false)
                                return 'Password should have at least one number';
                            },
                            obscureText:
                                AdminRegisterCubit.get(context).isPassword,
                            suffixIcon: IconButton(
                                color:
                                    AdminRegisterCubit.get(context).isPassword
                                        ? Colors.black38
                                        : MyColors.orange,
                                visualDensity: const VisualDensity(
                                    horizontal: -4, vertical: -4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                onPressed: () {
                                  AdminRegisterCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                icon: AdminRegisterCubit.get(context).isPassword
                                    ? const Icon(Icons.visibility_off_outlined)
                                    : const Icon(
                                        Icons.visibility_outlined,
                                      )),
                          ),
                          passwordController.text.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: AdminRegisterCubit.get(
                                                            context)
                                                        .isPasswordOneNumber
                                                    ? MyColors.orange
                                                    : Colors.transparent,
                                                border: AdminRegisterCubit.get(
                                                            context)
                                                        .isPasswordOneNumber
                                                    ? Border.all(
                                                        color:
                                                            Colors.transparent)
                                                    : Border.all(
                                                        color: Colors
                                                            .grey.shade400),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: const Center(
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Contains at least 1 number',
                                            style: TextStyle(
                                                color: Colors.grey.shade600),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 500),
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: AdminRegisterCubit.get(
                                                            context)
                                                        .isPasswordEightCharacter
                                                    ? MyColors.orange
                                                    : Colors.transparent,
                                                border: AdminRegisterCubit.get(
                                                            context)
                                                        .isPasswordEightCharacter
                                                    ? Border.all(
                                                        color:
                                                            Colors.transparent)
                                                    : Border.all(
                                                        color: Colors
                                                            .grey.shade400),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: const Center(
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Contains at least 8 characters',
                                            style: TextStyle(
                                                color: Colors.grey.shade600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(
                                  height: 0,
                                ),
                          BuildTextForm(
                            hint: const Text('Brand Name'),
                            icon: Icons.home,
                            controller: brandNameController,
                          ),
                          BuildTextForm(
                            hint: const Text('Brand Phone'),
                            icon: Icons.phone,
                            controller: brandPhoneController,
                            keyboardType: TextInputType.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your Phone Number';
                              }
                            },
                          ),
                          FadeInUp(
                            delay: Duration(milliseconds: 1000),
                            duration: Duration(milliseconds: 1500),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                  child: state is! AdminRegisterLoadState
                                      ? BuildButton('REGISTER', () async {
                                          if (profileImage == null) {
                                            return ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Profile image not selected'),
                                              backgroundColor: Colors.red,
                                            ));
                                          } else {
                                            if (formKey.currentState!
                                                .validate()) {
                                              AdminRegisterCubit.get(context)
                                                  .uploadProfileImage(
                                                nameController.text,
                                                phoneController.text,
                                                emailController.text,
                                                passwordController.text,
                                                brandNameController.text,
                                                brandPhoneController.text,
                                              );
                                            }
                                          }

                                          if (state
                                              is SocialUploadProfileImageLoadingState) {
                                            SizedBox(
                                              height: 5.0,
                                            );
                                          }
                                          if (state
                                              is SocialUploadProfileImageLoadingState) {
                                            LinearProgressIndicator();
                                          }
                                        }, context)
                                      : const CircularProgressIndicator()),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, LoginScreen.id);
                                },
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      color: MyColors.orange, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
