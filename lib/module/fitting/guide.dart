
import 'package:admin/module/homescreen/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../shared/Styles/colors.dart';
import '../../shared/components/component.dart';
import 'addVirtualImage.dart';



class GuideScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    List guides=['you should do aaaaaaaaaaaaaaaaaaa'];

    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          title: Text('Quick Guide',style: TextStyle(color: Colors.white),),
          centerTitle: true,

        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 400,
                child: ListView.separated(

                  itemBuilder: (context,index)=>Row(
                    children: [
                      CircleAvatar(
                        child: Text(
                          (index+1).toString(),
                        ),
                        radius: 12,
                      ),
                      SizedBox(width: 10,),
                      Flexible(
                        child: Text(
                          guides[index],
                        ),
                      ),
                    ],
                  ),
                  separatorBuilder: (context,index)=>SizedBox(height: 15,),
                  itemCount: guides.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child:  InkWell(
                  onTap: (){
                    if(AdminCubit.get(context).data.isNotEmpty)
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddVirtualImage()));
                    else defaultSnackBar(context: context, title: 'Please add color first', color: Colors.red);
                  }
                  ,
                  child: Neumorphic(
                    style:
                    NeumorphicStyle(color: MyColors.orange),
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Text(
                         'Pick Images',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget guideCart({
    required context,
    required String image,
    required String title,
  })=>Column(
    children: [
      SizedBox(height: 15,),
      Text(
        title,
        textAlign: TextAlign.center,
      ),
      Expanded(
        child: Image.network(
            'https://images.unsplash.com/photo-1519658422992-0c8495f08389?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8cG9pbnRpbmclMjB1cHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'
        ),
      )
    ],
  );
}