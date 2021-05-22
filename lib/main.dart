import 'package:bloc/bloc.dart';
import 'package:demologinproject/authentication_bloc.dart';
import 'package:demologinproject/authentication_event.dart';
import 'package:demologinproject/authentication_state.dart';
import 'package:demologinproject/home_page.dart';
import 'package:demologinproject/loading_indicator.dart';
import 'package:demologinproject/login_page.dart';
import 'package:demologinproject/repositories/user_repository.dart';
import 'package:demologinproject/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate{
  @override
  void onTransition(Transition transition) {
    print(transition.toString());
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App(userRepository: UserRepository()));
}

class App extends StatefulWidget {
  final UserRepository userRepository;

  App({required this.userRepository});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late AuthenticationBloc authenticationBloc;
  UserRepository get userrepository => widget.userRepository;

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc(userRepository: userrepository);
    authenticationBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider <AuthenticationBloc>(
      bloc: authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
          bloc: authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {
              return SplashPage();
            }
            if (state is AuthenticationAuthenticated) {
              return HomePage();
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginPage(userRepository: userrepository);
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
            return null;
          },
        ),
      ),
    );
  }
}

