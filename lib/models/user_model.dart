class UserModel{
  String? name;
  String? email;
  String? password;
  String? phone;
  String? uId;
  String? image;
  String? bio;
  String? cover;
  bool? isEmailVerified;


  UserModel({this.name, this.email, this.password, this.phone, this.uId,this.isEmailVerified,this.image,this.bio,this.cover});


  UserModel.fromJson(Map<String,dynamic> json){
    name=json['name'];
    email=json['email'];
    password=json['password'];
    phone=json['phone'];
    uId=json['uId'];
    isEmailVerified=json['isEmailVerified'];
    image=json['image'];
    bio=json['bio'];
    cover=json['cover'];



  }

  Map<String,dynamic>toMap(){
    return{
      'name':name,
      'email':email,
      'password':password,
      'phone':phone,
      'uId':uId,
      'isEmailVerified':isEmailVerified,
      'image':image,
      'bio':bio,
      'cover':cover
    };
  }



}