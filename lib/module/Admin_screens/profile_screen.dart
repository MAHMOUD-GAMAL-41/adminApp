import 'package:admin/module/Admin_screens/reset_password.dart';
import 'package:admin/shared/Styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../homescreen/cubit/cubit.dart';
import '../homescreen/cubit/states.dart';
import 'account_info.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit,AdminStates>(
      listener: (context,state){},
      builder: (context,state){
        User? user = FirebaseAuth.instance.currentUser;
        return Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.orange,
              title: Text('Profile'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 75.0,
                      backgroundImage:  AdminCubit.get(context).model!.image != null
                          ? NetworkImage( AdminCubit.get(context).model!.image.toString()) as ImageProvider
                          : AssetImage('assets/images/default_login.jpg'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      AdminCubit.get(context).model!.name.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    MaterialButton(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      elevation: 1.0,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>AccountInfoScreen() ));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account info',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined,color: Theme.of(context).iconTheme.color,),
                        ],
                      ),
                    ),

                    MaterialButton(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      elevation: 1.0,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>ResetPasswordScreen()));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Change Password',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined,color: Theme.of(context).iconTheme.color,),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            )
        );
      },
    );
  }
}