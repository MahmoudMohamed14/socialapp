

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/user_model.dart';

import 'login_states.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());
  // LoginModel? loginModel;
  bool isScure=true;

  IconData suffix=Icons.visibility;
  static LoginCubit get(context){
    return BlocProvider.of(context);
  }

  void passwordLogin(){

    isScure=!isScure;
    suffix=isScure?Icons.visibility:Icons.visibility_off;
    emit(LoginPasswordState());

  }
 



  void login({

    required String password,
    required String email,




  }){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      print(value.user!.email);

      emit(LoginSuccessState(uId:value.user!.uid  ));
    }).catchError((error){
      print('error Login'+error.toString());
      emit(LoginErrorState(error: error.toString()));

    });


  }





}