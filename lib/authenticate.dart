import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_in_status_bloc/sign_in_status_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_out_bloc/sign_out_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/pages/sign_in_page.dart';
import 'package:chatcalling/core/common_widgets/loading_snackbar.dart';
import 'package:chatcalling/core/network/network_bloc/network_bloc.dart';
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
    Future.microtask(() {
      BlocProvider.of<NetworkBloc>(context).add(NetworkEvent());
      BlocProvider.of<SignInStatusBloc>(context).add(GetSignInStatusEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<NetworkBloc, NetworkState>(
            listener: (context, state) {
              if (state is NetworkInfoNotConnected) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('No connection'),
                  duration: Duration(days: 1),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ));
              } else if (state is NetworkConnected) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              }
            },
          ),
          BlocListener<SignOutBloc, SignOutState>(listener: (context, state) {
            _blocListener(context, state, loadingText: 'Signing out...');
          }),
          BlocListener<SignInBloc, SignInState>(listener: (context, state) {
            _blocListener(context, state, loadingText: 'Signing in...');
          }),
          BlocListener<SignUpBloc, SignUpState>(listener: (context, state) {
            _blocListener(context, state, loadingText: 'Signing up...');
          }),
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
        ));
  }

  void _blocListener(BuildContext context, dynamic state,
      {String? loadingText}) {
    if (state is SignOutLoading ||
        state is SignInLoading ||
        state is SignUpWithEmailLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackbar.loadingSnackbar(context, text: loadingText));
    } else if (state is SignOutError) {
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackbar.errorSnackBar(context, text: state.errorMessage));
    } else if (state is SignOutSuccess ||
        state is SignInSuccess ||
        state is SignUpWithEmailSuccess) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }
}
