import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/layout/layout.dart';
import 'package:social_app/modules/edit_profile/edit_page_cubit/cubit.dart';
import 'package:social_app/modules/login_screen/login_screen.dart';
import 'package:social_app/modules/private_chat/chat_cubit/cubit.dart';
import 'package:social_app/shared/bloc-observer.dart';
import 'package:social_app/shared/components/constatans.dart';
import 'package:social_app/shared/network/local/cacheHelper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/shared/style/theme.dart';
import 'package:toast/toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  if (uId == null || uId.isEmpty) {
    widget = LoginScreen();
    print('UID--> $uId');
  } else {
    widget = HomeLayout();
    print('UID--> $uId');
  }

  runApp(MyApp(
    startwidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;

  MyApp({super.key, required this.startwidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getPosts(),
        ),
        BlocProvider(
          create: (context) => EditPageCbit()
        ),BlocProvider(
          create: (context) => ChatCubit()
        )
      ],
        child: BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            ToastContext().init(context);
            return MaterialApp(
              title: 'Social App',
              theme: lightTheme,
              home: startwidget,
            );
          },
        ),
    );
  }
}
