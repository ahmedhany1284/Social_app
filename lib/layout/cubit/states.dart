import 'package:equatable/equatable.dart';
import 'package:social_app/models/usermodel/User_model.dart';

abstract class SocialStates extends Equatable {
  const SocialStates();

  @override
  List<Object?> get props => [];
}

class SocialInitialState extends SocialStates{}

class SocialGetUserLodingState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates with EquatableMixin {
  // Define properties for this state
  final UserModel userModel;

  // Constructor
  const SocialGetUserSuccessState(this.userModel);

  // Override the props getter
  @override
  List<Object?> get props => [userModel];
}
class SocialGetUserErrorState extends SocialStates with EquatableMixin {
  // Define properties for this state
  final String error;

  // Constructor
  const SocialGetUserErrorState(this.error);

  // Override the props getter
  @override
  List<Object?> get props => [error];
}

//log out
class SocialLogOutLodingState extends SocialStates{}
class SocialLogOutSuccessState extends SocialStates{}
class SocialLogOutErrorState extends SocialStates {
  final String error;

  const SocialLogOutErrorState(this.error);

  @override
  List<Object?> get props => [error];
}


//get all users
class SocialGetAllUserLodingState extends SocialStates{}
class SocialGetAllUserSuccessState extends SocialStates{}
class SocialGetAllUserErrorState extends SocialStates{
  final String error;

  const SocialGetAllUserErrorState(this.error);
}


// get posts
class SocialGetPostsLodingState extends SocialStates{}
class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates{
  final String error;

  const SocialGetPostsErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates{}
class SocialAddPostState extends SocialStates{}


class SocialProfileIMagePickedSuccessState extends SocialStates{}
class SocialProfileIMagePickedfailedState extends SocialStates{}


class SocialCoverIMagePickedSuccessState extends SocialStates{}
class SocialCoverIMagePickedfailedState extends SocialStates{}



class SocialUploadProfileIMageSuccessState extends SocialStates{}
class SocialUploadProfileIMageFailedState extends SocialStates{}


class SocialUploadCoverIMageSuccessState extends SocialStates{}
class SocialUploadCoverIMageFailedState extends SocialStates{}



class SocialUserUpdateLoadingState extends SocialStates{}
class SocialUserUpdateErrorState extends SocialStates{}



class SocialUserUpdateImageLoadingState extends SocialStates{}
class SocialUserUpdateImageErrorState extends SocialStates{}

class SocialUserUpdateCoverLoadingState extends SocialStates{}
class SocialUserUpdateCoverErrorState extends SocialStates{}

// create post
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}


//post image
class SocialPostIMagePickedSuccessState extends SocialStates{}
class SocialPostIMagePickedfailedState extends SocialStates{}

//image in post removal
class SocialRemovePostIMageSuccessState extends SocialStates{}
class SocialRemovePostIMageFailedState extends SocialStates{}

// likes
class SocialLikeSuccessState extends SocialStates{}
class SocialLikeFailedState extends SocialStates{}

// Dislike
class SocialDisLikeSuccessState extends SocialStates{}
class SocialDisLikeFailedState extends SocialStates{}


//massages state
class SocialSendMassageSuccessState extends SocialStates{}
class SocialSendMassageErrorState extends SocialStates{}

class SocialGetMassageSuccessState extends SocialStates{}

