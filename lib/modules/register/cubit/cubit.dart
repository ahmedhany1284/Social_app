import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pp/models/login_model.dart';
import 'package:shop_pp/modules/register/cubit/states.dart';
import 'package:shop_pp/shared/network/endpoints.dart';
import 'package:shop_pp/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context)=>BlocProvider.of(context);


  LoginModel? loginmodel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      print(value!.data);
      loginmodel=LoginModel.fromjson(value.data);
      print(loginmodel?.status);
      emit(RegisterSuccessState(loginmodel!));
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }


  IconData suffix=Icons.visibility_outlined;
  bool isPassword= true;

  void change_pass_visibility(){
    isPassword= !isPassword;
    suffix=isPassword?Icons.visibility_outlined:  Icons.visibility_off_outlined;

    
    emit(RegisterChangePasswordState());
  }

}