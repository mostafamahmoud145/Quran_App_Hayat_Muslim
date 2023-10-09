import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramadan/core/resources/constants.dart';

import '../../view_model/blocs/app_cubit/cubit.dart';
import '../../view_model/blocs/app_cubit/states.dart';

class Hadith extends StatefulWidget {
  const Hadith({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _HadithState();

}
class _HadithState extends State {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          backgroundColor: Color.fromRGBO(22, 35, 79, 0.5),
          appBar: AppBar(
            titleSpacing: 0,
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.navigate_before,size: width/18)),
            title: Text('Hadith',style: TextStyle(
                fontSize: width/21
            ),),
            backgroundColor: Color(0xff17203d),
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: height/84),
              child: Center(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index)=>item(index,height,width),
                  separatorBuilder: (context, index)=>SizedBox(height: height/84,),
                  itemCount: hadith.length,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget item(index,height, width)=>Center(
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: height/84, left: width/39, right: width/39, bottom: height/84),
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(width/39),
              child: Center(child: Text(hadith[index]['hadith'],textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(
                  fontSize: width/21,
                  fontFamily: 'arabic'

              ),),),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(height/84),
                border: Border.all(
                  color: Color(0xfff5d7a2),
                  width: width/78,
                )),
          ),
        ),
      ],
    ),
  );
}