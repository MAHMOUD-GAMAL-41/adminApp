import 'package:admin/module/homescreen/cubit/cubit.dart';
import 'package:admin/shared/components/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../shared/components/component.dart';

class DashboardScreen extends StatelessWidget {
  static const String id = 'dashboard-screen';

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> productStream = FirebaseFirestore.instance
        .collection('admins')
        .doc(uId)
        .collection('products')
        .snapshots();
    Stream<QuerySnapshot> aprovalorderStream = FirebaseFirestore.instance
        .collection('admins')
        .doc(uId)
        .collection('orders')
        .doc('orders')
        .collection('Approve')
        .snapshots();
    Stream<QuerySnapshot> inprogressOrderStream = FirebaseFirestore.instance
        .collection('admins')
        .doc(uId)
        .collection('orders')
        .doc('orders')
        .collection('In Progress')
        .snapshots();

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              // AdminCubit.get(context)
              //     .firebaseAnalytic('Total Users ', _usersStream),
              AdminCubit.get(context)
                  .firebaseAnalytic('Total Products ', productStream),
              AdminCubit.get(context)
                  .firebaseAnalytic('Approval Orders', aprovalorderStream),
              AdminCubit.get(context)
                  .firebaseAnalytic('Inprogress Orders', inprogressOrderStream),
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
    );
  }
}
