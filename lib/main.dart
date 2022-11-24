import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/core/utils/app_string.dart';
import 'package:movies_app/firebase_options.dart';
import 'package:movies_app/movies/presentation/controllers/bloc/user_bloc.dart';
import 'package:movies_app/movies/presentation/screens/auth/login/login.dart';
import 'package:movies_app/movies/presentation/screens/movies_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kIsWeb || defaultTargetPlatform == TargetPlatform.macOS) {
    await FacebookAuth.instance.webAndDesktopInitialize(
      appId: "3226290479:web:46adb4739a2df23f6bb9da",
      cookie: true,
      xfbml: true,
      version: "v15.1.0",
    );
  }
  ServicesLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppString.appName,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.grey.shade900,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocProvider(
            create: (context) => getIt<UserBloc>()..add(GetUserEvent(context: context)),
            child: BlocConsumer<UserBloc, UserBlocState>(
              listener: (context, state) {},
              buildWhen: (previous, current) =>
                  previous.userDataState != current.userDataState,
              builder: ((context, state) {
                return state.userData != null
                    ? const MoviesScreen()
                    : const LoginScreen();

              }),
            )));
  }
}
