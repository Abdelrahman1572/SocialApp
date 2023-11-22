import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/shared/Cubit/Cubit.dart';
import 'package:socialapp/shared/Cubit/States.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: SocialCubit.get(context).posts.isNotEmpty &&
                SocialCubit.get(context).userModel != null,
            builder: (context) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10,
                        margin: const EdgeInsets.all(8),
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            const Image(
                              image: NetworkImage(
                                  'https://img.freepik.com/free-photo/close-up-portrait-attractive-young-woman-isolated_273609-36312.jpg?t=st=1696324089~exp=1696324689~hmac=0b1ea65070040d0b584b6d363cee0d33c8128479c6d0dd05fd6eecb76f051681'),
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Communicate With Friends',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildPostItem(
                              SocialCubit.get(context).posts[index],
                              context,
                              index),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: SocialCubit.get(context).posts.length),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget buildPostItem(PostModel model,BuildContext context, index) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: const TextStyle(height: 1.4),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(height: 1.4),
                    ),
                  ],
                )),
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text('${model.text}'),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 20,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: Text('#Software',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.blue)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 20,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: Text('#Software',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.blue)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 20,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: Text('#Software',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.blue)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 20,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: Text('#Software',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.blue)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 20,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: Text('#Software_Development',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.blue)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 15),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage('${model.postImage}'),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            size: 16,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            IconBroken.Chat,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${SocialCubit.get(context).comments[index]} Comments',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      SocialCubit.get(context).commentPosts(SocialCubit.get(context).postsId[index]);
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).userModel!.image}'),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Write A Comment...',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    SocialCubit.get(context)
                        .likePost(SocialCubit.get(context).postsId[index]);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        size: 16,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ));
}
