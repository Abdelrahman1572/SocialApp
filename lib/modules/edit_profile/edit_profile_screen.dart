import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/shared/Cubit/Cubit.dart';
import 'package:socialapp/shared/Cubit/States.dart';
import 'package:socialapp/shared/component/Components.dart';
import 'package:socialapp/shared/component/Constants.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  EditProfileScreen({Key? key}) : super(key: key);

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
          appBar: AppBar(
            title: const Text('Edit Profile'),
            titleSpacing: 5.0,
            actions: [
              TextButton(
                  onPressed: () {
                    SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  child: Text(
                    'Update',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: defaultColor,
                        ),
                  )),
              const SizedBox(
                width: 15,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(4),
                                    topLeft: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage('${userModel.cover}')
                                          : FileImage(coverImage)
                                              as ImageProvider,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: const CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 18,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 18,
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      SocialCubit.get(context).uploadProfileImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text);
                                    },
                                    child: const Text(
                                      'Upload Profile',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                const SizedBox(
                                  height: 5,
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      SocialCubit.get(context).uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text);
                                    },
                                    child: const Text(
                                      'Upload Cover',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                                if (state is SocialUserUpdateLoadingState)
                               const  SizedBox(
                                  height: 5,
                                ),
                                if (state is SocialUserUpdateLoadingState)
                               const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                       const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 25,
                  ),
                  DefaultFormField(
                    Controller: nameController,
                    Type: TextInputType.name,
                    Validator: (value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    Label: 'Name',
                    Prefix: IconBroken.Profile,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DefaultFormField(
                    Controller: bioController,
                    Type: TextInputType.text,
                    Validator: (value) {
                      if (value!.isEmpty) {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    Label: 'Bio',
                    Prefix: IconBroken.Info_Circle,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DefaultFormField(
                    Controller: phoneController,
                    Type: TextInputType.phone,
                    Validator: (value) {
                      if (value!.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    Label: 'Phone',
                    Prefix: IconBroken.Call,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
