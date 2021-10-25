
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/social_layout.dart';
import 'package:socialapp/moduls/login/cubit/login_cubit.dart';
import 'package:socialapp/moduls/login/cubit/login_states.dart';
import 'package:socialapp/moduls/register/register.dart';
import 'package:socialapp/shared/componants/componants.dart';
import 'package:socialapp/shared/sharedpreference/cach_helper.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var  emailController=TextEditingController();
    var  passwordController=TextEditingController();
    var key=GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),

      child: BlocConsumer<LoginCubit,LoginState>(
        listener: (context,state){
          if(state is LoginSuccessState){
           CacheHelper.putData(key: 'uId', value: state.uId).then((value) {
             navigateAndFinish(context, SocialLayout());

    });
          }if(state is LoginErrorState)
            {
              showToast(message: state.error!, toastStates: ToastStates.ERROR);
            }
        },
        builder: (context,states){
          var cubit=LoginCubit.get(context);
          return  Scaffold(
            appBar: AppBar(),
            body: Form(
              key: key,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Login' ,style: Theme.of(context).textTheme.headline3),
                    SizedBox(height: 5,),
                    Text('Login now to communicate with friends  ',style: Theme.of(context).textTheme.bodyText2),
                    SizedBox(height: 30,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: 'UserName',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),


                      ),
                      controller: emailController,
                      validator: (String ?s){

                        if(s!.isEmpty){
                          return 'Enter UserName';

                        }   return null;
                      },
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      obscureText: cubit.isScure,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(icon: Icon(cubit.suffix),onPressed: (){
                          cubit.passwordLogin();

                        },),
                        labelText: 'Password',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),


                      ),
                      controller:passwordController,
                      validator: (String ?s){

                        if(s!.isEmpty){
                          return 'Enter Password';

                        }   return null;
                      },
                    ),
                    SizedBox(height: 25,),
                    ConditionalBuilder(
                      condition: states is! LoginErrorState,
                      builder:(context)=>defaultButton(onPress: (){
                        if(key.currentState!.validate()){
                          cubit.login(password: passwordController.text, email: emailController.text);


                        }
                      }, name: 'LOGIN',),
                      fallback:(context)=>Center(child: CircularProgressIndicator()) ,

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have account?',style: Theme.of(context).textTheme.bodyText1,),
                        defaultTextButton(onPress: (){

                          navigateTo(context, RegisterScreen());
                        }, name: 'Register')
                      ],)
                  ],
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
