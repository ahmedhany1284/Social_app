import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/chats/chat_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_Screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/models/usermodel/User_model.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/constatans.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? model;

  void getUserData() {
    emit(SocialGetUserLodingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
      print('error-->  ${error.toString()}');
    });
  }

  int cur_inx=0;
  List<Widget> screens=
  [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> title=
  [
    'Home',
    'Chat',
    'posts',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index){

    if(index==2){
      emit(SocialAddPostState());
    }else{
      cur_inx=index;
      emit(SocialChangeBottomNavState());
    }
  }

}
