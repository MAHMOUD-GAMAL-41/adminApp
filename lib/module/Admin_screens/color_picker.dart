import 'package:admin/module/homescreen/cubit/cubit.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../shared/Styles/colors.dart';

class ColorPicker extends StatefulWidget {
  final String Key;

  ColorPicker({required this.Key});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  var colorController = CircleColorPickerController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            centerTitle: true,
            title: Text(
              'Color Picker',
            ),
            elevation: 0,
          ),
          Center(
            child: CircleColorPicker(
              controller: colorController,
              onChanged: (color) {
                setState(() {
                  colorController.color = color;
                });
              },
              size: const Size(240, 240),
              strokeWidth: 4,
              thumbSize: 36,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: NeumorphicButton(
                    onPressed: () {
                      AdminCubit.get(context).addColortoMap(widget.Key, colorController.color.value, '');
                      AdminCubit.get(context).colors.add(colorController.color.value.toString());
                      print( AdminCubit.get(context).data[widget.Key].toString());
                      Navigator.pop(context);
                    },
                    style: NeumorphicStyle(color: MyColors.orange),
                    child: Text(
                      'Select',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
