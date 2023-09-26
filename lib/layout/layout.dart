import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/new_post/new_post_Screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/style/icon_broken.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialAddPostState) {
          navigateTo(
            context,
            NewPostScreen(),
          );
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.title[cubit.cur_inx],
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
            ],
          ),
          body: cubit.screens[cubit.cur_inx],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 10.0,
            currentIndex: cubit.cur_inx,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
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
                label: 'Users',
                icon: Icon(
                  IconBroken.Location,
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
  }
}
