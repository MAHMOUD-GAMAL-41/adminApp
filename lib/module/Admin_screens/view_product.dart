import 'package:admin/models/products_model.dart';
import 'package:admin/module/Admin_screens/product_details.dart';
import 'package:admin/module/homescreen/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import '../../shared/Styles/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'edit_product.dart';

class ViewProductScreen extends StatelessWidget {
  static const String id = 'view-products';

  @override
  Widget build(BuildContext context) {
    AdminCubit.get(context).PhotosURL.clear();
    AdminCubit.get(context).data.clear();
    var cubit = AdminCubit.get(context);
    return StreamBuilder<List<ProductModel>>(
      stream: cubit.loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());
          print(snapshot.data);
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
          final products = snapshot.data!;
          return GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: .56,
            shrinkWrap: true,
            children: List.generate(
              products.length,
              (index) => buildProduct(
                  productModel: products[index],
                  context: context,
                  cubit: AdminCubit.get(context)),
            ),
            crossAxisCount: (MediaQuery.of(context).size.width / 180).floor(),
          );
        }
        return SizedBox();
      },
    );
  }
}

Widget buildProduct({
  required ProductModel productModel,
  required cubit,
  required context,
}) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: FocusedMenuHolder(
      menuWidth: 180,
      menuItems: <FocusedMenuItem>[
        FocusedMenuItem(
            title: Text(
              'View Details',
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsScreen(productModel)));
            },
            trailingIcon: Icon(Icons.open_in_new)),
        FocusedMenuItem(
            title: Text(
              'Edit',
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProduct(
                            productModel: productModel,
                          )));
            },
            trailingIcon: Icon(Icons.edit)),
        FocusedMenuItem(
            title: Text(
              'Delete',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () {
              cubit.deleteProduct(productModel.productUid);
            },
            trailingIcon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            backgroundColor: Colors.red),
      ],
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(productModel)));
      },
      child: Card(
        elevation: 12,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Image.network(
                  productModel.photos![0],
                  fit: BoxFit.fill,
                ),
                Column(
                  children: [
                    productModel.offer != '0'&& productModel.offer != ''
                        ? Container(
                            padding: EdgeInsets.only(
                                bottom: 18, top: 12, left: 6, right: 2),
                            decoration: BoxDecoration(
                                color: MyColors.orange.withOpacity(.6),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(23))),
                            child: Text(
                              '  ${productModel.offer.toString()} % ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    '${productModel.productName}',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(TextSpan(children: [
                        if(productModel.offer != '' && productModel.offer != '0')
                        TextSpan(
                          text: '${double.parse(productModel.price as String)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                        TextSpan(

                          text: productModel.offer == ''
                              ? '${double.parse(productModel.price as String)} LE '
                              : '  ${((100 - double.parse(productModel.offer as String)) * double.parse(productModel.price as String)) / 100} LE ',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ]))
                    ],
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    ),
  );
}
