import 'package:admin/shared/Styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/component.dart';
import '../homescreen/cubit/cubit.dart';
import '../homescreen/cubit/states.dart';

class AccountInfoScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: ((context, state) {
        if (state is AdminChangeNameSuccessState) {
          defaultSnackBar(
            context: context,
            color: Colors.green,
            title: 'Name Changed Successfully',
          );
          Navigator.pop(context);
        } else if (state is AdminChangeNameErrorState) {
          defaultSnackBar(
            context: context,
            color: Colors.red,
            title: state.error.toString(),
          );
        }
      }),
      builder: (context, state) {
        nameController.text = '${AdminCubit.get(context).model!.name}';

        return Scaffold(
          appBar: AppBar(
            title: Text('Account Info'),
            centerTitle: true,
            elevation: 0,
            backgroundColor: MyColors.orange,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 14.0),
                    ),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText:
                            '  ' + '${AdminCubit.get(context).model!.email}',
                        hintStyle:
                            Theme.of(context).textTheme.subtitle1!.copyWith(
                                  fontSize: 18,
                                ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color ??
                                  Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Full Name',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 14.0),
                    ),
                    TextFormField(
                      controller: nameController,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 18,
                          ),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color ??
                                  Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color ??
                                  Colors.white),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name must n\'t Be Empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    BuildButton(
                      'Save',
                      () async {
                        if (formKey.currentState!.validate()) {
                          AdminCubit.get(context)
                              .changeName(name: nameController.text);
                        }
                      },
                      context,
                    ),
                    if (state is AdminChangeNameLoadingState)
                      LinearProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
