import 'dart:io';

import 'package:admin/module/homescreen/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/Styles/colors.dart';

class MultiImagegPicker extends StatefulWidget {
  @override
  State<MultiImagegPicker> createState() => _MultiImagegPickerState();
}

class _MultiImagegPickerState extends State<MultiImagegPicker> {
  List<XFile> productPhoto=[];
  final ImagePicker picker = ImagePicker();

  Future getImagesOfProducts() async {
    final pickedFile = await picker.pickMultiImage();
    setState(() {
      if (pickedFile != null) {
        productPhoto.addAll(pickedFile) ;
      } else {
        print('No Image Selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {


    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              elevation: 1,
              title: Text('Upload Image'),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  //if (AdminCubit.get(context).photos.length > 0)
                  productPhoto.length > 0?
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: SizedBox(
                        height: 120,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Stack(
                            children: [
                               Image.file(File(productPhoto[index].path)),

                              Positioned(
                                  top: -5,
                                  right: -5,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          productPhoto.removeAt(index);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 30,
                                      )))
                            ],
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            width: 5,
                          ),
                          itemCount: productPhoto.length,
                        ),
                      ),
                    )
                    :Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        child: FittedBox(
                            child: Icon(
                                    CupertinoIcons.photo_on_rectangle,
                                    color: Colors.grey,
                                  ))),
                  SizedBox(
                    height: 10,
                  ),
                  if (productPhoto.isNotEmpty)
                    Row(
                      children: [
                        Expanded(
                            child: NeumorphicButton(
                          onPressed: () {
                            setState(() {
                              AdminCubit.get(context).addPhotosToList(productPhoto);
                              productPhoto.clear();
                              Navigator.pop(context);
                            });
                          },
                          style: NeumorphicStyle(color: Colors.green),
                          child: Text(
                            'Save',
                            textAlign: TextAlign.center,
                          ),
                        )),
                      ],
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: NeumorphicButton(
                          onPressed: getImagesOfProducts,
                          style: NeumorphicStyle(color: MyColors.orange),
                          child: Text(
                            productPhoto.length > 0
                                ? 'Upload More Image'
                                : 'Upload Image',
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

