import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/style/icon_broken.dart';
import 'package:toast/toast.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({super.key});

  var textController = TextEditingController();
  var postTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ToastContext().init(context);
        return Scaffold(
          appBar:
              customAppBar(context: context, title: 'Create Post', actions: [
            TextButton(
                onPressed: () {
                  if (textController.text.isEmpty) {
                    showToast(massage: 'Write somthing first', state: ToastStates.WARNING);
                  } else {
                    if (SocialCubit.get(context).postImage == null) {
                      SocialCubit.get(context).createPost(
                          dateTime: postTime.toString(),
                          text: textController.text);
                    } else {
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: postTime.toString(),
                          text: textController.text);
                    }
                  }
                },
                child: Text(
                  'Post',
                ))
          ]),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/bohemian-man-with-his-arms-crossed_1368-3542.jpg'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Ahmed Hany',
                                style: TextStyle(
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Public',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(height: 1.4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'What is on your mind... ',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.01),
                          image: DecorationImage(
                            image:
                                FileImage(SocialCubit.get(context).postImage!)
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: CircleAvatar(
                            radius: 20.0,
                            child: Icon(
                              IconBroken.Close_Square,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              SocialCubit.get(context).getPostImage();
                            },
                            child: Icon(IconBroken.Image))),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '#',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
