import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:social_app/models/usermodel/User_model.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/modules/edit_profile/edit_page_cubit/states.dart';

import '../../../shared/components/constatans.dart';

class EditPageCbit extends Cubit<EditPageStates> {
  EditPageCbit() : super(EditPageInitialState());

  static EditPageCbit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  File? profileImage;
  final picker = ImagePicker();

  Future getprofileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(EditPageProfileIMagePickedSuccessState());
    } else {
      print('No image selected');
      emit(EditPageProfileIMagePickedfailedState());
    }
  }

  File? coverImage;

  Future getcoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(EditPageProfileIMagePickedSuccessState());
    } else {
      print('No image selected');
      emit(EditPageProfileIMagePickedfailedState());
    }
  }

  Future<void> uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) async {
    try {
      emit(EditPageUserUpdateImageLoadingState());

      final firebase_storage.TaskSnapshot uploadTask = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!);

      final String imageUrl = await uploadTask.ref.getDownloadURL();

      emit(EditPageUploadProfileIMageSuccessState());
      await updateUserProfile(name: name, phone: phone, bio: bio, image: imageUrl);
    } catch (error) {
      emit(EditPageUploadProfileIMageFailedState());
    }
  }

  Future<void> uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) async {
    try {
      emit(EditPageUserUpdateCoverLoadingState());

      final firebase_storage.TaskSnapshot uploadTask = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
          .putFile(coverImage!);

      final String coverUrl = await uploadTask.ref.getDownloadURL();

      emit(EditPageUploadProfileIMageSuccessState());
      await updateUserProfile(name: name, phone: phone, bio: bio, cover: coverUrl);
      print('cover link ${coverUrl}');
    } catch (error) {
      emit(EditPageUploadProfileIMageFailedState());
    }
  }


  Future<void> updateUserProfile({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) async {
    emit(EditPageUserUpdateLoadingState());
    final UserModel model = UserModel(
      name: name,
      email: userModel?.email,
      phone: phone,
      image: image ?? userModel?.image,
      cover: cover ?? userModel?.cover,
      uId: userModel?.uId,
      bio: bio,
      isEmailVerified: false,
    );

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uId)
          .update(model.toMap());
    } catch (error) {
      emit(EditPageUserUpdateErrorState());
    }
  }
}
