

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/socail_states.dart';
import 'package:socialapp/layout/cubit/social_cubit.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/style/icon_broken.dart';


class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder:(context,state){
        var cubit=SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.posts.length>0&&cubit.userModel!=null,
          builder: (context)=>SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  margin: EdgeInsets.all(8),
                  child: Stack(

                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 200,
                        image: NetworkImage(  'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                        child: Text('communicate with friends',style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 16,color: Colors.white),),
                      )
                    ],
                  ),
                ),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index)=>buildPostItem(context: context,postModel:cubit.posts[index],index: index),
                    separatorBuilder:(context,index)=> SizedBox(height: 20,),
                    itemCount: cubit.posts.length),
                SizedBox(height: 10,)
              ],
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      } ,

    );
  }
  Widget buildPostItem({
  required context,
    required PostModel postModel,
   required index

}){
    return Card(

      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,

      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(

              children: [
                CircleAvatar(
                  backgroundImage:NetworkImage(  '${postModel.image}',),
                  radius: 25,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(

                        children: [
                          Text("${postModel.name}",style: Theme.of(context).textTheme.bodyText1!.copyWith(height: 1.4),),
                          SizedBox(width: 10,),
                          Icon(Icons.check_circle,color: Colors.green,size: 16,),



                        ],
                      ),
                      Text('${postModel.dateTime}',style: Theme.of(context).textTheme.caption!.copyWith(height: 1.4),),
                    ],
                  ),

                ),
                //Spacer(),
                SizedBox(width: 15),
                IconButton(onPressed: (){

                }, icon: Icon(Icons.more_horiz,size: 20,))

              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: double.infinity,
                color: Colors.grey[300],
                height: 1,
              ),
            ),
            Text(
              ' ${postModel.text}',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   child: Container(
            //     width: double.infinity,
            //     child: Wrap(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 7),
            //           child: Container(
            //             height: 25,
            //             child: MaterialButton(
            //               height: 25,
            //               minWidth: 1,
            //               padding: EdgeInsets.zero,
            //               onPressed: (){
            //
            //
            //               },
            //               child: Text('#mahnoud',style: TextStyle(color: Colors.green),),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 7),
            //           child: Container(
            //             height: 25,
            //             child: MaterialButton(
            //               height: 25,
            //               minWidth: 1,
            //               padding: EdgeInsets.zero,
            //               onPressed: (){
            //
            //
            //               },
            //               child: Text('#mahnoud',style: TextStyle(color: Colors.green),),
            //             ),
            //           ),
            //         ),
            //
            //
            //       ],
            //     ),
            //   ),
            // ),
            if(postModel.postImage !='')
               Padding(
              padding: const EdgeInsetsDirectional.only(top: 15),
              child: Container(
                height: 320,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(image:  NetworkImage(  '${postModel.postImage}'
                  ),
                    fit: BoxFit.cover,
                  ),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Icon(IconBroken.Heart,
                              size: 16,
                              color: Colors.red,
                            ),
                            SizedBox(width: 5,),
                            Text(SocialCubit.get(context).likes.isNotEmpty?'${SocialCubit.get(context).likes[index]}':'0',style: Theme.of(context).textTheme.caption ,),
                          ],
                        ),
                      ),
                      onTap: (){

                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(IconBroken.Chat,
                              size: 16,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 5,),
                            Text('120 comment',style: Theme.of(context).textTheme.caption ,),
                          ],
                        ),
                      ),
                      onTap: (){

                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 10),
              child: Container(
                width: double.infinity,
                color: Colors.grey[300],
                height: 1,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:NetworkImage('${SocialCubit.get(context).userModel!.image}'),
                          radius: 15,
                        ),
                        SizedBox(width: 10,),
                        Text('Write a Comment...',style: Theme.of(context).textTheme.caption ,),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8,),
                  child: InkWell(
                    child: Row(
                      children: [
                        Icon(IconBroken.Heart,
                          size: 20,
                          color: Colors.red,
                        ),
                        SizedBox(width: 5,),
                        Text('Like',style: Theme.of(context).textTheme.caption ,),
                      ],
                    ),
                    onTap: (){
                      SocialCubit.get(context).likePost(idPost:SocialCubit.get(context).postId[index] );

                    },
                  ),
                ),



              ],
            )

          ],
        ),
      ),
    );
  }
}
