abstract class SocialStates{}
class SocialStatesInitState extends SocialStates{}
class GetUserLoadingState extends SocialStates{}

class GetUserSuccessState extends SocialStates{


}
class GetUserErrorState extends SocialStates{
  String?error;
  GetUserErrorState({this.error});
}
class GetPostsLoadingState extends SocialStates{}

class GetPostsSuccessState extends SocialStates{
}
class GetPostsErrorState extends SocialStates{
  String?error;
  GetPostsErrorState({this.error});
}
class PostsLikeSuccessState extends SocialStates{
}
class PostsLikeErrorState extends SocialStates{
  String?error;
  PostsLikeErrorState({this.error});
}
class ChangeBottomNavState extends SocialStates{}
class NewPostState extends SocialStates{}
class ProfileImagePickerSuccessState extends SocialStates{


}
class ProfileImagePickerErrorState extends SocialStates{
  String?error;
  ProfileImagePickerErrorState({this.error});
}
class CoverImagePickerSuccessState extends SocialStates{


}
class CoverImagePickerErrorState extends SocialStates{
  String?error;
  CoverImagePickerErrorState({this.error});
}
class ProfileImageUploadSuccessState extends SocialStates{


}
class ProfileImageUploadErrorState extends SocialStates{
  String?error;
  ProfileImageUploadErrorState({this.error});
}
class CoverImageUploadSuccessState extends SocialStates{


}
class CoverImageUploadErrorState extends SocialStates{
  String?error;
  CoverImageUploadErrorState({this.error});
}
class UpdateErrorState extends SocialStates{
  String?error;
  UpdateErrorState({this.error});
}
class UpdateLoadingState extends SocialStates{}
class CreatePostErrorState extends SocialStates{
  String?error;
  CreatePostErrorState({this.error});
}
class CreatePostLoadingState extends SocialStates{}
class CreatePostSuccessState extends SocialStates{}
class PostImagePickerSuccessState extends SocialStates{}

class PostImagePickerLoadingState extends SocialStates{}
class PostImagePickerErrorState extends SocialStates{
  String?error;
  PostImagePickerErrorState({this.error});
}
class PostImageRemoveSuccessState extends SocialStates{


}