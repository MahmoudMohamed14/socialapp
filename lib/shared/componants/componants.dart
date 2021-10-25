import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/style/icon_broken.dart';


void navigateTo(context,widget ){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}
void navigateAndFinish(context,widget ){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget),(route)=>false);
}
Widget defaultEditText(
{
  required TextEditingController controller,
 var validate,
  bool enableText=false,
  String ?label,
   required IconData prefIcon,
  Function ? onPressSuffix,
   IconData? sufIcon,
  TextInputType textType=TextInputType.text

}
    ){

  return TextFormField(
    keyboardType:textType ,
    controller: controller,
    validator: (  String ?s){
      validate!(s);
  },

    obscureText:enableText ,
    decoration:InputDecoration(

        border: OutlineInputBorder(borderRadius:BorderRadius.circular(10)),
        labelText: label,
        prefixIcon: Icon(prefIcon),
        suffixIcon: IconButton(onPressed:(){
          onPressSuffix!();
        }
          ,icon: Icon(sufIcon),
        )

    ) ,

  );
}
Widget defaultButton(
    {
      required Function onPress,
      required String name,
      double width=double.infinity

    }
    )=>Container(
  decoration:BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.green

  ) ,


  height: 50,
  width:width ,
  child: MaterialButton(

    onPressed: () {
      onPress();

    },
    child: Text(
      name,
      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),
    ),),
);
Widget defaultTextButton(
    {
      required
      Function onPress
      ,
      required
      String
      name
      ,
    })=> TextButton(child: Text(name.toUpperCase()),onPressed: (){onPress();},);
void showToast({required String message,required ToastStates toastStates}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    textColor: Colors.white,
    fontSize: 16,
    backgroundColor: toastColor(toastStates: toastStates),
    timeInSecForIosWeb: 5


  );
}
  enum ToastStates{SUCCESS,ERROR,WARNING}


  Color toastColor({required ToastStates toastStates}){

 late Color color;
  switch(toastStates){
    case ToastStates.SUCCESS:
      color= Colors.green;
     break;
    case ToastStates.WARNING:
      color= Colors.yellow;
      break;
    case ToastStates.ERROR:
      color= Colors.red;
      break;
  }
  return color;
  }

PreferredSizeWidget defaultAppBar({
 required   BuildContext context,
  String? title,
  List<Widget>?action,
})=>AppBar(
  title: Text('$title',style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 22,fontWeight: FontWeight.bold),),
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: Icon(IconBroken.Arrow___Left_2),
  ),
  titleSpacing: 5,
  actions:action ,
);

