import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:socialapp/layout/cubit/social_cubit.dart';
import 'package:socialapp/layout/social_layout.dart';
import 'package:socialapp/shared/bloc_observer.dart';
import 'package:socialapp/shared/componants/constant.dart';
import 'package:socialapp/shared/sharedpreference/cach_helper.dart';

import 'moduls/login/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  uId=CacheHelper.get(key: 'uId');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
     providers: [
       BlocProvider(create: (BuildContext context)=>SocialCubit()..getUserData()..getPosts())
     ] ,
      child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              textTheme: TextTheme(
                bodyText1: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                bodyText2: TextStyle(color: Colors.black.withOpacity(.5),fontSize: 16,fontWeight: FontWeight.bold),
                headline3: TextStyle(color: Colors.black),
                subtitle1:  TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14,height: 1.3),


              ),
              bottomNavigationBarTheme:BottomNavigationBarThemeData(
                elevation: 20,
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed
              ) ,

              appBarTheme: AppBarTheme(

                backwardsCompatibility: false,
                actionsIconTheme: IconThemeData(
                    color: Colors.black
                ),

                iconTheme: IconThemeData(
                    color: Colors.black
                ),
                titleTextStyle: TextStyle(color: Colors.black),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark
                ),
                backgroundColor: Colors.white,
                elevation: 0,

              ),
              scaffoldBackgroundColor: Colors.white,

              primarySwatch: Colors.green,
            ),

            debugShowCheckedModeBanner: false,
            home:FirebaseAuth.instance.currentUser!=null?SocialLayout():LoginScreen(),
          )
    );




  }

}


