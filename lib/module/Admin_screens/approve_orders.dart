import 'package:admin/module/homescreen/cubit/cubit.dart';
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../models/user_order_model.dart';
import '../../shared/Styles/colors.dart';
import 'approve_order_details_screen.dart';

class ApprovedOrdersScreen extends StatelessWidget {
  static const String id = 'Approve-orders';

  @override
  Widget build(BuildContext context) {
    var cubit = AdminCubit.get(context);
    return Column(
      children: [
        StreamBuilder<List<UserOrderModel>>(
          stream: cubit.loadOrdersApprove(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error.toString());

              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: MyColors.purpleDark),
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.orange),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Something went wrong',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            }
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: MyColors.purpleDark),
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.orange),
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            }
            else if (snapshot.hasData) {
              final ordersApprove = snapshot.data!;
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                ),
                itemCount: ordersApprove.length,
                itemBuilder: (context, index) => FadeInLeft(
                  delay: Duration(seconds: 1),
                  child: ApproveOrder(ordersApprove[index], context),
                ),
              );
            }
            return SizedBox();
          },
        ),
      ],
    );
  }
}

Widget ApproveOrder(UserOrderModel order, context) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
    child: InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ApprovedOrderDetails(order: order,)));
      },
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    'Order ID: ${order.orderId}',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    order.orderDate,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Adress',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        '${order.addressModel.cityName}, ${order.addressModel.streetName},',
                        maxLines: 3,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Building : ${order.addressModel.buildingNumber},',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Floor : ${order.addressModel.floorNumber},',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Apartment : ${order.addressModel.apartmentNumber}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Phone Number',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${order.addressModel.phoneNumber}    ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Total :     ${order.orderPrice}   LE ',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
