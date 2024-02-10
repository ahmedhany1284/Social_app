import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model/post_model.dart';
import 'package:social_app/modules/chats/chat_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/login_screen/login_screen.dart';
import 'package:social_app/modules/new_post/new_post_Screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/models/usermodel/User_model.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constatans.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/shared/network/local/cacheHelper.dart';
import 'package:toast/toast.dart';

import '../../models/massage_model/massage_model.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  int numLikes = 0;
  String? likeID;

  Future<UserModel?> getUserData() async {
    emit(SocialGetUserLodingState());

    try {
      final value =
      await FirebaseFirestore.instance.collection('users').doc(uId).get();
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState(userModel!));
    } catch (error) {
      emit(SocialGetUserErrorState(error.toString()));
      print('error-->  ${error.toString()}');
    }
  }
  int cur_inx = 0;
  List<Widget> screens = [
    FeedsScreen(),
    const ChatsScreen(),
    NewPostScreen(),
    const SettingsScreen(),
  ];

  List<String> title = [
    'Home',
    'Chat',
    'posts',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if(index ==0){
      getPosts();
      cur_inx=index;
      emit(SocialChangeBottomNavState());
    }
    else if(index ==1){
      getAllUsers();
      cur_inx=index;
      emit(SocialChangeBottomNavState());
    }
    else if (index == 2) {
      emit(SocialAddPostState());
    }else if( index ==3){
    getUserData();
    cur_inx=index;
    emit(SocialChangeBottomNavState());
    }
    else {
      cur_inx = index;
      emit(SocialChangeBottomNavState());
    }
  }

  final picker = ImagePicker();




//---------------------------------------------------------------------------
  File? postImage;

  Future getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostIMagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialPostIMagePickedfailedState());
    }
  }

  Future<void> uploadPostImage({
    required String dateTime,
    required String text,
  }) async {
    emit(SocialCreatePostLoadingState());

    try {
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('posts/${Uri.file(postImage!.path).pathSegments.last}');

      final uploadTask = storageRef.putFile(postImage!);

      final uploadTaskSnapshot = await uploadTask.whenComplete(() => null);

      if (uploadTaskSnapshot.state == firebase_storage.TaskState.success) {
        final downloadURL = await storageRef.getDownloadURL();
        print(downloadURL);
        createPost(dateTime: dateTime, text: text, postImage: downloadURL);
        emit(SocialCreatePostSuccessState());
      } else {
        emit(SocialCreatePostErrorState());
      }
    } catch (error) {
      emit(SocialCreatePostErrorState());
    }
  }

  Future<void> createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) async {
    emit(SocialCreatePostLoadingState());
    final model = PostModel(
      name: userModel?.name,
      image: userModel?.image,
      uId: userModel?.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
      numLikes: numLikes,
    );

    try {
      await FirebaseFirestore.instance.collection('posts').add(model.toMap());
      await getPosts();
      emit(SocialCreatePostSuccessState());
    } catch (error) {
      emit(SocialCreatePostErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostIMageSuccessState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  Future<void> getPosts() async {
    posts = [];
    postsId = [];
    likes = [];

    try {
      final value = await FirebaseFirestore.instance.collection('posts').get();

      for (final element in value.docs) {
        final val2 = await element.reference.collection('likes').get();
        likes.add(val2.docs.length);
        postsId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));
      }

      emit(SocialGetPostsSuccessState());
    } catch (error) {
      emit(SocialGetPostsErrorState(error.toString()));
    }
  }

  Future<void> likePost(String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('likes')
          .doc(userModel!.uId)
          .set({
        'like': true,
      });
      emit(SocialLikeSuccessState());
    } catch (error) {
      emit(SocialLikeFailedState());
    }
  }

  void deleteLike(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .delete()
        .then((value) {
      emit(SocialDisLikeSuccessState());
    }).catchError((error) {
      emit(SocialDisLikeFailedState());
    });
  }

  List<UserModel> users = [];

  void getAllUsers()  {
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'].toString() != userModel?.uId.toString()){
          print('${element.data()['uId'] }    %%  ${userModel?.uId}  ');
          users.add(UserModel.fromJson(element.data()));
          print('element in for each${element.data().toString()}');
        }
        print('hello here ${users.toString()}');
      });
      emit(SocialGetAllUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetAllUserErrorState(error.toString()));
    });
    }


  }

  Future<void> signOut(context) async {
    emit(SocialLogOutLodingState()); // Clear previous states
    ToastContext().init(context);

    try {
      await FirebaseAuth.instance.signOut();
      CacheHelper.removeData(key: 'uId').then((value) {
        navigateToAndFinish(context, LoginScreen());
        print('Logged out Successfully');
        showToast(
          massage: 'Logged out Successfully',
          state: ToastStates.SUCCESS,
        );
      });
      userModel = null;
      print('sign out cache ${CacheHelper.saveData(key: 'uId', value: '')}');
      emit(SocialLogOutSuccessState());
    } catch (e) {
      emit(SocialLogOutErrorState(e.toString()));
    }
  }


}
