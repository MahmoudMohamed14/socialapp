


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:socialapp/layout/cubit/socail_states.dart';
import 'package:socialapp/layout/cubit/social_cubit.dart';
import 'package:socialapp/shared/componants/componants.dart';
import 'package:socialapp/style/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController=TextEditingController( );
  var bioController=TextEditingController();
  var phoneController=TextEditingController();
  var formKey=GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=SocialCubit.get(context);
        var userModel=cubit.userModel;
        nameController.text=userModel!.name!;
        bioController.text=userModel.bio! ;
        phoneController.text=userModel.phone!;
       var imageProfile=cubit.profileImage;
        var imageCover=cubit.coverImage;

        return Scaffold(
          appBar: defaultAppBar(context: context,title: 'Edit Profile',action: [
            defaultTextButton(name: 'UPDATE', onPress: (){
              if(formKey.currentState!.validate()){
                cubit.upDateData(
                  name: nameController.text,
                  phone: phoneController.text,
                  bio: bioController.text,
                  cover: cubit.coverImageUrl,
                  profile: cubit.profileImageUrl
                );

              }

            },),
            SizedBox(width: 20,)
          ]
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is UpdateLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(height: 15,),
                    Container(
                      height: 240,
                      child: Stack(

                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children:[
                                Container(
                                  width: double.infinity,
                                  height: 195,

                                  decoration: BoxDecoration(

                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),

                                      ),

                                      image:DecorationImage(
                                        fit: BoxFit.cover,
                                        image:imageCover==null? NetworkImage('${userModel.cover}',):FileImage(imageCover)as ImageProvider

                                      )

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                      child: IconButton(onPressed: (){
                                        cubit.getCoverImage().then((value) {
                                          cubit.uploadCoverImage();
                                        });

                                      }, icon: Icon(IconBroken.Camera))),
                                )
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 70,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 66,
                                 backgroundImage: imageProfile == null?NetworkImage('${userModel.image!}') : FileImage(imageProfile)as ImageProvider,
                              ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                    radius: 20,
                                    child: IconButton(onPressed: (){
                                      cubit.getProfileImage().then((value) {
                                        cubit.uploadProfileImage();
                                      });
                                    }, icon: Icon(IconBroken.Camera))),
                              )
                            ],
                          )

                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller:nameController ,
                      keyboardType: TextInputType.name,
                      validator: (String? s){
                        if(s!.isEmpty){
                          return 'Name is empty';
                        }return null;
                      },
                      decoration:InputDecoration(
                          labelText:'Name',
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(IconBroken.Profile),

                      ) ,
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller:bioController ,
                      keyboardType: TextInputType.text,
                      validator: (String? s){
                        if(s!.isEmpty){
                          return 'Bio is empty';
                        }return null;
                      },
                      decoration:InputDecoration(
                        labelText:'Bio',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(IconBroken.Info_Circle),

                      ) ,
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller:phoneController ,
                      keyboardType: TextInputType.phone,
                      validator: (String? s){
                        if(s!.isEmpty){
                          return 'Phone is empty';
                        }return null;
                      },
                      decoration:InputDecoration(
                        labelText:'Phone',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(IconBroken.Call),

                      ) ,
                    ),
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
