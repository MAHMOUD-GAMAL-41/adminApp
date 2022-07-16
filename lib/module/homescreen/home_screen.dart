
import 'package:admin/module/Admin_screens/add_product.dart';
import 'package:admin/module/Admin_screens/approve_orders.dart';
import 'package:admin/module/Admin_screens/dashboard_screen.dart';
import 'package:admin/module/Admin_screens/inprogress_orders.dart';
import 'package:admin/module/Admin_screens/profile_screen.dart';
import 'package:admin/module/Admin_screens/view_product.dart';
import 'package:admin/module/homescreen/cubit/cubit.dart';
import 'package:admin/module/homescreen/cubit/states.dart';
import 'package:admin/shared/Styles/colors.dart';
import 'package:admin/shared/components/component.dart';
import 'package:admin/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../stores_screen/stores_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {},
        builder: (context, state) {
          bool? mainAdmin=CacheHelper.getData(key: 'IsAdmin');
          if(mainAdmin!=null){
            return AdminCubit.get(context).model == null
                ? const Center(child: CircularProgressIndicator())
                : AdminScaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: (){
                      Navigator.pushNamed(context, StoresScreen.id);
                    },
                    icon: const Icon(Icons.arrow_forward,color: Colors.white,),
                  ),
                ],
                foregroundColor: Colors.white,
                title: const Text('Admin Panel',
                    style: TextStyle(color: Colors.white)),
              ),
              sideBar: SideBar(

                borderColor:  MyColors.purpleLight,
                header: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  height: 100,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        height: double.infinity,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 0),
                                spreadRadius: 1,
                                blurRadius: 4
                            ),
                          ],
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 37,
                          backgroundColor: MyColors.deepOrange,
                          child: InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor: MyColors.lightOrange,
                              backgroundImage: state
                              is! AdminGetAdminLoadingState
                                  ? NetworkImage(AdminCubit.get(context)
                                  .model!
                                  .image as String)
                                  : const AssetImage(
                                  'assets/images/default_login.jpg')
                              as ImageProvider,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 90,
                            child: Text(
                              AdminCubit.get(context)
                                  .model!
                                  .name
                                  .toString()
                                  .toUpperCase(),
                              style: TextStyle(

                                  color: MyColors.lightOrange,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              ),
                              overflow: TextOverflow.ellipsis,maxLines: 1,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 70,
                            child: Text(
                              AdminCubit.get(context)
                                  .model!
                                  .brandName
                                  .toString(),
                              style: TextStyle(
                                color: MyColors.purpleLight,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                footer: Container(
                  padding: EdgeInsets.only(bottom: 50, right: 5, left: 5),
                  width: double.infinity,
                  color: Colors.white,
                  child: BuildButton('Sign Out', () async{
                    AdminCubit.get(context).mainAdminSignOut(context);
                  }, context),
                ),
                backgroundColor: Colors.white,
                iconColor: MyColors.lightOrange,
                textStyle: const TextStyle(color: MyColors.lightOrange),
                activeIconColor: MyColors.lightOrange,
                activeBackgroundColor: MyColors.lightOrange,
                items:  [
                  AdminMenuItem(
                    title: 'Dashboard',
                    route: DashboardScreen.id,
                  ),
                  AdminMenuItem(
                    title: 'Manage Products',
                    children: [
                      AdminMenuItem(
                          title: 'View Product',
                          route: ViewProductScreen.id,
                          icon: Icons.edit),
                    ],
                  ),
                  AdminMenuItem(
                    title: 'Manage Orders',
                    children: [
                      AdminMenuItem(
                        title: 'Approved Orders',
                        route: ApprovedOrdersScreen.id,
                        icon: Icons.archive_rounded,
                      )
                    ],
                  ),
                ],
                selectedRoute: HomeScreen.id,
                onSelected: (item) {
                  AdminCubit.get(context).currentScreen(item);
                },
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),

                child: AdminCubit.get(context).selectedScreen2,
              ),
            );
          }
          return AdminCubit.get(context).model == null
              ? Center(child: CircularProgressIndicator())
              : AdminScaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              title: Text('Admin Panel',
                  style: TextStyle(color: Colors.white)),
              // actions: [
              //   Stack(
              //     children: [
              //       IconButton(
              //         onPressed: () {},
              //         icon: const Icon(Icons.notifications_none_sharp),
              //         color: Colors.white,
              //         iconSize: 30,
              //       ),
              //       Positioned(
              //         right: 6,
              //         top: 6,
              //         child: CircleAvatar(
              //           backgroundColor: Colors.pink,
              //           radius: 8,
              //           child: Text(
              //             '3',
              //             style:
              //                 TextStyle(fontSize: 10, color: Colors.white),
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ],
            ),
            sideBar: SideBar(

              borderColor:  MyColors.purpleLight,
              header: Container(

                decoration: BoxDecoration(color: Colors.white),
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(

                      margin: const EdgeInsets.all(10),
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 0),
                              spreadRadius: 1,
                              blurRadius: 4),
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 37,
                        backgroundColor: MyColors.deepOrange,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context)=>ProfileScreen() ));

                          },
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: MyColors.lightOrange,
                            backgroundImage: state
                            is! AdminGetAdminLoadingState
                                ? NetworkImage(AdminCubit.get(context)
                                .model!
                                .image as String)
                                : AssetImage(
                                'assets/images/default_login.jpg')
                            as ImageProvider,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 135    ,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(

                            AdminCubit.get(context)
                                .model!
                                .name
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(

                                color: MyColors.lightOrange,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 70,
                            child: Text(
                              AdminCubit.get(context)
                                  .model!
                                  .brandName
                                  .toString(),
                              style: TextStyle(
                                color: MyColors.purpleLight,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              footer: Container(
                padding: EdgeInsets.only(bottom: 50, right: 5, left: 5),
                width: double.infinity,
                color: Colors.white,
                child: BuildButton('Sign Out', () async{
                  bool? mainAdmin=await CacheHelper.getData(key: 'IsAdmin');
                  print("main admmmmmmmmmmmmmmmmmmaaaaaaaain"+mainAdmin.toString());
                  if(mainAdmin==true){
                    AdminCubit.get(context).mainAdminSignOut(context);
                  }
                  else{
                    AdminCubit.get(context).signOut(context);
                  }
                }, context),
              ),
              backgroundColor: Colors.white,
              iconColor: MyColors.lightOrange,
              textStyle: TextStyle(color: MyColors.lightOrange),
              activeIconColor: MyColors.lightOrange,
              activeBackgroundColor: MyColors.lightOrange,
              items: [
                AdminMenuItem(
                  title: 'Dashboard',
                  route: DashboardScreen.id,
                ),
                AdminMenuItem(
                  title: 'Manage Products',
                  children: [
                    AdminMenuItem(
                      title: 'Add Product',
                      route: AddProductScreen.id,
                      icon: Icons.add,
                    ),
                    AdminMenuItem(
                        title: 'View Product',
                        route: ViewProductScreen.id,
                        icon: Icons.edit),
                  ],
                ),
                AdminMenuItem(
                  title: 'Manage Orders',
                  children: [
                    AdminMenuItem(
                        title: 'Inprogress Orders',
                        route: InprogressOrdersScreen.id,
                        icon: Icons.bookmark_border
                    ),
                    AdminMenuItem(
                      title: 'Approved Orders',
                      route: ApprovedOrdersScreen.id,
                      icon: Icons.archive_rounded,
                    )
                  ],                    ),
              ],
              selectedRoute: HomeScreen.id,
              onSelected: (item) {
                AdminCubit.get(context).currentScreen(item);
              },
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),

              child: AdminCubit.get(context).selectedScreen2,
            ),
          );
        });
  }
}
