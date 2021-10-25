import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/moduls/register/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitState());
  static RegisterCubit get(context){
    return BlocProvider.of(context);
  }
  UserModel? userModel;
void userRegister({
  required String name,
  required String password,
  required String email,
  required String phone,



}){
  emit(RegisterLoadingState());
  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
    print(value.user!.email);
    userModel=UserModel(
        name: name,
        email: email,
        password: password,
        phone: phone,
        uId: value.user!.uid,
        isEmailVerified: false,
        image: 'https://images.ctfassets.net/hrltx12pl8hq/7yQR5uJhwEkRfjwMFJ7bUK/dc52a0913e8ff8b5c276177890eb0129/offset_comp_772626-opt.jpg?fit=fill&w=800&h=300',
         bio: 'write your bio..',
      cover: 'https://previews.123rf.com/images/jackf/jackf1712/jackf171202251/91248255-happy-smiling-little-girl-and-boy-running-together-holding-hands-in-park-on-summer.jpg'

    );
    createUser(userModel: userModel);




  }).catchError((error){
    print('error Register'+error.toString());
    emit(RegisterErrorState(error: error.toString()));

  });


}
void createUser({
  UserModel? userModel

}){
  FirebaseFirestore.instance.collection('users').doc(userModel!.uId).set(userModel.toMap()).then((value) {
    emit(CreateUserSuccessState( ));
  }).catchError((error){
    print('error create user'+error.toString());
    emit(CreateUserErrorState(error: error.toString()));
  });
}
}