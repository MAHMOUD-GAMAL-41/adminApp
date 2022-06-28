import 'package:admin/models/products_model.dart';
import 'package:admin/module/homescreen/cubit/cubit.dart';
import 'package:admin/shared/Styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget BuildTextForm({
  hint,
  icon,
  controller,
  keyboardType,
  validate,
  obscureText,
  suffixIcon,
  onChanged,
  lines,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color(0xFFFFE0B2), offset: Offset(2, 4), blurRadius: 8)
        ],
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white),
    child: TextFormField(
      maxLines: lines ?? 1,
      onChanged: onChanged ?? (value) {},
      obscureText: obscureText ?? false,
      validator: validate ?? (String? value) {},
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          border: InputBorder.none,
          label: hint,
          prefixIcon: Icon(icon),
          suffixIcon: suffixIcon),
    ),
  );
}

Widget BuildLogo(context, screenTitle, height) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned(
            child: Text(
              screenTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            bottom: 10,
            right: 10,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/png1.png',
                  width: 90,
                  height: 90,
                ),
                const Text(
                  'Shoppy App',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    ),
    height: MediaQuery.of(context).size.height * height,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
      gradient: LinearGradient(colors: [
        MyColors.deepOrange,
        MyColors.lightOrange,
        MyColors.orange,
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
    ),
  );
}

Widget BuildButton(String text, ontap, context) {
  return InkWell(
    onTap: ontap,
    child: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            MyColors.deepOrange,
            MyColors.lightOrange,
            MyColors.orange,
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
          borderRadius: BorderRadius.all(Radius.circular(100))),
      margin: const EdgeInsets.only(top: 10),
      height: 50,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ),
  );
}

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      textColor: Colors.white,
      fontSize: 16.0,
      backgroundColor: chooseToastColor(state),
    );
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  late Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

defaultSnackBar({
  required context,
  required String title,
  required Color color,
}) {
  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
      height: 50,
      decoration: BoxDecoration(
        color: color,
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            spreadRadius: 2.0,
            blurRadius: 8.0,
            offset: Offset(2, 4),
          )
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('  ' + title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    ),
    duration: Duration(seconds: 5),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?)? validate,
  required String label,
  required BuildContext context,
  bool isPassword = false,
  int? maxLength,
  IconData? prefix,
  IconData? suffix,
  Color? borderColor,
  Color? focusBorderColor,
  Color hintColor = Colors.grey,
  Color? prefixColor,
  Color? suffixColor,
  Color? inputColor,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
  double containerRadius = 10.0,
  InputBorder borderForm = InputBorder.none,
}) =>
    TextFormField(
      onTap: onTap,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      validator: validate,
      maxLength: maxLength,
      style: TextStyle(
          color: inputColor != null
              ? inputColor
              : Theme.of(context).iconTheme.color),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: hintColor),
        prefixIcon: prefix != null
            ? Icon(
                prefix,
                color: prefixColor != null
                    ? prefixColor
                    : Theme.of(context).iconTheme.color,
              )
            : null,
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                  color: suffixColor != null
                      ? suffixColor
                      : Theme.of(context).iconTheme.color,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(containerRadius),
            borderSide: BorderSide(
              color: borderColor != null
                  ? borderColor
                  : Theme.of(context).focusColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(containerRadius),
            borderSide: BorderSide(
              color: focusBorderColor != null
                  ? focusBorderColor
                  : Theme.of(context).focusColor,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(containerRadius),
            borderSide: BorderSide(
              color: focusBorderColor != null
                  ? focusBorderColor
                  : Theme.of(context).errorColor,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(containerRadius),
            borderSide: BorderSide(
              color: focusBorderColor != null
                  ? focusBorderColor
                  : Theme.of(context).errorColor,
            )),
      ),
    );

Widget defaultButton({
  required VoidCallback onPressFunction,
  required String text,
  required BuildContext context,
  double width = double.infinity,
  double height = 40.0,
  double radius = 15.0,
  bool isUpperCase = true,
  Color? backgroundColor,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: onPressFunction,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        clipBehavior: Clip.antiAlias, // Add This
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).focusColor,
      ),
    );

Widget analyticWedget({required String title, required String value}) {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Container(
      height: 120,
      width: 150,
      decoration: BoxDecoration(
          border: Border.all(color: MyColors.deepOrange),
          borderRadius: BorderRadius.circular(10),
          color: MyColors.orange,
          boxShadow: const [
            BoxShadow(
                color: Color(0xFFFFE0B2), offset: Offset(2, 4), blurRadius: 8),
            BoxShadow(
                color: Color(0xFFFFE0B2), offset: Offset(2, 4), blurRadius: 8)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value),
                Icon(Icons.show_chart),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget AddProductInputField(
    {title,
    hint,
    controller,
    widget,
    line,
    type,
    validator,
    subfunc,
    onChanged}) {
  return Container(
    margin: EdgeInsets.only(top: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey, width: 0)),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  onFieldSubmitted: subfunc,
                  onChanged: onChanged,
                  validator: validator,
                  keyboardType: type,
                  maxLines: line,
                  autofocus: false,
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: hint,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    ),
  );
}

buildProductItemView(ProductModel item, context) {
  var cubit = AdminCubit.get(context);
  return Card(
    child: Column(),
  );
}
