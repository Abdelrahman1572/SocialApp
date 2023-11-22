// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layouts/SocialApp/Social_Layouts.dart';
import 'package:socialapp/modules/register/Cubit/cubit.dart';
import 'package:socialapp/modules/register/Cubit/states.dart';
import 'package:socialapp/shared/component/Components.dart';

class RegisterScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            NavigateAndFinish(context, const SocialLayout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Colors.black,
                              ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Register Now To Browse our Hot Offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultFormField(
                          Controller: nameController,
                          Type: TextInputType.name,
                          Validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          Label: 'UserName',
                          Prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        DefaultFormField(
                          Controller: emailController,
                          Type: TextInputType.emailAddress,
                          Validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email';
                            }
                            return null;
                          },
                          Label: 'Email',
                          Prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        DefaultFormField(
                          Controller: passwordController,
                          Type: TextInputType.visiblePassword,
                          isPassword:
                              SocialRegisterCubit.get(context).isPassword,
                          suffix: SocialRegisterCubit.get(context).suffix,
                          suffixpressed: () {
                            SocialRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          Validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          Label: 'Password',
                          Prefix: Icons.password_outlined,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        DefaultFormField(
                          Controller: phoneController,
                          Type: TextInputType.phone,
                          Validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone';
                            }
                            return null;
                          },
                          Label: 'Phone',
                          Prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ConditionalBuilder(
                            condition: state is! SocialRegisterLoadingState,
                            builder: (context) => Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      if (formkey.currentState!.validate()) {
                                        SocialRegisterCubit.get(context)
                                            .userRegister(
                                          name: nameController.text.trim(),
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                          phone: phoneController.text.trim(),
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'Register',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator())),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
