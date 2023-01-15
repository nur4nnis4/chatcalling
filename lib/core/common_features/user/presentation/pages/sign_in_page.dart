import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/cubit/obscure_cubit.dart';
import 'package:chatcalling/core/common_features/user/presentation/pages/sign_up_page.dart';
import 'package:chatcalling/core/style/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FocusNode _passwordFNode = FocusNode();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();

  void _submit() {
    context.read<SignInBloc>().add(SignInWithEmailEvent(
        email: _emailController.text, password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            children: [
              Spacer(),
              Row(
                children: [
                  Image.asset(LAUNCHER_ICON_PATH, height: 22),
                  Text(
                    ' ChatCalling',
                    style: TextStyle(fontSize: 22),
                  )
                ],
              ),
              Spacer(),

              BlocBuilder<SignInBloc, SignInState>(
                builder: (context, state) {
                  if (state is SignInError) {
                    return Container(
                        height: 65,
                        padding: EdgeInsets.only(top: 14),
                        child: Text(
                          state.errorMessage,
                          maxLines: 2,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error),
                        ));
                  } else
                    return Container();
                },
              ),

              //------------EMAIL---------------

              TextField(
                autofocus: true,
                controller: _emailController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(_passwordFNode),
                decoration: _authTextFieldDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 14),

              //------------PASSWORD---------------

              BlocBuilder<ObscureCubit, bool>(
                builder: (context, obscure) {
                  return TextField(
                    controller: _passwordController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: _passwordFNode,
                    onEditingComplete: _submit,
                    obscureText: obscure,
                    decoration: _authTextFieldDecoration(
                      labelText: 'Password',
                      suffix: SizedBox(
                        height: 32,
                        width: 28,
                        child: IconButton(
                          onPressed: () =>
                              context.read<ObscureCubit>().toggleSwitch(),
                          splashRadius: 18,
                          iconSize: 18,
                          icon: Icon(
                            obscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 14),

              //------------SIGN IN BUTTON---------------

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text('Sign In'),
                ),
              ),
              SizedBox(height: 14),

              //------------OR DIVIDER---------------

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Divider(thickness: 1)),
                  Text('  or   ',
                      style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer)),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              SizedBox(height: 14),

              //------------SIGN IN WITH GOOGLE BUTTON---------------

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<SignInBloc>().add(SignInWithGoogleEvent());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(GOOGLE_LOGO_PATH, height: 16),
                      Text('  Continue With Google'),
                    ],
                  ),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0.8),
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.onPrimaryContainer),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.primaryContainer)),
                ),
              ),
              SizedBox(height: 14),

              //------------SIGN UP RECOMMENDATION---------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account ? ',
                    style: TextStyle(
                        fontSize: 14,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SignUpPage(),
                            ));
                      },
                      child: Text('Sign up'))
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _authTextFieldDecoration(
          {required String labelText, Widget? suffix}) =>
      InputDecoration(
        labelText: labelText,
        suffix: suffix,
        contentPadding: EdgeInsets.all(12),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primaryContainer,
      );
}
