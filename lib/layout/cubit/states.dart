abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserLodingState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
  final String error;

  SocialGetUserErrorState(this.error);
}

// get posts
class SocialGetPostsLodingState extends SocialStates{}
class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates{
  final String error;

  SocialGetPostsErrorState(this.error);
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
