import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/users_model.dart';
import 'package:socialapp/modules/chat_details/chat_details.dart';
import 'package:socialapp/shared/Cubit/Cubit.dart';
import 'package:socialapp/shared/Cubit/States.dart';
import 'package:socialapp/shared/component/Components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).users[index],context),
              separatorBuilder: (context,index)=>MyDivider(),
              itemCount: SocialCubit.get(context).users.length),
          fallback: (context) => const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model,context) => InkWell(
    onTap: (){
      NavigateTo(context, ChatDetailsScreen(userModel: model));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                '${model.image}'),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            '${model.name}',
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    ),
  );
}
