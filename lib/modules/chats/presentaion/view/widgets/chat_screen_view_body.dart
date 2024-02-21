import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/chats/presentaion/view/widgets/private_chat_view.dart';
import 'package:social_app/modules/chats/presentaion/view_model/cubit.dart';
import 'package:social_app/modules/chats/presentaion/view_model/states.dart';
import 'package:social_app/shared/components/components.dart';

class ChatsScreenViewBody extends StatelessWidget {
  const ChatsScreenViewBody({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<ChatCubit, ChatStates>(
          listener: (context, state) {},
          builder: (context, state) {
            ChatCubit.get(context).userModel=SocialCubit.get(context).userModel;
            return ConditionalBuilder(
              condition: SocialCubit.get(context).users.isNotEmpty,
              builder: (BuildContext context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem(
                  context,
                  SocialCubit.get(context).users[index],
                ),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: SocialCubit.get(context).users.length,
              ),
              fallback: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
            );
          },
        );
      },
    );
  }

  Widget buildChatItem(context, model) => InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PrivateChatScreen(userModel: model),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Text(
            '${model.name}',
            style: const TextStyle(
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}
