

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/socail_states.dart';
import 'package:socialapp/layout/cubit/social_cubit.dart';
import 'package:socialapp/moduls/add_post/add_post.dart';
import 'package:socialapp/shared/componants/componants.dart';

import 'package:socialapp/style/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is NewPostState){
          navigateTo(context, AddPostScreen());
        }
      },
      builder:(context,state){
        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(

            actions: [
              // IconButton(onPressed: (){
              //   FirebaseAuth.instance.signOut().then((value) {
              //     CacheHelper.removeWithKey(key: 'uId');
              //     navigateAndFinish(context, LoginScreen());
              //   });
              // }, icon: Icon(Icons.logout))
              IconButton(onPressed: (){

              }, icon: Icon(IconBroken.Notification)),
              IconButton(onPressed: (){

              }, icon: Icon(IconBroken.Search)),
            ],
            title: Text(cubit.title[cubit.index],style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 22,fontWeight: FontWeight.bold),),
          ),
          body: cubit.screen[cubit.index],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.index,
            onTap: (index){
              cubit.changeBottomNav(indx: index);
            },
            items: [
              BottomNavigationBarItem(icon:Icon(IconBroken.Home),label: 'Home'),
              BottomNavigationBarItem(icon:Icon(IconBroken.Chat),label: 'Chats'),
              BottomNavigationBarItem(icon:Icon(IconBroken.Paper_Upload),label: 'Post'),
              BottomNavigationBarItem(icon:Icon(IconBroken.Location),label: 'Users'),
              BottomNavigationBarItem(icon:Icon(IconBroken.Setting),label: 'Setting'),


            ],
          ),
          // body: ConditionalBuilder(
          //   condition: SocialCubit.get(context).userModel!=null,
          //   builder: (contex){
          //     var model=SocialCubit.get(context).userModel;
          //     return Column(
          //       children: [
          //         if(!model!.isEmailVerified!)
          //         Container(
          //           color: Colors.amber.withOpacity(.6),
          //           child: Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 10),
          //             child: Row(
          //
          //
          //               children: [
          //                 Icon(Icons.info_outline),
          //                 SizedBox(width: 10,),
          //                 Text('Please verify your email'),
          //                 Spacer(),
          //                 defaultTextButton(
          //                     name:'Send' ,
          //                     onPress: (){
          //                       FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
          //                         showToast(message: 'Check your mail', toastStates: ToastStates.SUCCESS);
          //
          //                       });
          //
          //                     }
          //
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //
          //       ],
          //     );
          //   },
          //  fallback: (context)=>Center(child: CircularProgressIndicator()),
          // ),
        );
      } ,

    );
  }
}
