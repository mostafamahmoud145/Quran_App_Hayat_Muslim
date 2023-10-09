import 'dart:async';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ramadan/view/el_adhan/el_adhan_screen.dart';
import 'package:ramadan/view/hadith/hadith_screen.dart';
import 'package:ramadan/view/quraan/quraan_screen.dart';
import 'package:ramadan/view/sebha/sebha_screen.dart';
import '../../view_model/blocs/app_cubit/cubit.dart';
import '../../view_model/blocs/app_cubit/states.dart';
import '../azkar_types/azkar_types_screen.dart';
import '../qibla/qibla_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _HomeState();
}

Color item = Color(0xff17203d);

Location location = new Location();

bool? _serviceEnabled;

class _HomeState extends State {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    print(height);
    print(width);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is AppLoadingState){
            Timer(Duration(seconds: 1), () {
              AppCubit.get(context).notChekcer();
              print(AppCubit.get(context).check);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const QiblahScreen()),
                );
            }
            );
          }
        },
        builder: (context, state) {
          AppCubit appCubit = AppCubit.get(context);
          return Scaffold(
            //backgroundColor: Color(0xffa36b46),
            backgroundColor: Color.fromRGBO(22, 35, 79, 0.5),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: item,
              title: Text(
                "Hayat-Muslim",
                style: TextStyle(
                    fontFamily: 'arabic3', fontWeight: FontWeight.bold),
              ),
            ),
            body: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                _serviceEnabled = await location.serviceEnabled();
                                if(!_serviceEnabled!) {
                                  final AndroidIntent intent = new AndroidIntent(
                                    action: 'android.settings.LOCATION_SOURCE_SETTINGS',
                                  );
                                  await intent.launch();
                                }
                                else if(_serviceEnabled!)
                                {
                                  var status = await Permission.location.status;
                                  if (status.isGranted) {
                                    print("Permission is already Granted");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const AlAdhan()),
                                    );

                                  }
                                  else {
                                    Permission.location.request().then((value) {
                                      if(value.toString() == 'PermissionStatus.granted')
                                      {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const AlAdhan()),
                                        );
                                      }
                                    });
                                  }
                                }
                              },
                              child: Container(
                                height: height / 3.6,
                                width: width / 2.05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(width / 20.35),
                                      bottomRight: Radius.circular(width / 20.35)),
                                  color: item,
                                ),
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: width / 41),
                                      child: Image.asset(
                                        "lib/core/resources/assets/images/ramadan.png",
                                        height: 100 * height / 820.5714285714286,
                                        width: 100 * width / 411.42857142857144,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: height / 4.9),
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft:
                                              Radius.circular(width / 20.35),
                                              bottomRight:
                                              Radius.circular(width / 20.35)),
                                          color: Color(0xfff5d7a2),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsets.only(top: height / 50),
                                          child: Text(
                                            "مواقيت الصلاة",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: width / 16,
                                              height: 1.2,
                                              fontFamily: "arabic",
                                              fontWeight: FontWeight.bold,
                                              color: item,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width / 80,
                            ),
                            GestureDetector(
                              onTap: () {
                                AppCubit.get(context)..getLast()..getFirstSave();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Pagee()),
                                );
                              },
                              child: Container(
                                height: height / 3.6,
                                width: width / 2.05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(width / 20.35),
                                      bottomLeft:
                                          Radius.circular(width / 20.35)),
                                  color: item,
                                ),
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: width / 41),
                                      child: Image.asset(
                                        "lib/core/resources/assets/images/quran (1).png",
                                        height: 100 * height / 820.5714285714286,
                                        width: 100 * width / 411.42857142857144,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: height / 4.9),
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight:
                                                  Radius.circular(width / 20.35),
                                              bottomLeft:
                                                  Radius.circular(width / 20.35)),
                                          color: Color(0xfff5d7a2),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(top: height / 50),
                                          child: Text(
                                            "القرآن الكريم",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: width / 16,
                                              height: 1.2,
                                              fontFamily: "arabic",
                                              fontWeight: FontWeight.bold,
                                              color: item,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                AppCubit.get(context).getCount();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Sebha()),
                                );
                              },
                              child: Container(
                                height: height / 3.6,
                                width: width / 2.05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(width / 20.35),
                                      bottomRight: Radius.circular(width / 20.35)),
                                  color: item,
                                ),
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: width / 41),
                                      child: Image.asset(
                                        "lib/core/resources/assets/images/beads.png",
                                        height: 100 * height / 820.5714285714286,
                                        width: 100 * width / 411.42857142857144,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: height / 4.9),
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft:
                                                  Radius.circular(width / 20.35),
                                              bottomRight:
                                                  Radius.circular(width / 20.35)),
                                          color: Color(0xfff5d7a2),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(top: height / 50),
                                          child: Text(
                                            "السبحة الالكترونية",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: width / 16,
                                              height: 1.2,
                                              fontFamily: "arabic",
                                              fontWeight: FontWeight.bold,
                                              color: item,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width / 80,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AzkarTypes()),
                                );
                              },
                              child: Container(
                                height: height / 3.6,
                                width: width / 2.05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(width / 20.35),
                                      bottomLeft: Radius.circular(width / 20.35)),
                                  color: item,
                                ),
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: width / 41),
                                      child: Image.asset(
                                        "lib/core/resources/assets/images/praying (1).png",
                                        height: 100 * height / 820.5714285714286,
                                        width: 100 * width / 411.42857142857144,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: height / 4.9),
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight:
                                                  Radius.circular(width / 20.35),
                                              bottomLeft:
                                                  Radius.circular(width / 20.35)),
                                          color: Color(0xfff5d7a2),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(top: height / 50),
                                          child: Text(
                                            "اذكار و ادعية",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: width / 16,
                                              height: 1.2,
                                              fontFamily: "arabic",
                                              fontWeight: FontWeight.bold,
                                              color: item,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Hadith()),
                                );
                              },
                              child: Container(
                                height: height / 3.6,
                                width: width / 2.05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(width / 20.35),
                                      bottomRight: Radius.circular(width / 20.35)),
                                  color: item,
                                ),
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: width / 41),
                                      child: Image.asset(
                                        "lib/core/resources/assets/images/muhammad.png",
                                        color: Colors.orange,
                                        height: 100 * height / 820.5714285714286,
                                        width: 100 * width / 411.42857142857144,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: height / 4.9),
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft:
                                                  Radius.circular(width / 20.35),
                                              bottomRight:
                                                  Radius.circular(width / 20.35)),
                                          color: Color(0xfff5d7a2),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(top: height / 50),
                                          child: Text(
                                            "احاديث ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: width / 16,
                                              height: 1.2,
                                              fontFamily: "arabic",
                                              fontWeight: FontWeight.bold,
                                              color: item,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width / 80,
                            ),
                            GestureDetector(
                              onTap: () async {
                                _serviceEnabled = await location.serviceEnabled();
                                if(!_serviceEnabled!) {
                                  final AndroidIntent intent = new AndroidIntent(
                                    action: 'android.settings.LOCATION_SOURCE_SETTINGS',
                                  );
                                  await intent.launch();
                                }
                                else if(_serviceEnabled!)
                                {
                                  var status = await Permission.location.status;
                                  if (status.isGranted) {
                                    print("Permission is already Granted");
                                    AppCubit.get(context).chekcer();

                                  }
                                  else {
                                    Permission.location.request().then((value) {
                                      if(value.toString() == 'PermissionStatus.granted')
                                      {
                                        AppCubit.get(context).chekcer();
                                      }
                                    });
                                  }
                                }
                              },
                              child: Container(
                                height: height / 3.6,
                                width: width / 2.05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(width / 20.35),
                                      bottomLeft: Radius.circular(width / 20.35)),
                                  color: item,
                                ),
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: width / 41),
                                      child: Image.asset(
                                        "lib/core/resources/assets/images/kaaba.png",
                                        height: 100 * height / 820.5714285714286,
                                        width: 100 * width / 411.42857142857144,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: height / 4.9),
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight:
                                              Radius.circular(width / 20.35),
                                              bottomLeft:
                                              Radius.circular(width / 20.35)),
                                          color: Color(0xfff5d7a2),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsets.only(top: height / 50),
                                          child: Text(
                                            "القبلة",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: width / 16,
                                              height: 1.2,
                                              fontFamily: "arabic",
                                              fontWeight: FontWeight.bold,
                                              color: item,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: AppCubit.get(context).check,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(0, 0, 0, 0.5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(100.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              ]
            ),
          );
        });
  }
}
