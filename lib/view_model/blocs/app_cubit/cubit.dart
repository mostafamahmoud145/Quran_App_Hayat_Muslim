import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:ramadan/model/times_model.dart';
import 'package:ramadan/view_model/network/local/shared_preferences.dart';
import 'package:ramadan/view_model/blocs/app_cubit/states.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/resources/constants.dart';
import '../../network/remote/dio_helper.dart';



class AppCubit extends Cubit<AppStates> {
  AppCubit(super.initialState);

  static AppCubit get(context) => BlocProvider.of(context);
  late Database database;
  List juz =[];
  List pages=[];
  List surahs=[];

  List<Map<String, dynamic>> itemsSurah=[];
  List<Map<String, dynamic>> itemsPage=[];
  List<Map<String, dynamic>> itemsJuz=[];

  List<Map<String, dynamic>> surahDetails=[];
  List<Map<String, dynamic>> pageDetails=[];
  List<Map<String, dynamic>> juzDetails=[];

  int? index;
  int count=0;

  void getCount(){
    count = CashHelper.getData(key: 'count')??0;
  }

  void getDataFromDatabase (Database database) async {
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM pages').then((value) {
      value.forEach((element)
      {
        pages.add(element);
      });
      //print(value);
      emit(AppGetDatabaseState());
      for(int i = 0 ; i < value.length; i++)
      {
        itemsPage.add({'id': value[i]['id'], 'start': value[i]['start_surah_id'], 'end':value[i]['end_surah_id']});
      }
    });
    database.rawQuery('SELECT * FROM juzs').then((value) {
      value.forEach((element)
      {
        juz.add(element);
      });
      emit(AppGetDatabaseState());
      //print(value);
      for(int i = 0 ; i < value.length; i++)
      {
        itemsJuz.add({'id': value[i]['id'], 'start': value[i]['start_surah_id'], 'end':value[i]['end_surah_id'], 'name': value[i]['juz_num']});
      }
    });

    database.rawQuery('SELECT * FROM surahs').then((value) {
      value.forEach((element)
      {
        surahs.add(element);
      });
      emit(AppGetDatabaseState());
      //print(value[0]['arabic']);
      for(int i = 0 ; i < value.length; i++)
        {
          itemsSurah.add({'name': value[i]['arabic'], 'id': value[i]['id']});
        }
      getSurah();
      getPage();
    });

  }

  void createDatabase() async {
    database = await openDatabase(
        'quran.db',
        version: 1,
        onCreate: (Database database, int version) {
          // When creating the db, create the table
          print("database is created");

          database.execute(
              'CREATE TABLE juzs (id INTEGER, start_surah_id INTEGER, start_verse_id INTEGER, end_surah_id INTEGER, end_verse_id INTEGER, juz_num TEXT)').then((value){
            print("juzs table is created");
          }).catchError((onError){
            print("error when creating juzs table ${onError.toString()}");
          });

          database.execute(
              'CREATE TABLE surahs (id INTEGER, arabic TEXT, latin TEXT, english TEXT, localtion TEXT, sajda TEXT, ayah INTEGER)').then((value){
            print("surahs table is created");
          }).catchError((onError){
            print("error when creating surahs table ${onError.toString()}");
          });

          database.execute(
              'CREATE TABLE pages (id INTEGER, start_surah_id INTEGER, start_verse_id INTEGER, end_surah_id INTEGER, end_verse_id INTEGER)').then((value){
            print("pages table is created");
          }).catchError((onError){
            print("error when creating pages table ${onError.toString()}");
          });

        },
        onOpen: (database){
          getDataFromDatabase(database);
          print("Database is opened");
        }
    ).then((value) {
      emit(AppCreateDatabaseState());
      return value;
    });
  }

  Future<void> insertIntoJuzs() async {
    database = await openDatabase(
        'quran.db',
        version: 1,
        onOpen: (database) {
          print("Database is opened");
        }
    );
    database.transaction((txn) {
      txn.rawInsert(Juzs).then((value){
        emit(AppInsertDatabaseState());
        print('${value.toString()}inserted successfully');
        getDataFromDatabase(database);
      }).catchError((onError) {
        print(
            'error when inserting record${onError
                .toString()}');
      });
      return Future(() => null);
    }).then((value) {
      emit(AppInsertDatabaseState());
    });
  }
  Future<void> insertIntoPages() async {
    database = await openDatabase(
        'quran.db',
        version: 1,
        onOpen: (database) {
          print("Database is opened");
        }
    );
    database.transaction((txn) {
      txn.rawInsert(Pages).then((value){
        emit(AppInsertDatabaseState());
        print('${value.toString()}inserted successfully');
        getDataFromDatabase(database);
      }).catchError((onError) {
        print(
            'error when inserting record${onError
                .toString()}');
      });
      return Future(() => null);
    }).then((value) {
      emit(AppInsertDatabaseState());
    });
  }
  Future<void> insertIntoSurah() async {
    database = await openDatabase(
        'quran.db',
        version: 1,
        onOpen: (database) {
          print("Database is opened");
        }
    );
    database.transaction((txn) {
      txn.rawInsert(Surah).then((value){
        emit(AppInsertDatabaseState());
        print('${value.toString()}inserted successfully');
        getDataFromDatabase(database);
      }).catchError((onError) {
        print(
            'error when inserting record${onError
                .toString()}');
      });
      return Future(() => null);
    }).then((value) {
      emit(AppInsertDatabaseState());
    });
  }

  String? juzName;
  void getSurah(){
    for(int i = 0; i < itemsSurah.length ; i++)
      {
        for(int j = i ; j < itemsPage.length;j++)
          {
            if((itemsSurah[i]['id'] == itemsPage[j]['start']) || ((itemsSurah[i]['id'] >= itemsPage[j]['start'])&& (itemsSurah[i]['id'] <= itemsPage[j]['end'])))
            {
              surahDetails.add({'id': itemsSurah[i]['id'], 'name': itemsSurah[i]['name'], 'start': itemsPage[j]['id']});
              break;
            }
          }
      }
  }
  void getPage(){
    for(int i = 0 ; i < itemsPage.length ;i++){
      for(int j = 0 ; j < itemsSurah.length;j++){
        if(itemsPage[i]['start'] == itemsSurah[j]['id']){
          pageDetails.add({'id': itemsPage[i]['id'], 'name':itemsSurah[j]['name'], 'surahID':itemsSurah[j]['id']});
          break;
        }
      }
    }
    print(pageDetails[3]);
  }

  String? getJuz(int num){
    if(num >= 1 && num <= 21)
      return juzName = 'الجزء الأول';
    else if(num >= 22 && num <= 41)
      return juzName = 'الجزء الثاني';
    else if(num >= 42 && num <= 61)
      return juzName = "الجزء الثالث";
    else if(num >= 62 && num <= 81)
      return juzName = "الجزء الرابع";
    else if(num >= 82 && num <= 101)
      return juzName = "الجزء الخامس";
    else if(num >= 102 && num <= 121)
      return juzName = "الجزء السادس";
    else if(num >= 122 && num <= 141)
      return juzName = "الجزء السابع";
    else if(num >= 142 && num <= 161)
      return juzName = "الجزء الثامن";
    else if(num >= 162 && num <= 181)
      return juzName = "الجزء التاسع";
    else if(num >= 182 && num <= 201)
      return juzName = "الجزء العاشر";
    else if(num >= 202 && num <= 221)
      return juzName = "الجزء الحادي عشر";
    else if(num >= 222 && num <= 241)
      return juzName = "الجزء الثاني عشر";
    else if(num >= 242 && num <= 261)
      return juzName = "الجزء الثالث عشر";
    else if(num >= 262 && num <= 281)
      return juzName = "الجزء الرابع عشر";
    else if(num >= 282 && num <= 301)
      return juzName = "الجزء الخامس عشر";
    else if(num >= 302 && num <= 321)
      return juzName = "الجزء السادس عشر";
    else if(num >= 322 && num <= 341)
      return juzName = "الجزء السابع عشر";
    else if(num >= 342 && num <= 361)
      return juzName = "الجزء الثامن عشر";
    else if(num >= 362 && num <= 381)
      return juzName = "الجزء التاسع عشر";
    else if(num >= 382 && num <= 401)
      return juzName = "الجزء العشرون";
    else if(num >= 402 && num <= 421)
      return juzName = "الجزء الحادي والعشرون";
    else if(num >= 422 && num <= 441)
      return juzName = "الجزء الثاني والعشرون";
    else if(num >= 442 && num <= 461)
      return juzName = "الجزء الثالث والعشرون";
    else if(num >= 462 && num <= 481)
      return juzName = "الجزء الرابع والعشرون";
    else if(num >= 482 && num <= 501)
      return juzName = "الجزء الخامس والعشرون";
    else if(num >= 502 && num <= 521)
      return juzName = "الجزء السادس والعشرون";
    else if(num >= 522 && num <= 541)
      return juzName = "الجزء السابع والعشرون";
    else if(num >= 542 && num <= 561)
      return juzName = "الجزء الثامن والعشرون";
    else if(num >= 562 && num <= 581)
      return juzName = "الجزء التاسع والعشرون";
    else if(num >= 582 && num <= 604)
      return juzName = "الجزء الثلاثون";

  }

  void save(int num){
    CashHelper.saveData(key: 'saved', value: num);
    changePage(num-1);
    print("saveee${num}");
  }

  int? saved;
  int? last;
  PageController controller = PageController();
  void getSave(){
    saved = CashHelper.getData(key: 'saved');
    changePage(saved!-1);
  }

  void getFirstSave(){
    saved = CashHelper.getData(key: 'saved');
  }

  void saveLast(num){
    CashHelper.saveData(key: 'last', value: num);
    last = CashHelper.getData(key: 'last');
    print('saveeee${last}');
  }

  void getLast(){
    last = CashHelper.getData(key: 'last')??0;
    controller = PageController(initialPage: last!);
    print("lastttttt ${last}");
  }


  void checkOpen (){
    CashHelper.saveData(key: "check", value: true);
  }

  bool check = false;

  void chekcer()
  {
    check  = true;
    emit(AppLoadingState());
  }

  void notChekcer()
  {
    check  = false;
    emit(AppNotLoadingState());
  }

  bool? load;
  void loading()
  {
    load = true;
    emit(AppCheckState());
  }

  void notLoading()
  {
    load = false;
    emit(AppNotCheckState());
  }


  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? maghrib;
  String? isha;

  Times? times;

  String? long;
  String? lat;

  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
      long = value.longitude.toString();
      lat = value.latitude.toString();
      adhan();
      return value;
    });

  }
  Future<void> adhan()async {
    DateTime dateTime = DateTime.now();

    int day = dateTime.day;       // get day as a number (1-31)
    int month = dateTime.month;   // get month as a number (1-12)
    int year = dateTime.year;
    emit(AppGetTimesLoadingState());
    DioHelper.getData(
        url: 'v1/calendar/${year}/${month}',
        query: {
          'latitude' : lat,
          'longitude' : long,
          'method' : '5',
    }).then((value) {
      times = Times.fromJson(value.data);

      String? isha24 = times!.data![day-1].timings!.isha?.substring(0,5);   // 24-hour format time
      DateTime time = DateFormat('HH:mm').parse(isha24!);   // parse time string
      isha = DateFormat('h:mm a').format(time);

      String? fajr24 = times!.data![day-1].timings!.fajr?.substring(0,5);   // 24-hour format time
      DateTime fajrtime = DateFormat('HH:mm').parse(fajr24!);   // parse time string
      fajr = DateFormat('h:mm a').format(fajrtime);

      String? sunrise24 = times!.data![day-1].timings!.sunrise?.substring(0,5);   // 24-hour format time
      DateTime sunrisetime = DateFormat('HH:mm').parse(sunrise24!);   // parse time string
      sunrise = DateFormat('h:mm a').format(sunrisetime);

      String? duhr24 = times!.data![day-1].timings!.dhuhr?.substring(0,5);   // 24-hour format time
      DateTime duhrtime = DateFormat('HH:mm').parse(duhr24!);   // parse time string
      dhuhr = DateFormat('h:mm a').format(duhrtime);

      String? asr24 = times!.data![day-1].timings!.asr?.substring(0,5);   // 24-hour format time
      DateTime asrtime = DateFormat('HH:mm').parse(asr24!);   // parse time string
      asr = DateFormat('h:mm a').format(asrtime);

      String? maghrib24 = times!.data![day-1].timings!.maghrib?.substring(0,5);   // 24-hour format time
      DateTime maghribtime = DateFormat('HH:mm').parse(maghrib24!);   // parse time string
      maghrib = DateFormat('h:mm a').format(maghribtime);

      emit(AppGetTimesDoneState());
    }).catchError((error) {
      print("error$error");
      emit(AppGetTimesErrorState());
    });
  }

  int pageNum=1;
  void changePage(number){
    pageNum = number;
    controller.jumpToPage(number);
    emit(AppChangePageState());
  }
  
  List<Map<String, dynamic>> azkarDetail = azkar;
  List<Map<String,dynamic>> category = [];
  
  void getCategory(){
    for(int i =0 ; i < azkarDetail.length ; i++){
      String cat = azkarDetail[i]['category'];
      List<Map<String, dynamic>> items=[];
      for(int j = i ; j < azkarDetail.length ; j++)
        {
          if(azkarDetail[j]['category'] == cat){
            items.add({'zekr':azkarDetail[j]['zekr'], 'count':azkarDetail[j]['count']});
          }
          else{
            i = j;
            break;
          }
        }
      category.add({'category': cat, 'item':items});
    }
    print('ffffffffffff${category[0]['item'][0]['count']}');

  }

}
