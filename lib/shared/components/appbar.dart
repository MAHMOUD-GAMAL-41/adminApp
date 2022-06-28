// import 'package:admin/layout/responsive/responsive.dart';
// import 'package:admin/module/homescreen/cubit/cubit.dart';
// import 'package:admin/module/homescreen/cubit/states.dart';
// import 'package:admin/shared/Styles/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class AppBarWidget extends StatelessWidget {
//   const AppBarWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     var cubit = AdminCubit.get(context);
//     return BlocConsumer<AdminCubit, AdminStates>(
//         builder: (context, state) => Container(
//               color: MyColors.purpleLight,
//               child: Row(
//                 children: [
//                   if (ResponsiveLayout.isComputer(context))
//                     Container(
//                       margin: const EdgeInsets.all(10),
//                       height: double.infinity,
//                       decoration:const BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.black45,
//                               offset: Offset(0, 0),
//                               spreadRadius: 1,
//                               blurRadius: 10),
//                         ],
//                         shape: BoxShape.circle,
//                       ),
//                       child: CircleAvatar(
//                         backgroundColor: MyColors.deepOrange,
//                         child: Image.asset('assets/images/png1.png'),
//                       ),
//                     )
//                   else
//                     IconButton(
//                         onPressed: () {
//                           Scaffold.of(context).openDrawer();
//                         },
//                         iconSize: 30,
//                         icon:const Icon(Icons.menu)),
//                  const SizedBox(
//                     width: 10,
//                   ),
//                   const Spacer(),
//                    if (ResponsiveLayout.isComputer(context))
//                   //   ...List.generate(
//                   //     cubit.appBarButtonNames.length,
//                   //     (index) => TextButton(
//                   //       onPressed: () =>
//                   //           cubit.changeAppBarSelectedButton(index),
//                   //       child: Padding(
//                   //         padding:const EdgeInsets.all(20),
//                   //         child: Column(
//                   //           mainAxisAlignment: MainAxisAlignment.center,
//                   //           crossAxisAlignment: CrossAxisAlignment.center,
//                   //           children: [
//                   //             Text(
//                   //               cubit.appBarButtonNames[index],
//                   //               style: TextStyle(
//                   //                   color: cubit.appBarSelectedButton == index
//                   //                       ? Colors.white
//                   //                       : Colors.white70),
//                   //             ),
//                   //             Container(
//                   //               margin: EdgeInsets.all(5),
//                   //               width: 60,
//                   //               height: 2,
//                   //               decoration: BoxDecoration(
//                   //                   gradient:
//                   //                       cubit.appBarSelectedButton == index
//                   //                           ? const LinearGradient(colors: [
//                   //                               MyColors.deepOrange,
//                   //                               MyColors.lightOrange
//                   //                             ])
//                   //                           : null),
//                   //             ),
//                   //           ],
//                   //         ),
//                   //       ),
//                   //     ),
//                   //   )
//                   else
//                     Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           // Text(
//                           //   cubit.appBarButtonNames[cubit.appBarSelectedButton],
//                           //   style:const TextStyle(color: Colors.white,fontSize: 18),
//                           // ),
//                           Container(
//                             margin: const EdgeInsets.all(5),
//                             width: 85,
//                             height: 2,
//                             decoration:const BoxDecoration(
//                                 gradient: LinearGradient(colors: [
//                               MyColors.deepOrange,
//                               MyColors.lightOrange
//                             ])),
//                           ),
//                         ],
//                       ),
//                     ),
//                   const Spacer(),
//                   IconButton(
//                     onPressed: () {},
//                     icon:const Icon(Icons.search),
//                     color: Colors.white,
//                     iconSize: 30,
//                   ),
//                   Stack(
//                     children: [
//                       IconButton(
//                         onPressed: () {},
//                         icon:const Icon(Icons.notifications_none_sharp),
//                         color: Colors.white,
//                         iconSize: 30,
//                       ),
//                       Positioned(
//                         right: 6,
//                         top: 6,
//                         child: CircleAvatar(
//                           backgroundColor: Colors.pink,
//                           radius: 8,
//                           child: Text(
//                             '3',
//                             style: TextStyle(fontSize: 10, color: Colors.white),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                     Container(
//
//                       margin:const EdgeInsets.all(10),
//                       height: double.infinity,
//                       decoration:const BoxDecoration(
//
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.black45,
//                               offset: Offset(0, 0),
//                               spreadRadius: 1,
//                               blurRadius: 4),
//                         ],
//                         shape: BoxShape.circle,
//                       ),
//                       child: CircleAvatar(
//                         radius: 25,
//                         backgroundColor: MyColors.deepOrange,
//
//                         child:  InkWell(
//                           onTap: (){
//                             print(AdminCubit.get(context).model.image);
//                           },
//                           child: CircleAvatar(
//                             radius: 23,
//                             backgroundImage: state is! AdminGetAdminLoadingState ?NetworkImage(AdminCubit.get(context).model.image as String) : AssetImage('assets/images/default_login.jpg')as ImageProvider,
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//         listener: (context, state) {});
//   }
// }
