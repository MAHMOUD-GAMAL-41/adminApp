import 'package:admin/module/login_screen/cubit/login_cubit.dart';
import 'package:admin/module/login_screen/cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/component.dart';
import '../../shared/components/constant.dart';


class ForgetPasswordScreen extends StatelessWidget {
  final formKey=GlobalKey<FormState>();
  final TextEditingController emailController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AdminLoginCubit(),
      child: BlocConsumer<AdminLoginCubit,AdminLoginStates>(
          listener: (context,state){},
          builder:(context,state){
            return SafeArea(child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Forget Password',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                centerTitle: true,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal:20),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'If you Want to Recover Your Account, then please provide your email Id Below..',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Image.asset(
                          'assets/images/forgetpass.png',
                          width: 250,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.text,
                          validate:  (value){
                            if(!RegExp(validationEmail).hasMatch(value!)){
                              return 'Enter Valid Email';
                            }
                            return null;
                          },
                          label: 'Email',
                          context: context,
                          prefix:Icons.search,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        BuildButton('SEND', (){
                          if(formKey.currentState!.validate()){
                            String email=emailController.text.toString().trim();
                            AdminLoginCubit.get(context).resetPassword(email: email);
                          }
                        }, context)
                      ],
                    ),
                  ),
                ),
              ),
            ));
          }

      ),
    );
  }
}