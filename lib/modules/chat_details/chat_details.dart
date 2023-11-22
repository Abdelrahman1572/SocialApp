import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/message_model.dart';
import 'package:socialapp/models/users_model.dart';
import 'package:socialapp/shared/Cubit/Cubit.dart';
import 'package:socialapp/shared/Cubit/States.dart';
import 'package:socialapp/shared/component/Constants.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel userModel;

  ChatDetailsScreen({required this.userModel});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context){
        SocialCubit.get(context).getMessages(receviverId: userModel.uId!);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){},
          builder: (context,state){
            var cubit = SocialCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(userModel.image!),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(userModel.name!,style: TextStyle(overflow: TextOverflow.ellipsis),),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                  condition: SocialCubit.get(context).messages.isNotEmpty,
                  builder: (contex)=>Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                          // buildMessage(),
                          // buildMyMessage(),
                       Expanded(
                         child: ListView.separated(
                           physics: const BouncingScrollPhysics(),
                             itemBuilder: (context,index){
                               var message = SocialCubit.get(context).messages[index];
                               if(SocialCubit.get(context).userModel!.uId == message.senderId)
                                return buildMyMessage(message);
                               else
                                 return buildMessage(message);
                             },
                             separatorBuilder: (context,index)=> const SizedBox(height: 15,),
                             itemCount: SocialCubit.get(context).messages.length,
                         ),
                       ),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type your message here...',
                                      hintStyle:
                                      Theme.of(context).textTheme.titleSmall,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 52,
                                decoration: BoxDecoration(
                                  color: defaultColor,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    cubit.sendMessage(
                                        receviverId: userModel.uId!,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text);
                                    messageController.clear();
                                  },
                                  child: const Icon(
                                    IconBroken.Send,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  fallback: (contex)=> const Center(child: CircularProgressIndicator(),)),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model)=> Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(10),
                          topEnd: Radius.circular(10),
                          bottomEnd: Radius.circular(10),
                        )),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(model.text!),
                  ),
                );
  Widget buildMyMessage(MessageModel model)=> Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
          color: defaultColor.withOpacity(0.4),
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
            bottomStart: Radius.circular(10),
          )),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Text(model.text!),
    ),
  );
}
