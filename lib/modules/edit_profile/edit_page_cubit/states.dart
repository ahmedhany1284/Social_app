import 'package:equatable/equatable.dart';

import '../../../models/usermodel/User_model.dart';


abstract class EditPageStates extends Equatable {
  const EditPageStates();

  @override
  List<Object?> get props => [];
}

class EditPageInitialState extends EditPageStates{}

class EditPageGetUserLodingState extends EditPageStates{}
class EditPageGetUserSuccessState extends EditPageStates with EquatableMixin {
  // Define properties for this state
  final UserModel userModel;

  // Constructor
  const EditPageGetUserSuccessState(this.userModel);

  // Override the props getter
  @override
  List<Object?> get props => [userModel];
}
class EditPageGetUserErrorState extends EditPageStates with EquatableMixin {
  // Define properties for this state
  final String error;

  // Constructor
  const EditPageGetUserErrorState(this.error);

  // Override the props getter
  @override
  List<Object?> get props => [error];
}

class EditPageProfileIMagePickedSuccessState extends EditPageStates{}
class EditPageProfileIMagePickedfailedState extends EditPageStates{}


class EditPageCoverIMagePickedSuccessState extends EditPageStates{}
class EditPageCoverIMagePickedfailedState extends EditPageStates{}



class EditPageUploadProfileIMageSuccessState extends EditPageStates{}
class EditPageUploadProfileIMageFailedState extends EditPageStates{}


class EditPageUploadCoverIMageSuccessState extends EditPageStates{}
class EditPageUploadCoverIMageFailedState extends EditPageStates{}



class EditPageUserUpdateLoadingState extends EditPageStates{}
class EditPageUserUpdateSuccessState extends EditPageStates{}
class EditPageUserUpdateErrorState extends EditPageStates{}



class EditPageUserUpdateImageLoadingState extends EditPageStates{}
class EditPageUserUpdateImageErrorState extends EditPageStates{}

class EditPageUserUpdateCoverLoadingState extends EditPageStates{}
class EditPageUserUpdateCoverErrorState extends EditPageStates{}



