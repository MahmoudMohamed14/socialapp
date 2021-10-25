


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/cubit/socail_states.dart';
import 'package:socialapp/layout/cubit/social_cubit.dart';
import 'package:socialapp/shared/componants/componants.dart';
import 'package:socialapp/style/icon_broken.dart';

class AddPostScreen extends StatelessWidget {
  var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
    listener: (context,state){
      if(state is CreatePostSuccessState){
        SocialCubit.get(context).removeImageFile();
        Navigator.pop(context);

      }
    },
    builder: (context,state){
      var cubit=SocialCubit.get(context);
      return Scaffold(appBar: defaultAppBar(context: context,
          title: 'Add Post',
          action: [defaultTextButton(onPress: (){
            var timeDate=DateTime.now();
            if(cubit.postImage!=null){

              cubit.uploadPostImage(dateTime:timeDate.toString(), text: textController.text);
            }else{
              cubit.createPost(dateTime:timeDate.toString(), text: textController.text);
            }



          }, name: 'Post')]
      ),
        body: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(

            children: [
              SizedBox(height: 15),
              if(state is CreatePostLoadingState ||state is PostImagePickerLoadingState)
                LinearProgressIndicator(),
              SizedBox(height: 15),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage:NetworkImage(  'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',),
                    radius: 25,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text("mahmoud mohamed",style: Theme.of(context).textTheme.bodyText1!.copyWith(height: 1.4),),

                  ),
                  //Spacer(),
                  SizedBox(width: 15),


                ],

              ),
              SizedBox(height: 15),
              Expanded(
                child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                      hintText: 'what is on your mind...?',

                      border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(height: 15),
             if(cubit.postImage!=null)
               Stack(
                alignment: AlignmentDirectional.topEnd,
                children:[
                  Container(
                    width: double.infinity,
                    height: 200,

                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),

                        ),

                        image:DecorationImage(
                            fit: BoxFit.cover,
                            image:FileImage(cubit.postImage!),

                        )

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                        radius: 20,
                        child: IconButton(onPressed: (){

                            cubit.removeImageFile();


                        }, icon: Icon(Icons.close))),
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      cubit.getPostImage().then((value) {

                      }).catchError((onError){
                        print(onError.toString());
                      });

                    }, child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(IconBroken.Image),
                        SizedBox(width: 5,),
                        Text('add photo')
                      ],
                    )),
                  ),
                  Expanded(
                    child: TextButton(onPressed: (){

                    }, child: Text('#tag')),
                  )
                ],
              ),
            ],
          ),
        ),

      ) ;
    }


    );
  }
}
