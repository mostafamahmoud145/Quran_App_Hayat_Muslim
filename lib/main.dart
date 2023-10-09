import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramadan/view/home/home_screen.dart';
import 'package:ramadan/view_model/blocs/app_cubit/cubit.dart';
import 'package:ramadan/view_model/blocs/app_cubit/states.dart';
import 'package:ramadan/view_model/network/local/shared_preferences.dart';
import 'package:ramadan/core/utils/bloc_observer.dart';
import 'package:ramadan/core/resources/constants.dart';
import 'package:ramadan/view_model/network/remote/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]).then((value) => (){runApp(MyApp());});
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  check=CashHelper.getData(key: 'check');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    if(check == true)
      {
        return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context)=> AppCubit(AppInitialState())..createDatabase()..getCategory()),
            ], child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Directionality(
              textDirection: TextDirection.ltr,
              child: HomePage()),
        )
        );
      }
    else
      {
        return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context)=> AppCubit(AppInitialState())..createDatabase()..insertIntoJuzs()..insertIntoPages()..insertIntoSurah()..checkOpen()..getCategory()),
            ], child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Directionality(
              textDirection: TextDirection.ltr,
              child: HomePage()),
        )
        );
      }
  }
}

