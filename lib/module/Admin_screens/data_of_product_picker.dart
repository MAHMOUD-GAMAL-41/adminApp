import 'package:admin/module/homescreen/cubit/cubit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'color_picker.dart';
import '../../shared/components/component.dart';

class DataPicker extends StatefulWidget {
  static const String id = 'add-data';

  @override
  State<DataPicker> createState() => _DataPickerState();
}

class _DataPickerState extends State<DataPicker> {
  final List<String> sizesList = [
    'XS',
    'S',
    'M',
    'L',
    'XL',
    '2XL',
    '3XL',
    '4XL',
    '5XL'
  ];

  final List<String> sizesPants = [
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
  ];

  String SelectedSize = '';

  String SelectedColor = '';
  var key = GlobalKey<FormState>();

  var QuantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              print(AdminCubit.get(context).data);
            },
            icon: Icon(Icons.arrow_back)),
        elevation: 1,
        title: Text('Upload Data'),
        actions: [
          TextButton(
              onPressed: () {
                print(AdminCubit.get(context).data);
                bool isEmpty = false;
                setState(() {
                  isEmpty = AdminCubit.get(context)
                      .data
                      .values
                      .where((element) => element.values.isEmpty)
                      .isNotEmpty;
                });
                print(AdminCubit.get(context).data.values.contains({}));
                print(AdminCubit.get(context).data.values);
                if (key.currentState!.validate()) {
                  if (isEmpty) {
                   defaultSnackBar(context: context, title: 'Please Enter Color to size to save ', color: Colors.red);
                  } else {
                    Navigator.pop(context);
                  }
                }
              },
              child: Text(
                'Save',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: key,
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Select Size ...',
                        style: TextStyle(fontSize: 14),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 55,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items:
                          AdminCubit.get(context).SelecetedCategory != 'Pants'
                              ? sizesList
                                  .map(
                                    (item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList()
                              : sizesPants
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                      onChanged: (value) {
                        SelectedSize = value.toString();
                        value = null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  NeumorphicButton(
                    onPressed: () {
                      setState(() {
                        if (SelectedSize != '' &&
                            !(AdminCubit.get(context)
                                .data
                                .keys
                                .contains(SelectedSize))) {
                          setState(() {
                            AdminCubit.get(context)
                                .addSizetoMap(SelectedSize, {});
                          });
                        } else
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                'Enter different Size',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )));
                      });
                    },
                    style: NeumorphicStyle(color: Colors.green),
                    child: Text(
                      'add',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              AdminCubit.get(context).data.keys.length != 0
                  ? Container(
                      child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return buildContainer(index, context);
                          },
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: AdminCubit.get(context).data.keys.length),
                    )
                  : SizedBox(),
            ]),
          ),
        ),
      ),
    );
  }

  buildContainer(index, context) {
    List<TextEditingController> quantityController = [];
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ExpandablePanel(
          collapsed: Row(
            children: [
              Expanded(
                child: Container(
                  height: AdminCubit.get(context)
                              .data[AdminCubit.get(context)
                                  .data
                                  .keys
                                  .toList()[index]]!
                              .keys
                              .length !=
                          0
                      ? 50
                      : 0,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index2) => SizedBox(
                      width: 5,
                    ),
                    shrinkWrap: true,
                    itemCount: AdminCubit.get(context)
                        .data[
                            AdminCubit.get(context).data.keys.toList()[index]]!
                        .keys
                        .length,
                    itemBuilder: (context, index2) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(int.parse(
                              AdminCubit.get(context)
                                  .data[AdminCubit.get(context)
                                      .data
                                      .keys
                                      .toList()[index]]!
                                  .keys
                                  .toList()[index2])),
                        ),
                      );
                    },
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      AdminCubit.get(context).removeSize(
                          AdminCubit.get(context).data.keys.toList()[index]);
                    });
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
          header: Row(
            children: [
              Text(
                'Size : ${AdminCubit.get(context).data.keys.toList()[index]}',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          expanded: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: NeumorphicButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return ColorPicker(
                                    Key: AdminCubit.get(context)
                                        .data
                                        .keys
                                        .toList()[index]);
                              }).then((value) {
                            setState(() {});
                          });
                        },
                        style: NeumorphicStyle(color: Colors.green),
                        child: Text(
                          'add Color',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            AdminCubit.get(context).removeSize(
                                AdminCubit.get(context)
                                    .data
                                    .keys
                                    .toList()[index]);
                          });
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index2) => SizedBox(
                    height: 10,
                  ),
                  shrinkWrap: true,
                  itemCount: AdminCubit.get(context)
                      .data[AdminCubit.get(context).data.keys.toList()[index]]!
                      .keys
                      .length,
                  itemBuilder: (context, index2) {
                    quantityController.add(TextEditingController());
                    quantityController[index2].text = AdminCubit.get(context)
                        .data[
                            AdminCubit.get(context).data.keys.toList()[index]]!
                        .values
                        .toList()[index2]
                        .toString();
                    return Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Color',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Color(int.parse(
                                        AdminCubit.get(context)
                                            .data[AdminCubit.get(context)
                                                .data
                                                .keys
                                                .toList()[index]]!
                                            .keys
                                            .toList()[index2])),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: AddProductInputField(
                                validator: (value) {
                                  if (value.toString().isNotEmpty) {
                                    var q = double.parse(value);
                                    print(q.toString());
                                    if (q <= 0 || q % 1 != 0) {
                                      return 'Enter Valid Quantity';
                                    }
                                  } else
                                    return 'Enter Quantity';
                                },
                                type: TextInputType.number,
                                title: 'Quantity',
                                hint: 'Enter the Quantity',
                                line: 1,
                                controller: quantityController[index2],
                                subfunc: (value) {
                                  if (key.currentState!.validate()) {
                                    AdminCubit.get(context).addColortoMap(
                                        AdminCubit.get(context)
                                            .data
                                            .keys
                                            .toList()[index],
                                        int.parse(AdminCubit.get(context)
                                            .data[AdminCubit.get(context)
                                                .data
                                                .keys
                                                .toList()[index]]!
                                            .keys
                                            .toList()[index2]),
                                        value.toString());
                                    print(AdminCubit.get(context).data);
                                  }
                                },
                                onChanged: (value) {
                                  if (key.currentState!.validate()) {
                                    AdminCubit.get(context).addColortoMap(
                                        AdminCubit.get(context)
                                            .data
                                            .keys
                                            .toList()[index],
                                        int.parse(AdminCubit.get(context)
                                            .data[AdminCubit.get(context)
                                                .data
                                                .keys
                                                .toList()[index]]!
                                            .keys
                                            .toList()[index2]),
                                        value.toString());
                                    print(AdminCubit.get(context).data);
                                  }
                                }),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 30, left: 15),
                              child: IconButton(
                                  onPressed: () {
                                    print(
                                        '${AdminCubit.get(context).data.keys.toList()[index]}');
                                    setState(() {
                                      AdminCubit.get(context).removeColortoMap(
                                          AdminCubit.get(context)
                                              .data
                                              .keys
                                              .toList()[index],
                                          AdminCubit.get(context)
                                              .data[AdminCubit.get(context)
                                                  .data
                                                  .keys
                                                  .toList()[index]]!
                                              .keys
                                              .toList()[index2]);

                                    });
                                  },
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                    size: 30,
                                  ))),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }
}
