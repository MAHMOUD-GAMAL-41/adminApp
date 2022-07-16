import 'dart:io';
import 'package:admin/module/homescreen/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/Styles/colors.dart';
import '../homescreen/cubit/cubit.dart';

class AddVirtualImage extends StatelessWidget {
  AddVirtualImage({Key? key}) : super(key: key);
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    List<String> colors = AdminCubit.get(context).colors.toList();
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Add Virual Images',style: TextStyle(color: Colors.white),),
          ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
                  height: 10,
          ),
          shrinkWrap: true,
          itemCount: colors.length,
          itemBuilder: (BuildContext context, int index) {
                  return colorItems(
                    context,
                    int.parse(colors[index]),
                  );
          },
        ),
                ],
              ),
            ));
      },
    );
  }
}

Widget colorItems(context, color) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Color(color),
        ),
        InkWell(
          onTap: () async {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: BlocConsumer<AdminCubit, AdminStates>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppBar(
                            elevation: 1,
                            title: Text('Upload Image'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                AdminCubit.get(context).virtualPhoto[color] !=
                                        null
                                    ? Stack(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(10),
                                              child: Image.file(File(
                                                  AdminCubit.get(context)
                                                      .virtualPhoto[color]!
                                                      .path))),
                                          Positioned(
                                              top: 0,
                                              right: 0,
                                              child:InkWell(
                                                onTap: (){
                                                  AdminCubit.get(context)
                                                      .removeVirtualPhoto(color);
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                  child: Icon(Icons.close,color: Colors.white,),
                                                ),
                                              )),
                                        ],
                                      )
                                    : Container(
                                        height: 120,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: FittedBox(
                                            child: Icon(
                                          CupertinoIcons.photo_on_rectangle,
                                          color: Colors.grey,
                                        ))),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: NeumorphicButton(
                                        onPressed: () {
                                          ImagePicker picker = ImagePicker();
                                          picker
                                              .pickImage
                                            (
                                                  source: ImageSource.gallery
                                            )
                                              .then((value) {
                                            if (value != null) {
                                              AdminCubit.get(context)
                                                  .getVirtualImages(
                                                      color, value
                                              );
                                            } else {
                                              print('No Image Selected.');
                                            }
                                          });
                                        },
                                        style: NeumorphicStyle(
                                            color: MyColors.orange),
                                        child: Text(
                                          AdminCubit.get(context)
                                                      .virtualPhoto[color] !=
                                                  null
                                              ? 'Edit Image'
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
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
          child: Neumorphic(
            style: NeumorphicStyle(color: MyColors.orange),
            child: Container(
              width: 200,
              height: 50,
              child: Center(
                child: Text(
                  ' Add Image ',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ),
        AdminCubit.get(context).virtualPhoto[color] != null
            ? Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.green,
              )
            : SizedBox(
                width: 25,
              ),
      ],
    ),
  );
}
