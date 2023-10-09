import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/blocs/app_cubit/cubit.dart';
import '../../view_model/blocs/app_cubit/states.dart';

class Safha extends StatefulWidget {
  const Safha({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _SafhaState();

}
class _SafhaState extends State {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state){},
      builder: (context, state){
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.brown,
            body: ConditionalBuilder(
                condition: AppCubit.get(context).pageDetails.isNotEmpty,
                builder: (BuildContext context){
                  return ListView.separated(
                      itemBuilder: (context, index)=>item(index,height,width),
                      reverse: false,
                      itemCount: AppCubit.get(context).pageDetails.length,
                      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 0.5,)
                  );
                },
                fallback: (BuildContext context)=>Center(child: CircularProgressIndicator(),)
            ),
          ),
        );
      },
    );
  }

  Widget item (index,height,width)=>GestureDetector(
    onTap: (){
      AppCubit.get(context).changePage(AppCubit.get(context).pageDetails[index]['id']-1);
      Navigator.pop(context);
    },
    child: Container(
      height: height/15,
      child: Row(
        children: [
          Container(
            color: Color(0xff1c1b1a),
            height: double.infinity,
            width: width/3.9,
            child: Center(child: Text(AppCubit.get(context).pageDetails[index]['id'].toString(),style: TextStyle(
                color: Colors.white,
                fontSize: width/21,
                fontFamily: 'arabic'
            ),)),
          ),
          Expanded(
            child: Container(
              color: Color(0xfff5d7a2),
              height: double.infinity,
              child: Row(
                children: [
                  SizedBox(
                    width: width/76,
                  ),
                  Image.asset("lib/core/resources/assets/images/mosque.png"),
                  Spacer(),
                  Text(AppCubit.get(context).pageDetails[index]['name'].toString(),style: TextStyle(
                      fontFamily: 'arabic',
                      fontSize: width/19,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(
                    width: width/49,
                  )
                ],
              ),
            ),
          ),
          Container(
            color: Color(0xff1c1b1a),
            height: double.infinity,
            width: width/6.5,
            child: Center(child: Text(AppCubit.get(context).pageDetails[index]['surahID'].toString(),style: TextStyle(
                fontSize: width/21,
                color: Colors.white,
                fontFamily: 'arabic'
            ),)),
          )
        ],
      ),
    ),
  );
}