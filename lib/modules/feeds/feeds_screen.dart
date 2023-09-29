import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model/post_model.dart';
import 'package:social_app/shared/style/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
   FeedsScreen({super.key});
  int? cur_ind;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialLikeSuccessState){

        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length > 0 || SocialCubit.get(context).userModel!=null,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 20.0,
                    margin: EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage(
                            'https://img.freepik.com/free-vector/brainstorming-concept-landing-page_52683-25791.jpg',
                          ),
                          fit: BoxFit.cover,
                          height: 200.0,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      cur_ind=index;
                      return buildPostItem(
                          SocialCubit.get(context).posts[index], context,index);
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 8.0,
                    ),
                    itemCount:SocialCubit.get(context).posts.length,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            );
          },
          fallback: (BuildContext context) {
            return Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context,index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage('${SocialCubit.get(context).userModel!.image}'),
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
                              '${model.name}',
                              style: TextStyle(
                                height: 1.4,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16.0,
                            )
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        IconBroken.More_Circle,
                      ))
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Container(
                  height: 1.0,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    '${model.text}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    height: 150.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          '${model.postImage}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                              size: 16.0,
                              fill:1.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${SocialCubit.get(context).numLikes}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              color: Colors.amber,
                              size: 16.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              '0 Comments',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 1.0,
                  color: Colors.grey,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).userModel?.image}'),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            'write a comment ...',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          SocialCubit.get(context).likeID==null?'Like':'Liked',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    onTap: () {
                      if(SocialCubit.get(context).likeID == null){
                        SocialCubit.get(context).numLikes++;
                        SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                        SocialCubit.get(context).likeID=SocialCubit.get(context).postsId[index];
                      }
                      else{
                        SocialCubit.get(context).numLikes--;
                        SocialCubit.get(context).deleteLike(SocialCubit.get(context).postsId[index]);
                        SocialCubit.get(context).likeID=null;
                      }

                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
