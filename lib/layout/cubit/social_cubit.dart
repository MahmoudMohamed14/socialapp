
import 'dart:io';
import 'dart:math';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/layout/cubit/socail_states.dart';
import 'package:socialapp/models/post_model.dart';

import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/moduls/add_post/add_post.dart';
import 'package:socialapp/moduls/chat/chat_screen.dart';
import 'package:socialapp/moduls/feeds/feeds_screen.dart';
import 'package:socialapp/moduls/setting/setting_screen.dart';
import 'package:socialapp/moduls/users/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:socialapp/shared/componants/constant.dart';


class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialStatesInitState());
  int index=0;
  List<Widget>screen=[
    FeedScreen(),
    ChatScreen(),
    AddPostScreen(),
    UsersScreen(),
    SettingScreen()
  ];

  List<String>title=[
    'Home',
    'Chats',
    '',
  'Users',
    'Setting'

  ];

  static SocialCubit get(context) {
    return BlocProvider.of(context);
  }
  UserModel? userModel;
  void getUserData(){
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      userModel=UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error){
      emit(GetUserErrorState(error: error.toString()));
    });
  }
  void  changeBottomNav({required int indx}){

    if(indx==2){

          emit(NewPostState());
    }else{
      index =indx;

      emit( ChangeBottomNavState());
    }


  }
  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickerSuccessState());
    } else {
      print('No image selected.');
      emit(ProfileImagePickerErrorState(error:'No image selected.' ));
    }

  }
  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImagePickerSuccessState());
    } else {
      print('No image selected.');
      emit(CoverImagePickerErrorState(error:'No image selected.' ));
    }

  }
  String?profileImageUrl;
  String?coverImageUrl;
  void uploadProfileImage(){
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).then((value){
          value.ref.getDownloadURL().then((value) {
           // FirebaseFirestore.instance.collection('users').doc(uId).update({'image':value});
            profileImageUrl=value;
           emit( ProfileImageUploadSuccessState());
            
          }).catchError((onError){
            emit(ProfileImageUploadErrorState());
            
          });

    }).catchError((error){
      emit(ProfileImageUploadErrorState());
      
    });

  }
  void uploadCoverImage(){
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!).then((value){
      value.ref.getDownloadURL().then((value) {
        // FirebaseFirestore.instance.collection('users').doc(uId).update({'image':value});
        coverImageUrl=value;
        emit( CoverImageUploadSuccessState());

      }).catchError((onError){
        emit(CoverImageUploadErrorState());
      });

    }).catchError((error){
      emit(CoverImageUploadErrorState());

    });

  }
  void upDateData({
    String? name,

    String? email,
    String? phone,
  String? cover,
     String? profile,
    String? bio,



  }){
emit(UpdateLoadingState());

  var  modelUpdate=UserModel(

        name: name??userModel!.name,
        phone: phone??userModel!.phone,
        isEmailVerified: false,
        email: userModel!.email,
        password: userModel!.password,
        uId:userModel!.uId,
        image:profile??userModel!.image,
        bio: bio??userModel!.bio ,
        cover: cover??userModel!.cover

    );



   FirebaseFirestore.instance.collection('users').doc(uId).update(modelUpdate.toMap()).then((value) {
     getUserData();

    }).catchError((error){
      print('UpdateErrorState '+error.toString());
      emit(UpdateErrorState (error:error.toString() ));


    });


  }
  String?postImageUrl;
  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile!= null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickerSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickerErrorState(error:'No image selected.' ));
    }

  }
  void removeImageFile(){
    postImage=null;
    emit(PostImageRemoveSuccessState());

  }

  void uploadPostImage({
    required String dateTime,
    required String text,

}){
    emit(PostImagePickerLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!).then((value){
      value.ref.getDownloadURL().then((value) {
        // FirebaseFirestore.instance.collection('users').doc(uId).update({'image':value});
        postImageUrl=value;
        createPost(dateTime: dateTime, text: text,postImage: postImageUrl);



      }).catchError((onError){
        emit(ProfileImageUploadErrorState());
      });

    }).catchError((error){
      emit(ProfileImageUploadErrorState());

    });

  }


void createPost(
  {
   required String dateTime,
   required String text,
    String ?postImage
}
    ){
  posts=[];
  emit(CreatePostLoadingState());
    var postModel=PostModel(postImage:postImage??'',text:text
        ,dateTime:dateTime,name: userModel!.name,uId: userModel!.uId,image:userModel!.image );
  FirebaseFirestore.instance.collection('posts').add(postModel.toMap()).then((value) {
    getPosts();
    emit(CreatePostSuccessState());

  }).catchError((error){
    print('create poste error'+error.toString());
    emit(CreatePostErrorState(error:error.toString() ));

  });

}
  List<PostModel>posts=[];
  List<String>postId=[];
  List<int>likes=[];
   void getPosts({bool islike=false}){
     likes=[];
     postId=[];
     emit(GetPostsLoadingState());
     FirebaseFirestore.instance.collection('posts').get().then((value){

       value.docs.forEach((element) {
         element.reference.collection('likes').get().then((value) {
           likes.add(value.docs.length);
           postId.add(element.id);
          if(!islike)
            posts.add(PostModel.fromJson(element.data()));
           emit(GetPostsSuccessState());
         });

       });

     }).catchError((onError){
       print(onError.toString());
       emit(GetPostsErrorState());
     });


   }

   void likePost({
  required  String idPost
}){
     FirebaseFirestore
         .instance
         .collection('posts')
         .doc(idPost)
         .collection('likes')
         .doc(userModel!.uId)
         .set({'like':true})
         .then((value) {

           emit(PostsLikeSuccessState());
           getPosts(islike: true);


     }).catchError((onError){
       emit(PostsLikeErrorState(error: onError.toString()));

     });

   }
}