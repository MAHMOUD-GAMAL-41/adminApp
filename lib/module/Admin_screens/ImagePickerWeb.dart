import 'dart:io';

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/Styles/colors.dart';
import '../homescreen/cubit/cubit.dart';

class ImageUploader extends StatefulWidget {
  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  Uint8List? imagevalue;
  List<Uint8List> productWebPhoto=[];

  late File file1;
  List<XFile> productPhoto = [];

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
                    productPhoto.length > 0
                        ? Container(
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
                                    Image.memory(productWebPhoto[index],fit: BoxFit.fitHeight,),
                                    // Image.file(File(productPhoto[index].path)),
                                    Positioned(
                                        top: -5,
                                        right: -5,
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                productPhoto.removeAt(index);
                                                productWebPhoto.removeAt(index);
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
                        : Container(
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
                              AdminCubit.get(context)
                                  .addPhotosToList(productPhoto);
                              AdminCubit.get(context)
                                  .addWebPhotosToList(productWebPhoto);
                              productPhoto.clear();
                              productWebPhoto.clear();
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
                          onPressed: uploadImage,
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
  //
  // Future convertToFile(image) async {
  //   Uint8List? imageInUnit8List = image; // store unit8List image here ;
  //   final tempDir = await getTemporaryDirectory();
  //   file1 = await File('${tempDir.path}/image.png').create();
  //   file1.writeAsBytesSync(imageInUnit8List!);
  // }

  uploadImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'svg', 'jpeg']);

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        imagevalue = file.bytes;
        file1 = File.fromRawPath(imagevalue!) ;
        XFile xfile=new XFile(file1.path);
        productPhoto.add(xfile);
        productWebPhoto.add(imagevalue!);
        // convertToFile(imagevalue).then((value) =>  productPhoto.add(file1 as XFile));
      });
    } else {
      print('No Image Selected.');
    }
  }
}

///  Image.memory(imagevalue!,fit: BoxFit.fitHeight,)
