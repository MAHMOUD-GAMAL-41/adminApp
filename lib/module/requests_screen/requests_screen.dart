import 'package:admin/module/homescreen/cubit/cubit.dart';
import 'package:admin/module/requests_screen/request_details_screen.dart';
import 'package:admin/shared/Styles/colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../models/request_model.dart';
class RequestsScreen extends StatelessWidget {
  static const String id ='requests-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.lightOrange,
      ),
      body: StreamBuilder(
        stream: AdminCubit.get(context).getRequests(),
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
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
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
            final List<RequestModel>requests = snapshot.data as List<RequestModel>;
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(
                height: 1,
              ),
              itemCount: requests.length,
              itemBuilder: (context, index) => FadeInLeft(
                delay: const Duration(seconds: 1),
                child: requestItem(requests[index], context),
              ),
            );
          }
          return const SizedBox();

        },
      ),
    );
  }
  Widget requestItem(RequestModel request, context) =>Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
    child: InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestDetailsScreen(request: request,)));
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
                    'Request Date: ${request.requestDate}',
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.network(
                      request.image??'',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(
                        width: 250,
                        child: Text(
                          '${request.name} wants to create a New Store Account',
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      AutoSizeText(
                        'Brand Name: ${request.brandName}',
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      AutoSizeText(
                        'Brand Phone: ${request.brandPhone}',
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            ),
                      ),
                    ],
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
