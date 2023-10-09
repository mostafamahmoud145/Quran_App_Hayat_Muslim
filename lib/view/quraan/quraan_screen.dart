import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramadan/view/surah_fehres/surah_fehres_screen.dart';
import '../../view_model/blocs/app_cubit/cubit.dart';
import '../../view_model/blocs/app_cubit/states.dart';
import '../safha_fehres/safha_fehres_screen.dart';

class Pagee extends StatefulWidget {
  const Pagee({
    Key? key,
    this.color = const Color(0xFFFFE306),
    this.child,
  }) : super(key: key);

  final Color color;
  final Widget? child;

  @override
  State createState() => _BirdState();

}

class _BirdState extends State {
  bool show = false;
  int num = 1;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state){
      },
      builder: (context, state){

        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
              body: InkWell(
                onTap: () {
                  setState(() {
                    show = !show;
                  });
                },
                child: Stack(
                  children: [
                    PageView.builder(
                        controller: AppCubit.get(context).controller,
                        itemCount: 604,
                        onPageChanged: (index) {
                          setState(() {
                            print('index${index}');
                            AppCubit.get(context)..saveLast(index);
                          });
                        },
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return page(context, index);
                        }
                    ),
                    Visibility(
                      visible: AppCubit.get(context).saved == AppCubit.get(context).last!+1,
                        child: Positioned(
                          top: 0,
                          left: 0,
                          child: Image.asset('lib/core/resources/assets/images/save.png',height: height/24,color: Colors.red.withOpacity(0.6)),
                        )),
                    Visibility(
                      visible: show,
                      child: Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: height/8.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(width/39),bottomRight: Radius.circular(width/39),),
                            color: Color.fromRGBO(46, 32, 32, 0.9),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width/48),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => const Surah()),
                                              );
                                            },
                                            child: Text("الفهرس", style: TextStyle(
                                                fontFamily: 'arabic',
                                                color: Colors.white,
                                                fontSize: width/22
                                            ))),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        height: 0.8,
                                      ),
                                      Expanded(
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => const Safha()),
                                              );
                                            },
                                            child: Text("الصفحات", style: TextStyle(
                                                fontFamily: 'arabic',
                                                color: Colors.white,
                                                fontSize: width/22
                                            ))),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 0.5,
                                  color: Colors.white,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                AppCubit.get(context)..save(AppCubit.get(context).last!+1);
                                                AppCubit.get(context)..getSave();
                                              });
                                            },
                                            child: Text("حفظ علامة", style: TextStyle(
                                                fontFamily: 'arabic',
                                                color: Colors.white,
                                                fontSize: width/22
                                            ))),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        height: 0.8,
                                      ),
                                      Expanded(
                                        child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                AppCubit.get(context)..getSave();
                                              });
                                            },
                                            child: Text("انتقال الي العلامة", style: TextStyle(
                                                fontFamily: 'arabic',
                                                color: Colors.white,
                                                fontSize: width/22
                                            ))),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: show,
                      child: Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: height/17
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(width/39),topRight: Radius.circular(width/39),),
                            color: Color.fromRGBO(46, 32, 32, 0.9),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width/48),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(AppCubit.get(context).getJuz(AppCubit.get(context).last!+1)!,
                                    style: TextStyle(
                                        fontFamily: 'arabic',
                                        color: Colors.white,
                                        fontSize: width/24
                                    ),),
                                ),
                                Spacer(),
                                Text((AppCubit.get(context).last!+1).toString(),textAlign: TextAlign.center,style: TextStyle(
                                    fontSize: width/24,
                                    fontFamily: 'arabic',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),),
                                Spacer(),
                                Expanded(
                                  child: Text(AppCubit.get(context).pageDetails[AppCubit.get(context).last!]['name'],
                                    style: TextStyle(
                                        fontFamily: 'arabic',
                                        color: Colors.white,
                                        fontSize: width/24
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
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

Widget page(context, int m) {
  print(m);
  return Image.asset("lib/core/resources/assets/images/Quran/${m+1}.png", fit: BoxFit.fill,);
}

