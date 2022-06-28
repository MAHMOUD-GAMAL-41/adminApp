// import 'package:admin/layout/responsive/responsive.dart';
// import 'package:admin/module/homescreen/cubit/cubit.dart';
// import 'package:admin/module/homescreen/cubit/states.dart';
// import 'package:admin/shared/Styles/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'component.dart';
//
//
//
// class DrawerPage extends StatelessWidget {
//   const DrawerPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AdminCubit, AdminStates>(
//         builder: (context, state) => Drawer(
//           backgroundColor: MyColors.purpleLight.withOpacity(.5),
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 children: [
//
//                   ListTile(
//                     title: const Text(
//                       'Admin Menu ',
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                     trailing: ResponsiveLayout.isComputer(context)
//                         ? null
//                         : IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon:const Icon(
//                           Icons.close,
//                           color: Colors.white,
//                         )),
//                   ),
//                   ...List.generate(
//                     AdminCubit.get(context).drawerButtonNames.length,
//                         (index) => Column(
//                       children: [
//                         Container(
//                           decoration: index == AdminCubit.get(context).drawerCurrentIndex
//                               ? BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             gradient: const LinearGradient(colors: [
//                               MyColors.deepOrange,
//                               MyColors.lightOrange
//                             ]),
//                           ): null,
//                           child: ListTile(
//                             title: Text(
//                               AdminCubit.get(context).drawerButtonNames[index].title,
//                               style:const TextStyle(color: Colors.white),
//                             ),
//                             leading: Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Icon(
//                                 AdminCubit.get(context).drawerButtonNames[index].icon,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             onTap:()=> AdminCubit.get(context).changeDrawerIndex(index),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                           ),
//                         ),
//                         const Divider(color: Colors.white,thickness: 2  ,),
//                       ],
//                     ),
//                   ),
//                   BuildButton('Sign Out', (){AdminCubit.get(context).signOut(context);}
//                   , context),
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//         listener: (context, state) {});
//   }
// }
