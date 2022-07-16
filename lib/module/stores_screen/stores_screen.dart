import 'package:admin/models/admin_model.dart';
import 'package:admin/models/request_model.dart';
import 'package:admin/module/homescreen/cubit/cubit.dart';
import 'package:admin/module/homescreen/home_screen.dart';
import 'package:admin/module/requests_screen/requests_screen.dart';
import 'package:admin/shared/components/constant.dart';
import 'package:admin/shared/network/local/cache_helper.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

import '../../shared/Styles/colors.dart';

class StoresScreen extends StatelessWidget {
  static const String id = 'Stores-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.orange,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            AdminCubit.get(context).mainAdminSignOut(context);
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        title: const Text('Main Admin'),
        actions: [
          StreamBuilder(
              stream: AdminCubit.get(context).getRequests(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<RequestModel> requests =
                      snapshot.data as List<RequestModel>;
                  if (requests.isEmpty) {
                    return IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RequestsScreen.id);
                      },
                      icon: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 25,
                      ),
                    );
                  }
                  return Badge(
                    position: BadgePosition.topEnd(top: 0, end: 3),
                    animationType: BadgeAnimationType.slide,
                    badgeContent: Text(
                      '${requests.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RequestsScreen.id);
                      },
                      icon: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return Badge(
                    position: BadgePosition.topEnd(top: 0, end: 3),
                    animationType: BadgeAnimationType.slide,
                    badgeContent: Text(
                      '50',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RequestsScreen.id);
                      },
                      icon: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  );
                }
                return const SizedBox();
              })
        ],
      ),
      body: StreamBuilder(
        stream: AdminCubit.get(context).getStores(),
        builder: ((context, snapshot) {
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
          } else if (snapshot.connectionState == ConnectionState.waiting) {
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
          } else if (snapshot.hasData) {
            final List<adminModel> stores = snapshot.data as List<adminModel>;
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.65,
                children: List.generate(
                    stores.length,
                    (index) => FocusedMenuHolder(
                          menuWidth: 180,
                          menuItems: <FocusedMenuItem>[
                            FocusedMenuItem(
                                title: Text(
                                  'Delete',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                onPressed: () {
                                  AdminCubit.get(context)
                                      .deleteAdmin(stores[index].uId);
                                },
                                trailingIcon: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                backgroundColor: Colors.red),
                          ],
                          onPressed: () {},
                          child: storeCardItem(stores[index], context),
                        )),
                crossAxisCount:
                    (MediaQuery.of(context).size.width / 100).floor(),
              ),
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }

  Widget storeCardItem(adminModel store, BuildContext context) => InkWell(
        onTap: () {
          CacheHelper.saveData(key: 'uID', value: store.uId).then((value) {
            uId = CacheHelper.getData(key: 'uID');
            print(uId);
            AdminCubit.get(context).getAdminData();
            Navigator.pushReplacementNamed(context, HomeScreen.id);
          });
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.withOpacity(0.1))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 46,
                backgroundColor: MyColors.deepOrange,
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: MyColors.lightOrange,
                  backgroundImage: NetworkImage(store.image.toString()),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                store.brandName.toString(),
                style: const TextStyle(
                    color: MyColors.lightOrange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
}
