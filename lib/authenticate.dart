import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_in_status_bloc/sign_in_status_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_out_bloc/sign_out_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/pages/sign_in_page.dart';
import 'package:chatcalling/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SignInStatusBloc>(context).add(GetSignInStatusEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignOutBloc, SignOutState>(listener: (context, state) {
          _blocListener(context, state);
        }),
        BlocListener<SignInBloc, SignInState>(listener: (context, state) {
          _blocListener(context, state);
        }),
        BlocListener<SignUpBloc, SignUpState>(listener: (context, state) {
          _blocListener(context, state);
        })
      ],
      child: BlocBuilder<SignInStatusBloc, SignInStatusState>(
        builder: (context, state) {
          if (state is SignInStatusTrue) {
            return HomePage();
          } else if (state is SignInStatusFalse) {
            return SignInPage();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _blocListener(BuildContext context, dynamic state) {
    if (state is SignOutLoading ||
        state is SignInLoading ||
        state is SignUpWithEmailLoading) {
      double horizontalMargin = MediaQuery.of(context).size.width * 0.3;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.fromLTRB(horizontalMargin, 0, horizontalMargin,
              MediaQuery.of(context).size.height * 0.4),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          content: Row(
            children: [
              SizedBox.square(
                dimension: 13,
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  strokeWidth: 3,
                ),
              ),
              Text(
                ' Processing...',
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
            ],
          )));
    } else if (state is SignOutError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(state.errorMessage),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } else if (state is SignOutSuccess ||
        state is SignInSuccess ||
        state is SignUpWithEmailSuccess) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }
}
