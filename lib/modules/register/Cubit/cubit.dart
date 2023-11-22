import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/users_model.dart';
import 'package:socialapp/modules/register/Cubit/states.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print("🐱‍👤print the id for user is ${value.user!.uid}");
      CacheHelper.saveData(key: "uId", value: value.user!.uid);
      userCreate(name: name, email: email, phone: phone, uId: value.user!.uid,);
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      bio: 'write your bio',
      cover: 'https://img.freepik.com/free-photo/lonely-male-hiking-mountains-cage-covered-with-snow-during-daytime_181624-37606.jpg',
      image: 'https://img.freepik.com/free-photo/pleasant-looking-pleased-unshaven-male-notices-something-amazing-upwards-points-head_273609-15053.jpg',
      uId: uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      print("Success create user ❤");
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  bool isPassword = true;

  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterchangePasswordVisibilityState());
  }
}
