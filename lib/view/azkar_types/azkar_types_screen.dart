import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/blocs/app_cubit/cubit.dart';
import '../../view_model/blocs/app_cubit/states.dart';
import '../azkar/azkar_screen.dart';

class AzkarTypes extends StatefulWidget {
  const AzkarTypes({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _AzkarTypesState();

}
class _AzkarTypesState extends State {
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
            }, icon: Icon(Icons.navigate_before,size: width/18,)),
            title: Text('Azkar',style: TextStyle(
              fontSize: width/21
            ),),
            backgroundColor: Color(0xff17203d),
          ),
          body: Padding(
            padding: EdgeInsets.all(height/84),
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
                itemBuilder: (context, index)=>item(index,height,width),
                separatorBuilder: (context, index)=>SizedBox(
                  height: height/84,
                ),
                itemCount: AppCubit.get(context).category[0]['item'].length,
            ),
          ),

        );
      },
    );
  }

  Widget item(index,height,width)=>GestureDetector(
    onTap: (){
      AppCubit.get(context).index = index;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Azkar()),
      );
    },
    child: Center(
      child: Padding(
        padding: EdgeInsets.all(height/84),
        child: Container(
          width: double.infinity,
          height: height/14,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(width/39), bottomLeft: Radius.circular(width/39)),
            color: Color(0xfff5d7a2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppCubit.get(context).category[index]['category'], textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(
                fontSize: width/18,
                fontFamily: 'arabic',
                color: Color(0xff17203d),
              ),)
            ],
          ),
        ),
      ),
    ),
  );
}