class PostModel{
  String? name;


  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;




  PostModel({this.name, this.text, this.dateTime, this.uId,this.postImage,this.image});


  PostModel.fromJson(Map<String,dynamic> json){
    name=json['name'];
    text=json['text'];

    postImage=json['postImage'];
    uId=json['uId'];
    dateTime=json['dateTime'];
    image=json['image'];




  }

  Map<String,dynamic>toMap(){
    return{
      'name':name,
      'dateTime':dateTime,
      'text':text,
      'postImage':postImage,
      'uId':uId,

      'image':image,


    };
  }



}