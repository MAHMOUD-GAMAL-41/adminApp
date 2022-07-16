// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:admin/shared/Styles/colors.dart';
import 'package:admin/module/Admin_screens/data_of_product_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../models/products_model.dart';
import '../../shared/components/component.dart';
import '../fitting/guide.dart';
import 'multi_image_picker.dart';
import '../homescreen/cubit/cubit.dart';
import '../homescreen/cubit/states.dart';

class EditProduct extends StatelessWidget {
  static String id = 'Edit-Product';
  ProductModel productModel;

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var priceController = TextEditingController();

  var offerController = TextEditingController();

  var descriptionController = TextEditingController();

  EditProduct({required this.productModel});

  @override
  Widget build(BuildContext context) {
    var data = productModel.data.cast<String, Map<String, dynamic>>();
    AdminCubit.get(context).colors.clear();
    nameController.text = productModel.productName!;
    priceController.text = productModel.price!;
    offerController.text = productModel.offer!;
    descriptionController.text = productModel.description!;
    data.values.forEach((element) {
      var e = element as Map<String, dynamic>;
      print(e);
      AdminCubit.get(context).colors.addAll(e.keys.cast<String>());
    });
    print(data.values);
    AdminCubit.get(context).PhotosURL.clear();
    AdminCubit.get(context)
        .PhotosURL
        .addAll(productModel.photos!.cast<String>());
    AdminCubit.get(context).data.clear();
    AdminCubit.get(context).data = data;

    AdminCubit.get(context).SelecetedCategory = productModel.category;

    return BlocConsumer<AdminCubit, AdminStates>(builder: (context, state) {
      print(AdminCubit.get(context).PhotosURL.length);
      return Scaffold(
        appBar: AppBar(
          title: Text('Edit Product'),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddProductInputField(
                        title: 'Product Name',
                        hint: 'Enter Product Name',
                        line: 1,
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' please Enter Product Name';
                          }
                        }),
                    const SizedBox(height: 8),
                    Text(
                      'Category',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField2(
                      value: AdminCubit.get(context).SelecetedCategory,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Select Category ...',
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
                      items: AdminCubit.get(context)
                          .categoriesNameList
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
                      validator: (value) {
                        if (value == null) {
                          return 'Please select category.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        AdminCubit.get(context).selectedCategory(value);
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: AddProductInputField(
                          title: 'Price',
                          hint: '0.0',
                          line: 1,
                          controller: priceController,
                          type: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Product Price';
                            }
                          },
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: AddProductInputField(
                                title: 'Offer',
                                hint: ' 0 %',
                                line: 1,
                                controller: offerController,
                                type: TextInputType.number)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (AdminCubit.get(context).photos.length) +
                                (AdminCubit.get(context).PhotosURL.length) ==
                            0
                        ? SizedBox()
                        : Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: SizedBox(
                              height: 100,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Stack(
                                    children: [
                                      index <
                                              AdminCubit.get(context)
                                                  .PhotosURL
                                                  .length
                                          ? Image.network(
                                              AdminCubit.get(context)
                                                  .PhotosURL[index]
                                                  .toString())
                                          : AdminCubit.get(context).photos != 0
                                              ? Image.file(File(AdminCubit.get(
                                                      context)
                                                  .photos[index -
                                                      AdminCubit.get(context)
                                                          .PhotosURL
                                                          .length]
                                                  .path))
                                              : SizedBox(),
                                      Positioned(
                                        top: -7,
                                        right: -7,
                                        child: IconButton(
                                          onPressed: () {
                                            if (index <
                                                AdminCubit.get(context)
                                                    .PhotosURL
                                                    .length) {
                                              AdminCubit.get(context)
                                                  .removePhotoFromUrlLocal(
                                                      index);
                                            } else
                                              AdminCubit.get(context)
                                                  .removePhotoFromList(index);
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                separatorBuilder: (context, index) => SizedBox(
                                  width: 5,
                                ),
                                itemCount: (AdminCubit.get(context)
                                        .photos
                                        .length) +
                                    (AdminCubit.get(context).PhotosURL.length),
                              ),
                            ),
                          ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 8),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return MultiImagegPicker();
                                    });
                              },
                              child: Neumorphic(
                                style: NeumorphicStyle(color: MyColors.orange),
                                child: Container(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      AdminCubit.get(context).photos.length > 0
                                          ? 'Add More Image '
                                          : 'Add Image',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 8),
                            child: InkWell(
                              onTap: () {
                                AdminCubit.get(context).SelecetedCategory !=
                                        null
                                    ? Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => DataPicker()))
                                    : ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: Text(
                                                'Please Select Category first')));
                              },
                              child: Neumorphic(
                                style: NeumorphicStyle(color: MyColors.orange),
                                child: Container(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      AdminCubit.get(context).photos.length > 0
                                          ? 'Add More data'
                                          : 'Add data',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    AddProductInputField(
                      title: 'Description',
                      hint: 'Enter the description ',
                      line: 4,
                      controller: descriptionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Product Description';
                        }
                      },
                    ),
                    Row(
                      children: [
                        Text('Virtual Images'),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GuideScreen()),
                        );
                      },
                      child: Neumorphic(
                        style: NeumorphicStyle(color: MyColors.orange),
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              'Add Virtual Images',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BuildButton('Save', () {
                      if (formKey.currentState!.validate()) {
                        if (AdminCubit.get(context).data.keys.length != 0) {
                          if ((AdminCubit.get(context).photos.length) +
                                  (AdminCubit.get(context).PhotosURL.length) !=
                              0) {
                            if (AdminCubit.get(context)
                                    .virtualPhoto
                                    .keys
                                    .length !=
                                0) {
                              AdminCubit.get(context)
                                  .uploadProductPhoto()
                                  .then((value) {
                                AdminCubit.get(context)
                                    .uploadVirtualPhotoStorage().then((value) {
                                  AdminCubit.get(context)
                                      .editProduct(
                                      context: context,
                                      productUid: productModel.productUid,
                                      productName: nameController.text,
                                      description: descriptionController.text,
                                      category: AdminCubit.get(context).SelecetedCategory,
                                      brandName: AdminCubit.get(context).model!.brandName,
                                      price: priceController.text,
                                      offer: offerController.text,
                                      virtual: AdminCubit.get(context).virphotos,
                                      photos: AdminCubit.get(context).PhotosURL,
                                      data: AdminCubit.get(context).data)
                                      .then((e) {
                                    EasyLoading.dismiss();
                                    AdminCubit.get(context).data.clear();
                                    AdminCubit.get(context).photos.clear();
                                    AdminCubit.get(context).PhotosURL.clear();
                                    AdminCubit.get(context).virphotos.clear();
                                    AdminCubit.get(context).virtualPhoto.clear();
                                    AdminCubit.get(context).colors.clear();
                                    AdminCubit.get(context).SelecetedCategory = null;
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text('Product Editing Successful'),
                                      backgroundColor: Colors.green,
                                    ));
                                  });
                                });
                              });
                            } else {
                              defaultSnackBar(
                                  context: context,
                                  title: 'Please Add Virtual Image',
                                  color: Colors.red);
                            }
                          } else {
                            return ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please Add Photos first'),
                              ),
                            );
                          }
                        } else {
                          return ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please Add Data Of Product first'),
                            ),
                          );
                        }
                      }
                    }, context),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is AdminEditProductsSuccessState) {
        EasyLoading.dismiss();
        AdminCubit.get(context).data.clear();
        AdminCubit.get(context).photos.clear();
        AdminCubit.get(context).PhotosURL.clear();
        AdminCubit.get(context).virphotos.clear();
        AdminCubit.get(context).virtualPhoto.clear();
        AdminCubit.get(context).colors.clear();
        AdminCubit.get(context).SelecetedCategory = null;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Product Editing Successful'),
          backgroundColor: Colors.green,
        ));
      }
    });
  }
}
