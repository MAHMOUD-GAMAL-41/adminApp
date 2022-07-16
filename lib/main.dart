import 'package:admin/module/Admin_screens/dashboard_screen.dart';
import 'package:admin/module/Admin_screens/approve_orders.dart';
import 'package:admin/module/Admin_screens/add_product.dart';
import 'package:admin/module/homescreen/cubit/cubit.dart';
import 'package:admin/module/requests_screen/requests_screen.dart';
import 'package:admin/module/stores_screen/stores_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocobserver/BlocObserver_todoapp.dart';
import 'module/Admin_screens/inprogress_orders.dart';
import 'module/Admin_screens/view_product.dart';
import 'module/homescreen/home_screen.dart';
import 'module/login_screen/login_screen.dart';
import 'module/main_admin/main_admin_Screen.dart';
import 'module/register_screen/register_screen.dart';
import 'module/spalsh_screen/splash_screen.dart';
import 'shared/components/constant.dart';
import 'module/Admin_screens/data_of_product_picker.dart';
import 'shared/network/local/cache_helper.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  uId = await CacheHelper.getData(key: 'uID');
  print(uId);

  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AdminCubit()
          ..getAdminData()
          ..loadProducts()
          ..configLoading()
          ..Loading(),
        child: MaterialApp(
          title: 'Admin',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.orange,

          ),
          initialRoute: SplashScreen.id,
          routes: {
            SplashScreen.id: (context) => SplashScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            RegisterScreen.id: (context) => RegisterScreen(),
            HomeScreen.id: (context) => HomeScreen(),
            MainAdminScreen.id: (context) => MainAdminScreen(),
            DashboardScreen.id: (context) => DashboardScreen(),
            ApprovedOrdersScreen.id: (context) => ApprovedOrdersScreen(),
            InprogressOrdersScreen.id: (context) => InprogressOrdersScreen(),
            AddProductScreen.id: (context) => AddProductScreen(),
            ViewProductScreen.id: (context) => ViewProductScreen(),
            DataPicker.id: (context) => DataPicker(),
            StoresScreen.id:(context)=>StoresScreen(),
            RequestsScreen.id:(context)=>RequestsScreen(),
          },
          builder: EasyLoading.init(),
        ));
  }
}
