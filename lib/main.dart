import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/layout/layout.dart';
import 'package:social_app/modules/login_screen/login_screen.dart';
import 'package:social_app/shared/bloc-observer.dart';
import 'package:social_app/shared/components/constatans.dart';
import 'package:social_app/shared/network/local/cacheHelper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/shared/style/theme.dart';
import 'package:toast/toast.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer= MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  print('UID--> $uId');
  if(uId == null||uId.isEmpty){
    widget=LoginScreen();
    print('UID--> $uId');
  }
  else{
    widget=HomeLayout();
    print('UID--> $uId');
  }

  runApp( MyApp(
    startwidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;
  MyApp({super.key,required this.startwidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
     create:(context)=>SocialCubit()..getUserData(),
      child: BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context ,state){
          ToastContext().init(context);
          return MaterialApp(
            title: 'Flutter Demo',
            theme: lightTheme,
            // darkTheme: darkTheme,
            home:  startwidget,
          );
        },
      ),
    );
  }

}

