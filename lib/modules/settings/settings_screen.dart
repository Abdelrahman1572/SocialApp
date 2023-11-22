import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/edit_profile/edit_profile_screen.dart';
import 'package:socialapp/shared/Cubit/Cubit.dart';
import 'package:socialapp/shared/Cubit/States.dart';
import 'package:socialapp/shared/component/Components.dart';
import 'package:socialapp/shared/component/Constants.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel= SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration:BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(4),
                            topLeft: Radius.circular(4),
                          ),
                          image: DecorationImage(
                              image: NetworkImage('${userModel!.cover}'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(
                height: 5,
              ),
              Text('${userModel.name}',
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(
                height: 3,
              ),
              Text(
                '${userModel.bio}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('100',
                                style: Theme.of(context).textTheme.titleSmall),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('350',
                                style: Theme.of(context).textTheme.titleSmall),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('500k',
                                style: Theme.of(context).textTheme.titleSmall),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text('1k',
                                style: Theme.of(context).textTheme.titleSmall),
                            Text(
                              'Followings',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextButton(
                        onPressed: () {
                          signOut(context);
                        },
                        child: const Text(
                          'Add Photos',
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Container(
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius:
                      BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextButton(
                      onPressed: () {
                        NavigateTo(context, EditProfileScreen());
                      },
                      child: const Icon(IconBroken.Edit_Square,color: Colors.white,),
                    ),
                  ),
                ],)
            ],
          ),
        );
      },
    );
  }
}
