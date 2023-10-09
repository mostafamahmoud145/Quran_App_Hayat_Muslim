import 'dart:async';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

import '../../view_model/blocs/app_cubit/cubit.dart';
import '../../view_model/blocs/app_cubit/states.dart';

class QiblahScreen extends StatefulWidget {
  const QiblahScreen({super.key});

  @override
  State<QiblahScreen> createState() => _QiblahScreenState();
}

class _QiblahScreenState extends State<QiblahScreen>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? _animationController;
  double begin = 0.0;
  StreamSubscription? _subscription;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
    super.initState();
    _subscribeToStream();
  }

  void _subscribeToStream() {
    final myStream = FlutterQiblah.qiblahStream.asBroadcastStream()
        .handleError((error) {
      // Handle the error and clear it
      return;
    });

    _subscription = myStream.listen((data) {
      // Handle the stream data here
    }, onError: (error) {
      // Handle stream errors here
    });
  }

  void _cancelSubscription() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  dispose() {
    _cancelSubscription();
    _animationController?.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
          backgroundColor: Color.fromRGBO(22, 35, 79, 0.5),
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.navigate_before,size: width/18,)),
            backgroundColor: Color(0xff17203d),
            title: Text("Qibalh",style: TextStyle(
                fontSize: width/21
            ),),
          ),
          body: StreamBuilder(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
              if (snapshot.data == ConnectivityResult.mobile ||
                  snapshot.data == ConnectivityResult.wifi) {
                print('qiblaaaaa${snapshot.data}');
                return Qibla();
              }
              else {
                print(AppCubit.get(context).load);
                print('tryagain: ${snapshot.data}');
                return tryAgain();
              }
            },
          ),
        );
  }

  Widget Qibla() => StreamBuilder(
        stream: FlutterQiblah.qiblahStream,
        builder: (context, snapshot) {
          print('erorrrrr state${snapshot.data}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ));
          }
          QiblahDirection? qiblahDirection;
          qiblahDirection = snapshot.data as QiblahDirection?;
          if (qiblahDirection is QiblahDirection) {
            animation = Tween(
                begin: begin,
                end: (qiblahDirection.qiblah * (pi / 180) * -1))
                .animate(_animationController!) as Animation<double>?;
            begin = (qiblahDirection.qiblah * (pi / 180) * -1);
            _animationController!.forward(from: 0);
            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${qiblahDirection.direction.toInt()}°",
                      style: const TextStyle(
                          color: Colors.white, fontSize: 24),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 300,
                        child: AnimatedBuilder(
                          animation: animation!,
                          builder: (context, child) =>
                              Transform.rotate(
                                  angle: animation!.value,
                                  child: Image.asset(
                                    'lib/core/resources/assets/images/qibla-compass.png',
                                    color: Colors.orange,
                                  )),
                        ))
                  ]),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          else {
            print('Error${snapshot.connectionState}');
            return Center(
              child: MaterialButton(
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: Text('Try Again'),
              ),
            );
          }
        },
      );

  Widget tryAgain() =>
      BlocProvider(
        create: (BuildContext context) => AppCubit(AppCheckState())..loading(),
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (context,state) {

            },
            builder: (context, state) {
              print(AppCubit.get(context).load);
              Timer(Duration(seconds: 2), () {
                AppCubit.get(context).notLoading();
                print(AppCubit.get(context).load);
              }
              );
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: AppCubit.get(context).load!,
                      child: CircularProgressIndicator(),
                    ),
                    Visibility(
                      visible: !(AppCubit.get(context).load!),
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Please connect to internet and try again",
                          style: TextStyle(color: Colors.white),),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                            color: Colors.white,
                            child: Text("Try Again"),
                            onPressed: () {
                              setState(() {});
                              Navigator.pop(context);
                            }),
                      ],
              ),
                    ),
                  ],
                ),
              );
            }),
      );
}