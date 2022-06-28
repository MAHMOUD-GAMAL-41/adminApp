import 'package:admin/module/homescreen/cubit/cubit.dart';
import 'package:admin/module/homescreen/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/component.dart';
import '../../shared/components/constant.dart';

class MainAdminScreen extends StatelessWidget {
  static const String id = 'MainAdmin-screen';
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('admins').snapshots();
  final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
      .collection('admins')
      .doc(uId)
      .collection('products')
      .snapshots();
  final Stream<QuerySnapshot> _orderStream = FirebaseFirestore.instance
      .collection('admins')
      .doc(uId)
      .collection('orders')
      .doc('orders')
      .collection('Approve')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      AdminCubit.get(context)
                          .firebaseAnalytic('Total Users ', _usersStream),
                      AdminCubit.get(context)
                          .firebaseAnalytic('Total Products ', _productStream),
                      AdminCubit.get(context)
                          .firebaseAnalytic('Total Orders', _orderStream),
                      analyticWedget(
                          title: 'Total Categories',
                          value: AdminCubit.get(context)
                              .categoriesNameList
                              .length
                              .toString()),
                    ],
                  ),
                ],
              ),
            ),
          );
        }, listener: (context, state) {});
  }
}
