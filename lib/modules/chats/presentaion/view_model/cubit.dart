import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/usermodel/User_model.dart';
import 'package:social_app/modules/chats/presentaion/view_model/states.dart';

import '../../../../../models/massage_model/massage_model.dart';


class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());

  static ChatCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;



  void sendMassage({
    required String receiverID,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderID: userModel?.uId,
      reciverID: receiverID,
      dateTime: dateTime,
    );

    // sent massage in two places
    //here sent massage for me as me
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(ChatSendMassageSuccessState());
    }).catchError((error) {
      emit(ChatSendMassageErrorState());
    });

    //here sent massage for other side as me
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('chats')
        .doc(userModel?.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(ChatSendMassageSuccessState());
    }).catchError((error) {
      emit(ChatSendMassageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getmassages({
    required String receiverID,
  }) {
    emit(ChatGetMassageLodingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      List<MessageModel> updatedMessages = [];
      event.docs.forEach((element) {
        updatedMessages.add(MessageModel.fromJson(element.data()));
      });
      messages = updatedMessages;
      emit(ChatGetMassageSuccessState());
    });
  }

}
