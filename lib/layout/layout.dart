import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/new_post/new_post_Screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constatans.dart';
import 'package:social_app/shared/network/local/cacheHelper.dart';
import 'package:social_app/shared/style/icon_broken.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // SocialCubit.get(context).getUserData();
        if (state is SocialAddPostState) {
          navigateTo(
            context,
            NewPostScreen(),
          );
        }
      },
      builder: (context, state) {
        return FutureBuilder(
          future: SocialCubit.get(context).getUserData(),
          builder: (context, state) {
            var userModel=SocialCubit.get(context).getUserData();
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  SocialCubit.get(context).title[SocialCubit.get(context).cur_inx],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      IconBroken.Notification,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      IconBroken.Search,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      SocialCubit.get(context).signOut(context);

                      if(SocialCubit.get(context).userModel!=null){
                        print('----------------------------------------------------------------------->model is not null');
                      }
                    },
                    icon: Icon(
                      IconBroken.Logout,
                    ),
                  ),
                ],
              ),
              body: SocialCubit.get(context).screens[SocialCubit.get(context).cur_inx],
              bottomNavigationBar: BottomNavigationBar(
                elevation: 10.0,
                currentIndex: SocialCubit.get(context).cur_inx,
                onTap: (index) {
                  SocialCubit.get(context).changeBottomNav(index);
                  print('cur ind ${SocialCubit.get(context).cur_inx}');
                },
                items: const[
                  BottomNavigationBarItem(
                    label: 'Home',
                    icon: Icon(
                      IconBroken.Home,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Chat',
                    icon: Icon(
                      IconBroken.Chat,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Post',
                    icon: Icon(
                      IconBroken.Plus,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Settings',
                    icon: Icon(
                      IconBroken.Setting,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
