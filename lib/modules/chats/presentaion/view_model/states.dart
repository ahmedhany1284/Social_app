import 'package:equatable/equatable.dart';

abstract class ChatStates extends Equatable {
  const ChatStates();

  @override
  List<Object?> get props => [];
}

//massages state
class ChatInitialState extends ChatStates{}
class ChatSendMassageSuccessState extends ChatStates{}
class ChatSendMassageErrorState extends ChatStates{}

class ChatGetMassageSuccessState extends ChatStates{}
class ChatGetMassageLodingState extends ChatStates{}
class ChatGetMassageErrorState extends ChatStates{}

