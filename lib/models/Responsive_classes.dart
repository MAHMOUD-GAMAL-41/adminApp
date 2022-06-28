import 'package:flutter/material.dart';

class ButtonsInfo {
  String title;
  IconData icon;

  ButtonsInfo({required this.title, required this.icon});
}

class ToDo {
  String name;
  bool enable;

  ToDo({this.enable = true, required this.name});
}

class Person {
  String name;
  Color color;

  Person({required this.color, required this.name});
}

class Product {
  String name;
  bool enable;

  Product({required this.name, required this.enable});
}
