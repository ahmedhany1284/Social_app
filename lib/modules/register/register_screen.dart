import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login_screen/login_screen.dart';
import 'package:social_app/modules/register/cubit/cubit.dart';
import 'package:social_app/modules/register/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var repasswordController = TextEditingController();
  var phoneController = TextEditingController();
  var password;
  var repassword;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            navigateToAndFinish(
              context,
              LoginScreen(),
            );
            print('Account created successfully''');
            // showToast(
            //   massage: 'Account created successfully',
            //   state: ToastStates.SUCCESS,
            // );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your name';
                            }
                            return null;
                          },
                          label: 'Userame',
                          icon: Icons.person,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your email adress';
                            }
                            return null;
                          },
                          label: 'Email Adress',
                          icon: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          isPassword: RegisterCubit.get(context).isPassword,
                          controller: passwordController,
                          suffix: RegisterCubit.get(context).suffix,
                          onSubmit: (value) {},
                          suffixPressed: () {
                            RegisterCubit.get(context).change_pass_visibility();
                          },
                          type: TextInputType.emailAddress,
                          validate: (value) {

                            if (value!.isEmpty) {
                              return 'Password is too short';
                            }
                            password=value;
                            print('enter ${password}     ${repassword}');
                          },
                          label: 'password',
                          icon: Icons.lock_outline,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          isPassword: RegisterCubit.get(context).isPassword,
                          controller: repasswordController,
                          suffix: RegisterCubit.get(context).suffix,
                          onSubmit: (value) {},
                          suffixPressed: () {
                            RegisterCubit.get(context).change_pass_visibility();
                          },
                          type: TextInputType.emailAddress,
                          validate: (repassword) {
                            print('reenter  ${password}     ${repassword}');
                            if (repassword!.isEmpty) {
                              return 'Password is too short';
                            }
                            else if(password!=repassword){
                              return 'password does not match';
                            }
                            return null;
                          },
                          label: 'Re enter the password',
                          icon: Icons.lock_outline,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your phone';
                            }
                            return null;
                          },
                          label: 'phone',
                          icon: Icons.phone,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is RegisterLoadingState,
                          builder: (context) =>
                              Center(child: CircularProgressIndicator()),
                          fallback: (context) => defaultButton(
                            function: () {
                              if (formkey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'REGISTER',
                            isUpperCase: true,
                          ),
                        ),
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
