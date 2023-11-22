import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layouts/SocialApp/Social_Layouts.dart';
import 'package:socialapp/modules/login/Cubit/cubit.dart';
import 'package:socialapp/modules/login/Cubit/states.dart';
import 'package:socialapp/modules/register/register_screen.dart';
import 'package:socialapp/shared/component/Components.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state){
          if(state is SocialLoginErrorState){
            showToasts(message: state.error, state: ToastStates.ERROR);
          }
          if(state is SocialLoginSuccessState){
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
            )
                .then((value) {
              NavigateAndFinish(context, SocialLayout());
            });
          }
        },
        builder: (context,state){
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
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Login Now To Browse our Hot Offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40,
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
                          height: 20,
                        ),
                        DefaultFormField(
                          Controller: passwordController,
                          Type: TextInputType.visiblePassword,
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          suffix: SocialLoginCubit.get(context).suffix,
                          suffixpressed: () {
                            SocialLoginCubit.get(context)
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
                          height: 30,
                        ),
                        ConditionalBuilder(
                            condition: true,
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
                                    SocialLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator())),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't Have An Account?",
                              style: TextStyle(fontSize: 16),
                            ),
                            TextButton(
                              onPressed: () {
                                NavigateTo(context,RegisterScreen());
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
