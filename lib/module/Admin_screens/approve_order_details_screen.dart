// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../models/user_order_model.dart';

class ApprovedOrderDetails extends StatelessWidget {
  ApprovedOrderDetails({required this.order});

  UserOrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),

        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
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
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Adress',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 40),
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
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Phone Number',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 20),
                        Text(
                          '${order.addressModel.phoneNumber}    ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: order.orders.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
                              width: 150,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Color(int.parse(order.orders[index].color)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          order.orderPrice.toString()+'  LE',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ]),
      ),
    );
  }
}
