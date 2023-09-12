import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pp/models/login_model.dart';
import 'package:shop_pp/models/on_boarding_model.dart';
import 'package:shop_pp/modules/login/cubit/states.dart';
import 'package:shop_pp/shared/network/endpoints.dart';
import 'package:shop_pp/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);


  LoginModel? loginmodel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value!.data);

      loginmodel=LoginModel.fromjson(value.data);
      print(loginmodel?.status);
      emit(LoginSuccessState(loginmodel!));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }


  IconData suffix=Icons.visibility_outlined;
  bool isPassword= true;

  void change_pass_visibility(){
    isPassword= !isPassword;
    suffix=isPassword?Icons.visibility_outlined:  Icons.visibility_off_outlined;

    
    emit(LoginChangePasswordState() );
  }

}