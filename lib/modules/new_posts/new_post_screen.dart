import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/shared/Cubit/Cubit.dart';
import 'package:socialapp/shared/Cubit/States.dart';
import 'package:socialapp/shared/component/Constants.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class NewPostsScreen extends StatelessWidget {
  NewPostsScreen({super.key});

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Post'),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(IconBroken.Arrow___Left_2)),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () {
                      var now = DateTime.now();
                      if (SocialCubit.get(context).postImage == null) {
                        SocialCubit.get(context).createPost(
                          text: textController.text,
                          dateTime: now.toString(),
                        );
                      } else {
                        SocialCubit.get(context).uploadPostImage(
                          text: textController.text,
                          dateTime: now.toString(),
                        );
                      }
                      textController.clear();
                    },
                    child: Text(
                      'Post',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: defaultColor,
                          ),
                    )),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  const SizedBox(
                    height: 10,
                  ),
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/positive-young-woman-makes-phone-gesture-near-ear-wants-have-conversation-with-you-speaks-person-dressed-casual-t-shirt-poses-against-pink-wall_273609-48000.jpg?t=st=1696324089~exp=1696324689~hmac=894348f3dcac9dbfe879a039ea2886a32ecfffe024f9332b5ea80c126a3cab7e'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Abdelrahman Ashraf',
                              style: TextStyle(height: 1.4, fontSize: 17),
                            ),
                          ],
                        ),
                      ],
                    )),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText:
                          'What is on your mind, ${SocialCubit.get(context).userModel!.name}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: FileImage(
                                  SocialCubit.get(context).postImage!),
                              fit: BoxFit.cover),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: const CircleAvatar(
                            radius: 20,
                            child: Icon(
                              IconBroken.Close_Square,
                              size: 18,
                            ),
                          ))
                    ],
                  ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Add Photo'),
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(onPressed: () {}, child: const Text('#Tags')),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
