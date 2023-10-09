import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramadan/view_model/network/local/shared_preferences.dart';

import '../../view_model/blocs/app_cubit/cubit.dart';
import '../../view_model/blocs/app_cubit/states.dart';

class Sebha extends StatefulWidget {
  const Sebha({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _SebhaState();

}
class _SebhaState extends State {
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
            actions: [
              IconButton(onPressed: (){
                setState(() {
                  AppCubit.get(context).count = 0;
                  CashHelper.saveData(key: 'count', value: 0);
                });
              }, icon: Icon(CupertinoIcons.restart))
            ],
            titleSpacing: 0,
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.navigate_before,size: width/18)),
            title: Text('Sebha',style: TextStyle(
                fontSize: width/21
            ),),
            backgroundColor: Color(0xff17203d),
          ),
          body: InkWell(
            onTap: (){
              AppCubit.get(context).count = AppCubit.get(context).count + 1;
              CashHelper.saveData(key: 'count', value: AppCubit.get(context).count);
              setState(() {
              });
            },
            child: Container(
              height: double.infinity,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppCubit.get(context).count.toString(),style: TextStyle(
                      fontSize: width/5.1,
                      color: Colors.white,
                      fontFamily: 'arabic'
                    ),),
                    SizedBox(
                      height: height/17,
                    ),
                    Text("Press anywhere..",style: TextStyle(
                      color: Colors.white70,
                      fontSize: width/15,
                      fontFamily: 'arabic'
                    ),)
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