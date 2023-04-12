import 'package:chatcalling/core/common_features/user/domain/entities/personal_information.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/update_user_bloc/update_user_bloc.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/username_availability_bloc/username_availability_bloc.dart';
import 'package:chatcalling/core/common_widgets/loading_snackbar.dart';
import 'package:chatcalling/core/helpers/time.dart';
import 'package:chatcalling/injector.dart';
import 'package:chatcalling/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserPage extends StatefulWidget {
  final User user;
  final PersonalInformation personalInformation;
  UpdateUserPage(
      {Key? key, required this.user, required this.personalInformation})
      : super(key: key);

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  late TextEditingController _usernameController =
      TextEditingController(text: widget.user.username);
  late TextEditingController _dobController = TextEditingController(
      text: widget.personalInformation.dateOfBirth != null
          ? sLocator.get<TimeFormat>().yMd(
              widget.personalInformation.dateOfBirth!,
              L10n.getLocalLanguageCode(context))
          : '');

  final _formKey = new GlobalKey<FormState>();

  late String _newUsername = widget.user.username;

  void _onSubmit() {
    _formKey.currentState?.save();
    context.read<UpdateUserBloc>().add(UpdateUserEvent(
        user: widget.user, personalInformation: widget.personalInformation));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            onPressed: _onSubmit,
            icon: Icon(FontAwesomeIcons.check),
            iconSize: 20,
            splashRadius: 14,
          ),
        ],
      ),
      body: BlocConsumer<UpdateUserBloc, UpdateUserState>(
        listener: (context, state) {
          if (state is UpdateUserLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackbar.loadingSnackbar(context, text: 'Updating...'));
          } else if (state is UpdateUserError && state.otherError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackbar.errorSnackBar(context, text: state.otherError));
          } else if (state is UpdateUserSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  //------------USERNAME---------------

                  TextFormField(
                    controller: _usernameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    onSaved: (_) {
                      if (_newUsername != widget.user.username)
                        widget.user.username = _newUsername;
                    },
                    onChanged: (value) => context
                        .read<UsernameAvailabilityBloc>()
                        .add(CheckUsernameAvailabilityEvent(
                            currentUsername: widget.user.username,
                            newUsername: value)),
                    decoration: _textFieldDecoration(
                      labelText: 'Username',
                      suffix: BlocBuilder<UsernameAvailabilityBloc,
                          UsernameAvailabilityState>(
                        builder: (context, state) {
                          return SizedBox.square(
                              dimension: 20, child: _usernameSuffix(state));
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 14),

                  //------------DISPLAY NAME---------------

                  TextFormField(
                    initialValue: widget.user.displayName,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    onSaved: (value) => widget.user.displayName = value!,
                    decoration: _textFieldDecoration(
                      labelText: 'Display name',
                      errorText:
                          state is UpdateUserError ? state.usernameError : null,
                    ),
                  ),
                  SizedBox(height: 14),

                  //------------ABOUT---------------

                  TextFormField(
                    initialValue: widget.user.about,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    maxLines: 3,
                    inputFormatters: [LengthLimitingTextInputFormatter(300)],
                    onSaved: (value) => widget.user.about = value!,
                    decoration: _textFieldDecoration(
                      labelText: 'About',
                    ),
                  ),
                  SizedBox(height: 14),

                  //------------GENDER---------------
                  DropdownButtonFormField(
                    value: widget.personalInformation.gender,
                    onChanged: (String? value) => setState(
                        () => widget.personalInformation.gender = value!),
                    decoration: _textFieldDecoration(
                      labelText: 'Gender',
                    ),
                    items: [
                      DropdownMenuItem<String>(
                        child: Text('Male'),
                        value: 'Male',
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Female'),
                        value: 'Female',
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Prefer not to say'),
                        value: 'Prefer not to say',
                      ),
                    ],
                  ),
                  SizedBox(height: 14),

                  //------------DATE OF BIRTH---------------

                  GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        if (value != null)
                          _dobController.text = sLocator
                              .get<TimeFormat>()
                              .yMd(value, L10n.getLocalLanguageCode(context));
                        widget.personalInformation.dateOfBirth = value;
                      });
                    },
                    child: TextFormField(
                      controller: _dobController,
                      textInputAction: TextInputAction.next,
                      enabled: false,
                      decoration: _textFieldDecoration(
                        labelText: 'Date of birth',
                      ),
                    ),
                  ),
                  SizedBox(height: 14),

                  //------------PHONE NUMBER---------------

                  TextFormField(
                    initialValue: widget.personalInformation.phoneNumber,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    readOnly: true,
                    inputFormatters: [LengthLimitingTextInputFormatter(15)],
                    decoration: _textFieldDecoration(
                      labelText: 'Phone number',
                    ),
                  ),
                  SizedBox(height: 14),

                  //------------EMAIL---------------

                  TextFormField(
                    initialValue: widget.personalInformation.email,
                    readOnly: true,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _textFieldDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 14),
                ]),
              ),
            ),
          );
        },
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

  Widget _usernameSuffix(UsernameAvailabilityState state) {
    state is UsernameAvailable
        ? _newUsername = _usernameController.text
        : _newUsername = widget.user.username;

    if (state is UsernameInitial)
      return Container();
    else if (state is UsernameLoading)
      return CircularProgressIndicator(strokeWidth: 2);
    else if (state is UsernameAvailable)
      return Icon(
        Icons.check,
        color: Theme.of(context).colorScheme.primary,
        size: 20,
      );
    else
      return Icon(Icons.clear, color: Colors.red, size: 20);
  }
}
