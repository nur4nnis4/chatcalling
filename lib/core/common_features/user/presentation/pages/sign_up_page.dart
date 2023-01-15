import 'package:chatcalling/core/common_features/user/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/cubit/obscure_cubit.dart';
import 'package:chatcalling/core/style/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FocusNode _usernameFNode = FocusNode();
  final FocusNode _displayNameFNode = FocusNode();
  final FocusNode _emailFNode = FocusNode();
  final FocusNode _passwordFNode = FocusNode();

  late TextEditingController _usernameController = TextEditingController();
  late TextEditingController _displayNameController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<SignUpBloc>().add(SignUpWithEmailEvent(
          username: _usernameController.text,
          displayName: _displayNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpWithEmailSuccess) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  if (state is SignUpWithEmailError) {}
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),

                      //------------APP LOGO AND NAME ---------------

                      Row(
                        children: [
                          Image.asset(LAUNCHER_ICON_PATH, height: 22),
                          Text(
                            ' ChatCalling',
                            style: TextStyle(fontSize: 22),
                          )
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),

                      //------------USERNAME---------------

                      TextField(
                        controller: _usernameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        autofocus: true,
                        focusNode: _usernameFNode,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_displayNameFNode),
                        decoration: _textFieldDecoration(
                          labelText: 'Username',
                          errorText: state is SignUpWithEmailError
                              ? state.usernameError
                              : null,
                        ),
                      ),
                      SizedBox(height: 14),

                      //------------DISPLAY NAME---------------

                      TextField(
                        controller: _displayNameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        focusNode: _displayNameFNode,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(_emailFNode),
                        decoration: _textFieldDecoration(
                          labelText: 'Display name',
                          errorText: state is SignUpWithEmailError
                              ? state.displayNameError
                              : null,
                        ),
                      ),
                      SizedBox(height: 14),

                      //------------EMAIL---------------

                      TextField(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        focusNode: _emailFNode,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(_passwordFNode),
                        decoration: _textFieldDecoration(
                          labelText: 'Email',
                          errorText: state is SignUpWithEmailError
                              ? state.emailError
                              : null,
                        ),
                      ),
                      SizedBox(height: 14),

                      //------------PASSWORD---------------

                      BlocBuilder<ObscureCubit, bool>(
                        builder: (_, obscure) {
                          return TextField(
                            obscureText: obscure,
                            controller: _passwordController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            focusNode: _passwordFNode,
                            onEditingComplete: () => _submit(),
                            decoration: _textFieldDecoration(
                              labelText: 'Password',
                              errorText: state is SignUpWithEmailError
                                  ? state.passwordError
                                  : null,
                              suffix: SizedBox(
                                height: 32,
                                width: 28,
                                child: IconButton(
                                  onPressed: () => context
                                      .read<ObscureCubit>()
                                      .toggleSwitch(),
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
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),

                      //------------SIGN UP BUTTON---------------

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _submit,
                          child: Text('Sign Up'),
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

                      //------------SIGN UP WITH GOOGLE BUTTON---------------

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
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
                                  Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer)),
                        ),
                      ),

                      //------------SIGN IN RECOMMENDATION---------------

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account ? ',
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer),
                          ),
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Sign in'))
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _textFieldDecoration(
          {required String labelText, String? errorText, Widget? suffix}) =>
      InputDecoration(
        labelText: labelText,
        errorText: errorText,
        errorMaxLines: 2,
        contentPadding: EdgeInsets.all(12),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primaryContainer,
        suffix: suffix,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
      );
}
