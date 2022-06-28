import 'package:admin/module/homescreen/cubit/cubit.dart';
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../models/user_order_model.dart';
import '../../shared/Styles/colors.dart';
import 'inprogress_order_details_screen.dart';

class InprogressOrdersScreen extends StatelessWidget {
  static const String id = 'inprogress-orders';

  @override
  Widget build(BuildContext context) {
    var cubit = AdminCubit.get(context);
    return Column(
      children: [
        StreamBuilder<List<UserOrderModel>>(
          stream: cubit.loadOrdersInProgress(),
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
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Padding(
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
                ),
              );
            } else if (snapshot.hasData) {
              final ordersInProgress = snapshot.data!;
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                ),
                itemCount: ordersInProgress.length,
                itemBuilder: (context, index) => FadeInLeft(
                  delay: Duration(seconds: 1),
                  child: InprogressOrder(ordersInProgress[index], context),
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

Widget InprogressOrder(UserOrderModel order, context) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
    child: InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>InProgressOrderDetails(order: order,)));
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
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: order.orders.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.network(
                            order.orders[index].photo,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${order.orders[index].productName}        ${order.orders[index].size}        ${order.orders[index].quantity}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 200,
                              child: AutoSizeText(
                                order.orders[index].description,
                                maxLines: 3,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(

                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(int.parse(
                                    order.orders[index].color)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Total :     ${order.orderPrice}   LE ',
                    style: TextStyle(
                        fontSize: 14,
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
