


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/socail_states.dart';
import 'package:socialapp/layout/cubit/social_cubit.dart';
import 'package:socialapp/moduls/setting/edit_profile.dart';
import 'package:socialapp/shared/componants/componants.dart';
import 'package:socialapp/style/icon_broken.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder:(context,state){
        var cubit=SocialCubit.get(context);
        var userModel=cubit.userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 240,
                  child: Stack(

                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: double.infinity,
                          height: 195,

                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),

                              ),

                              image:DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage('${userModel!.cover}',),

                              )

                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 66,
                          backgroundImage:  NetworkImage('${userModel!.image}',)
                          ,
                        ),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Text('${userModel.name}',style: Theme.of(context).textTheme.bodyText1,),
                SizedBox(height: 7,),
                Text('${userModel.bio}',style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 15),),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){

                          },
                          child: Column(
                            children: [
                              Text('123',style:  Theme.of(context).textTheme.bodyText1,),
                              Text('Post',style:Theme.of(context).textTheme.caption!.copyWith(fontSize: 15),),

                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){

                          },
                          child: Column(
                            children: [
                              Text('123',style:  Theme.of(context).textTheme.bodyText1,),
                              Text('Post',style:Theme.of(context).textTheme.caption!.copyWith(fontSize: 15),),

                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){

                          },
                          child: Column(
                            children: [
                              Text('123',style:  Theme.of(context).textTheme.bodyText1,),
                              Text('Post',style:Theme.of(context).textTheme.caption!.copyWith(fontSize: 15),),

                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){

                          },
                          child: Column(
                            children: [
                              Text('123',style:  Theme.of(context).textTheme.bodyText1,),
                              Text('Post',style:Theme.of(context).textTheme.caption!.copyWith(fontSize: 15),),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: OutlinedButton(
                      child: Text('Add Photo'),
                        onPressed: (){

                        },
                    )),
                    SizedBox(width: 10,),
                    OutlinedButton(
                      child: Icon(IconBroken.Edit),
                      onPressed: (){
                        navigateTo(context, EditProfileScreen());

                      },
                    )
                  ],
                )

              ],
            ),
          ),
        );
      } ,

    );
  }
}
