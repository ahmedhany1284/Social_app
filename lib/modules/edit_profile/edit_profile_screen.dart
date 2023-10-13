

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/style/icon_broken.dart';

class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

        return Scaffold(
          appBar:
              customAppBar(context: context, title: 'Add Post', actions: []),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (state is SocialUserUpdateLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialUserUpdateLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                SingleChildScrollView(

                  child: Column(
                    children: [
                      Container(
                        height: 190.0,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    height: 140.0,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                      image: DecorationImage(
                                        image: coverImage == null
                                            ? NetworkImage(
                                                '${userModel?.cover}',
                                              )
                                            : FileImage(coverImage)
                                                as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: IconButton(
                                      onPressed: () {
                                        SocialCubit.get(context).getcoverImage();
                                      },
                                      icon: CircleAvatar(
                                        radius: 20.0,
                                        child: Icon(
                                          IconBroken.Camera,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 64.0,
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: profileImage == null
                                        ? NetworkImage('${userModel?.image}')
                                        : FileImage(profileImage)
                                            as ImageProvider,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 8.0,
                                    right: 10.0,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getprofileImage();
                                    },
                                    icon: CircleAvatar(
                                      radius: 15.0,
                                      child: Icon(
                                        IconBroken.Camera,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (SocialCubit.get(context).profileImage != null ||
                          SocialCubit.get(context).coverImage != null)
                        Row(
                          children: [
                            if (SocialCubit.get(context).profileImage != null)
                              Expanded(
                                child: Column(
                                  children: [
                                    defaultButton(
                                      function: () {
                                        SocialCubit.get(context)
                                            .uploadProfileImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text,
                                        );
                                      },
                                      text: 'Upload Profile',
                                    ),
                                    if (state
                                        is SocialUserUpdateImageLoadingState)
                                      LinearProgressIndicator(),
                                  ],
                                ),
                              ),
                            SizedBox(
                              width: 5.0,
                            ),
                            if (SocialCubit.get(context).coverImage != null)
                              Expanded(
                                child: Column(
                                  children: [
                                    defaultButton(
                                      function: () {
                                        SocialCubit.get(context).uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text,
                                        );
                                      },
                                      text: 'Upload cover',
                                    ),
                                    if (state
                                        is SocialUserUpdateCoverLoadingState)
                                      LinearProgressIndicator(),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      if (SocialCubit.get(context).profileImage != null ||
                          SocialCubit.get(context).coverImage != null)
                        SizedBox(
                          height: 10.0,
                        ),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Name must not be empty';
                          }
                        },
                        label: 'Name',
                        icon: IconBroken.User,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      defaultFormField(
                        controller: bioController,
                        type: TextInputType.text,
                        validate: (String) {},
                        label: 'Name',
                        icon: IconBroken.User,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Name must not be empty';
                          }
                        },
                        label: 'Phone',
                        icon: IconBroken.User,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                    },
                    child: Text('UPDATE'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
