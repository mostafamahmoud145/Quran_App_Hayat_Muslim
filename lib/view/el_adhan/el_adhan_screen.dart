import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

import '../../view_model/blocs/app_cubit/cubit.dart';
import '../../view_model/blocs/app_cubit/states.dart';

class AlAdhan extends StatefulWidget {
  const AlAdhan({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _AlAdhanState();
}

Color item = Color(0xff17203d);

Location location = new Location();

bool? _serviceEnabled;

class _AlAdhanState extends State {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    location = Location();
    return BlocProvider(
      create: (BuildContext context) => AppCubit(AppInitialState())..getLocation(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){},
        builder: (context, state) {
          return Scaffold(
            //backgroundColor: Color(0xffa36b46),
            backgroundColor: Color.fromRGBO(22, 35, 79, 0.5),
            appBar: AppBar(
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.navigate_before,size: width/18)),
              actions: [
                IconButton(onPressed: (){
                  setState(() {
                    AppCubit.get(context).adhan();
                  });
                }, icon: Icon(CupertinoIcons.refresh_bold))
              ],
              titleSpacing: 0,
              backgroundColor: Color(0xff17203d),
              title: Text(
                "Prayer Times",
                style: TextStyle(
                    fontSize: width/21,
                    fontFamily: 'arabic3', fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding:
              EdgeInsets.only(top: height / 350.0, bottom: height / 600),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: height / 3.6,
                            width: width / 2.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(width / 20.35), bottomRight: Radius.circular(width / 20.35)),
                              color: Color(0xff17203d),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight:
                                        Radius.circular(width / 20.35),
                                        bottomLeft:
                                        Radius.circular(width / 20.35)),
                                  ),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(top: height / 50),
                                    child: Text(
                                      "الشروق",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: width / 12,
                                        height: 1.2,
                                        fontFamily: "arabic",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  "lib/core/resources/assets/images/shorouk.png",
                                  height: 100 * height / 920.5714285714286,
                                  width: 100 * width / 511.42857142857144,
                                  alignment: Alignment.center,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height / 4.9),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(top: height / 50),
                                    child: Text(AppCubit.get(context).sunrise != null?AppCubit.get(context).sunrise!:"00:00 AM",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: width / 12,
                                        height: 1.2,
                                        fontFamily: "arabic",
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xfff5d7a2),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width / 80,
                          ),
                          Container(
                            height: height / 3.6,
                            width: width / 2.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(width / 20.35), bottomLeft: Radius.circular(width / 20.35)),
                              color: Color(0xff17203d),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight:
                                        Radius.circular(width / 20.35),
                                        bottomLeft:
                                        Radius.circular(width / 20.35)),
                                  ),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(top: height / 50),
                                    child: Text(
                                      "الفجر",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: width / 12,
                                        height: 1.2,
                                        fontFamily: "arabic",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  "lib/core/resources/assets/images/fajr.png",
                                  height: 100 * height / 920.5714285714286,
                                  width: 100 * width / 511.42857142857144,
                                  alignment: Alignment.center,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height / 4.9),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(top: height / 50),
                                    child: Text(AppCubit.get(context).fajr!= null?AppCubit.get(context).fajr!:"00:00 AM",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: width / 12,
                                        height: 1.2,
                                        fontFamily: "arabic",
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xfff5d7a2),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: height / 3.6,
                            width: width / 2.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(width / 20.35), bottomRight: Radius.circular(width / 20.35)),
                              color: Color(0xff17203d),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight:
                                        Radius.circular(width / 20.35),
                                        bottomLeft:
                                        Radius.circular(width / 20.35)),
                                  ),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(top: height / 50),
                                    child: Text(
                                      "العصر",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: width / 12,
                                        height: 1.2,
                                        fontFamily: "arabic",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  "lib/core/resources/assets/images/asr.png",
                                  height: 100 * height / 920.5714285714286,
                                  width: 100 * width / 511.42857142857144,
                                  alignment: Alignment.center,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height / 4.9),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(top: height / 50),
                                    child: Text(AppCubit.get(context).asr!= null?AppCubit.get(context).asr!:"00:00 PM",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: width / 12,
                                        height: 1.2,
                                        fontFamily: "arabic",
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xfff5d7a2),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width / 80,
                          ),
                          Container(
                            height: height / 3.6,
                            width: width / 2.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(width / 20.35), bottomLeft: Radius.circular(width / 20.35)),
                              color: Color(0xff17203d),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight:
                                        Radius.circular(width / 20.35),
                                        bottomLeft:
                                        Radius.circular(width / 20.35)),
                                  ),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(top: height / 50),
                                    child: Text(
                                      "الظهر",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: width / 12,
                                        height: 1.2,
                                        fontFamily: "arabic",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  "lib/core/resources/assets/images/duhr.png",
                                  height: 100 * height / 920.5714285714286,
                                  width: 100 * width / 511.42857142857144,
                                  alignment: Alignment.center,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height / 4.9),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(top: height / 50),
                                    child: Text(AppCubit.get(context).dhuhr!= null?AppCubit.get(context).dhuhr!:"00:00 PM",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: width / 12,
                                        height: 1.2,
                                        fontFamily: "arabic",
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xfff5d7a2),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: height / 3.6,
                            width: width / 2.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(width / 20.35), bottomRight: Radius.circular(width / 20.35)),
                              color: Color(0xff17203d),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight:
                                        Radius.circular(width / 20.35),
                                        bottomLeft:
                                        Radius.circular(width / 20.35)),
                                  ),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(top: height / 50),
                                    child: Text(
                                      "العشاء",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: width / 12,
                                        height: 1.2,
                                        fontFamily: "arabic",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  "lib/core/resources/assets/images/isha.png",
                                  height: 100 * height / 920.5714285714286,
                                  width: 100 * width / 511.42857142857144,
                                  alignment: Alignment.center,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height / 4.9),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(top: height / 50),
                                    child: Text(AppCubit.get(context).isha!= null?AppCubit.get(context).isha!:"00:00 PM",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: width / 12,
                                        height: 1.2,
                                        fontFamily: "arabic",
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xfff5d7a2),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width / 80,
                          ),
                          Container(
                            height: height / 3.6,
                            width: width / 2.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(width / 20.35), bottomLeft: Radius.circular(width / 20.35)),
                              color: Color(0xff17203d),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight:
                                        Radius.circular(width / 20.35),
                                        bottomLeft:
                                        Radius.circular(width / 20.35)),
                                  ),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(top: height / 50),
                                    child: Text(
                                      "المغرب",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: width / 12,
                                        height: 1.2,
                                        fontFamily: "arabic",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  "lib/core/resources/assets/images/maghrib.png",
                                  height: 100 * height / 920.5714285714286,
                                  width: 100 * width / 511.42857142857144,
                                  alignment: Alignment.center,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height / 4.9),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(top: height / 50),
                                    child: Text(AppCubit.get(context).maghrib!= null?AppCubit.get(context).maghrib!:"00:00 PM",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: width / 12,
                                        height: 1.2,
                                        fontFamily: "arabic",
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xfff5d7a2),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}