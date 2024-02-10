import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/usermodel/User_model.dart';
import 'package:social_app/modules/edit_profile/edit_page_cubit/cubit.dart';
import 'package:social_app/modules/edit_profile/edit_page_cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/style/icon_broken.dart';

class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EditPageCbit>(
          create: (BuildContext context) => EditPageCbit(),
        ),
        BlocProvider<SocialCubit>(
          create: (BuildContext context) => SocialCubit(),
        ),
      ],
      child: BlocConsumer<EditPageCbit, EditPageStates>(
        listener: (context, editpagestate) {},
        builder: (context, editpagestate) {
          return BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, socialstate) {},
            builder: (context, socialstate) {
              return FutureBuilder<UserModel?>(
                future: EditPageCbit.get(context).userModel == null
                    ? SocialCubit.get(context).getUserData()
                    : Future.value(EditPageCbit.get(context).userModel),
                builder: (context, snapshot) {
                  // print(SocialCubit.get(context).userModel);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    print(snapshot.connectionState);
                    if(SocialCubit.get(context).userModel!=null){
                      EditPageCbit.get(context).userModel=SocialCubit.get(context).userModel;
                    }
                    return Scaffold(
                      appBar: AppBar(
                        title: Text('Loading...'),
                      ),
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  else if (snapshot.hasError) {
                    // Display error message if an error occurred
                    return Scaffold(
                      appBar: AppBar(
                        title: Text('Error'),
                      ),
                      body: Center(
                        child: Text('Error: ${snapshot.error}'),
                      ),
                    );
                  }
                  else {
                    var userModel = SocialCubit.get(context).userModel!;
                    var profileImage = EditPageCbit.get(context).profileImage;
                    var coverImage = EditPageCbit.get(context).coverImage;

                    nameController.text = userModel.name!;
                    bioController.text = userModel.bio!;
                    phoneController.text = userModel.phone!;
                    return Scaffold(
                      appBar: customAppBar(
                          context: context, title: 'Add Post', actions: []),
                      body: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            if (socialstate is SocialUserUpdateLoadingState)
                              const LinearProgressIndicator(),
                            if (socialstate is SocialUserUpdateLoadingState)
                              const SizedBox(
                                height: 10.0,
                              ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 190.0,
                                    child: Stack(
                                      alignment:
                                          AlignmentDirectional.bottomCenter,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional.topCenter,
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            children: [
                                              Container(
                                                height: 140.0,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(4.0),
                                                    topRight:
                                                        Radius.circular(4.0),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: IconButton(
                                                  onPressed: () {
                                                    EditPageCbit.get(context)
                                                        .getcoverImage();
                                                  },
                                                  icon: const CircleAvatar(
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
                                          alignment:
                                              AlignmentDirectional.bottomEnd,
                                          children: [
                                            CircleAvatar(
                                              radius: 64.0,
                                              backgroundColor: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              child: CircleAvatar(
                                                radius: 60.0,
                                                backgroundImage: profileImage ==
                                                        null
                                                    ? NetworkImage(
                                                        '${userModel?.image}')
                                                    : FileImage(profileImage)
                                                        as ImageProvider,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 8.0,
                                                right: 10.0,
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  EditPageCbit.get(context)
                                                      .getprofileImage();
                                                },
                                                icon: const CircleAvatar(
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
                                  if (EditPageCbit.get(context).profileImage !=
                                          null ||
                                      EditPageCbit.get(context).coverImage !=
                                          null)
                                    Row(
                                      children: [
                                        if (EditPageCbit.get(context)
                                                .profileImage !=
                                            null)
                                          Expanded(
                                            child: Column(
                                              children: [
                                                defaultButton(
                                                  function: () async {
                                                    await EditPageCbit.get(
                                                            context)
                                                        .uploadProfileImage(
                                                      name: nameController.text,
                                                      phone:
                                                          phoneController.text,
                                                      bio: bioController.text,
                                                    );
                                                    print(
                                                        'pressed on upload profile');
                                                    await SocialCubit.get(
                                                            context)
                                                        .getUserData();
                                                  },
                                                  text: 'Upload Profile',
                                                ),
                                                if (editpagestate
                                                    is EditPageUserUpdateImageLoadingState)
                                                  const LinearProgressIndicator(),
                                              ],
                                            ),
                                          ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        if (EditPageCbit.get(context)
                                                .coverImage !=
                                            null)
                                          Expanded(
                                            child: Column(
                                              children: [
                                                defaultButton(
                                                  function: () async {
                                                    await EditPageCbit.get(
                                                            context)
                                                        .uploadCoverImage(
                                                      name: nameController.text,
                                                      phone:
                                                          phoneController.text,
                                                      bio: bioController.text,
                                                    );
                                                    print(
                                                        'pressed on upload cover');
                                                    await SocialCubit.get(
                                                            context)
                                                        .getUserData();
                                                  },
                                                  text: 'Upload cover',
                                                ),
                                                if (editpagestate
                                                    is EditPageUserUpdateCoverLoadingState)
                                                  const LinearProgressIndicator(),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  if (EditPageCbit.get(context).profileImage !=
                                          null ||
                                      EditPageCbit.get(context).coverImage !=
                                          null)
                                    const SizedBox(
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
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  defaultFormField(
                                    controller: bioController,
                                    type: TextInputType.text,
                                    validate: (String) {},
                                    label: 'Name',
                                    icon: IconBroken.User,
                                  ),
                                  const SizedBox(
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
                            const Spacer(),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: ()async {
                                  EditPageCbit.get(context).updateUserProfile(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                  await SocialCubit.get(context).getUserData();
                                  print(userModel.name);
                                },
                                child: const Text('UPDATE'),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
