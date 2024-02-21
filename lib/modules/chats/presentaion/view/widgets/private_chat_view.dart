import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/models/usermodel/User_model.dart';
import 'package:social_app/modules/chats/presentaion/view_model/cubit.dart';
import 'package:social_app/modules/chats/presentaion/view_model/states.dart';
import 'package:social_app/shared/style/icon_broken.dart';

import '../../../../../shared/components/components.dart';


class PrivateChatScreen extends StatelessWidget {
  UserModel userModel;
  TextEditingController massageController = TextEditingController();

  PrivateChatScreen({super.key,
    required this.userModel,
  });
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        ChatCubit.get(context).getmassages(receiverID: userModel.uId!);
        return BlocConsumer<ChatCubit, ChatStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                elevation: 20.0,
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        '${userModel.image}',
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text('${userModel.name}'),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: ChatCubit.get(context).messages.length,
                      itemBuilder: (context, index) {
                        var message =
                        ChatCubit.get(context).messages[index];

                        if (ChatCubit.get(context).userModel?.uId ==
                            message.senderID) {
                          return myChatBubble(message);
                        } else {
                          return chatBubble(message);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: massageController,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: 'Send massage',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            print("onPressed executed");
                            print(userModel.uId);
                            if(massageController.text.isNotEmpty){ChatCubit.get(context).sendMassage(
                              receiverID: userModel.uId!,
                              dateTime: DateTime.now().toString(),
                              text: massageController.text,
                            );}
                            massageController.clear();
                          },
                          icon: const Icon(
                            IconBroken.Send,
                            size: 30,
                          ),
                        )

                      ],
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

