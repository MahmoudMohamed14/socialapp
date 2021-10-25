import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_layout.dart';

import 'package:socialapp/shared/componants/componants.dart';

import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';



class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var email=TextEditingController();
    var name=TextEditingController();
    var phone=TextEditingController();
    var password=TextEditingController();
    var val=GlobalKey<FormState>();
    return BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
          listener: (context,state){
           if(state is CreateUserSuccessState){
             navigateAndFinish(context, SocialLayout());
             showToast(message: 'Create Successful', toastStates: ToastStates.ERROR);

           } if(state is CreateUserErrorState)
             {
               showToast(message: state.error!, toastStates: ToastStates.ERROR);
             }if(state is RegisterErrorState)
           {
             showToast(message: state.error!, toastStates: ToastStates.ERROR);
           }


          },
          builder:(context,state){
            var cubit=RegisterCubit.get(context);

            return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: val,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                       // if(state is ShopLoadingRegisterState)
                        //  LinearProgressIndicator(),
                        SizedBox(height: 15,),
                        Text('Register',
                          style:Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(height: 10,),
                        Text('Register now to communicate with friends ',
                          style:Theme.of(context).textTheme.bodyText2,

                        ),
                        SizedBox(height: 30,),
                        TextFormField(
                          controller: name,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius:BorderRadius.circular(10)),
                            labelText: 'name',
                            prefixIcon:  Icon(Icons.person),
                          ),
                          validator: ( String? s){
                            if(s!.isEmpty){
                              return'name is empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20,),
                        TextFormField(

                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius:BorderRadius.circular(10)),
                            labelText: 'email',

                            prefixIcon:  Icon(Icons.email_outlined),

                          ),


                          validator: ( String? s){

                            if(s!.isEmpty){
                              return'email is empty';
                            }
                            return null;

                          },
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius:BorderRadius.circular(10)),

                            labelText: 'phone',
                            prefixIcon:  Icon(Icons.phone),

                          ),


                          validator: ( String? s) {
                            if (s!.isEmpty) {
                              return 'phone is empty';
                            }
                            return null;
                          } ,



                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: password,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius:BorderRadius.circular(10)),

                            labelText: 'password',
                            prefixIcon:  Icon(Icons.lock),

                          ),


                          validator: ( String? s){

                            if(s!.isEmpty){
                              return'password is empty';
                            }
                            return null;

                          },
                        ),
                        SizedBox(height: 15,),
                        ConditionalBuilder(
                          condition: state is!RegisterLoadingState,
                          builder: (context)=>defaultButton(onPress: (){
                            if(val.currentState!.validate()){
                              cubit.userRegister(name: name.text, password: password.text, email: email.text, phone: phone.text);

                            }

                          }, name: 'signup'),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),

                        )
                      ],
                    ),
                  ),
                ),
              ),
            );}

      ),
    );

  }
}

