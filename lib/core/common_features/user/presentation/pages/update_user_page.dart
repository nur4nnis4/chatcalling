import 'package:flutter/material.dart';

class UpdateUserPage extends StatefulWidget {
  UpdateUserPage({Key? key}) : super(key: key);

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final FocusNode _usernameFNode = FocusNode();
  final FocusNode _displayNameFNode = FocusNode();
  final FocusNode _aboutFNode = FocusNode();
  final FocusNode _genderFNode = FocusNode();
  final FocusNode _dobFNode = FocusNode();
  final FocusNode _phoneNumberFNode = FocusNode();
  final FocusNode _emailFNode = FocusNode();

  late TextEditingController _usernameController = TextEditingController();
  late TextEditingController _displayNameController = TextEditingController();
  late TextEditingController _aboutController = TextEditingController();
  late TextEditingController _phoneNumberController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();

  String _gender = 'Prefer not to say';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        //------------USERNAME---------------

        TextField(
          controller: _usernameController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          autofocus: true,
          focusNode: _usernameFNode,
          onEditingComplete: () =>
              FocusScope.of(context).requestFocus(_displayNameFNode),
          decoration: _textFieldDecoration(
            labelText: 'Username',
          ),
        ),
        SizedBox(height: 14),

        //------------DISPLAY NAME---------------

        TextField(
          controller: _displayNameController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          focusNode: _displayNameFNode,
          maxLines: 3,
          onEditingComplete: () =>
              FocusScope.of(context).requestFocus(_aboutFNode),
          decoration: _textFieldDecoration(
            labelText: 'Display name',
          ),
        ),
        SizedBox(height: 14),

        //------------ABOUT---------------

        TextField(
          controller: _aboutController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          focusNode: _aboutFNode,
          onEditingComplete: () =>
              FocusScope.of(context).requestFocus(_genderFNode),
          decoration: _textFieldDecoration(
            labelText: 'About',
          ),
        ),
        SizedBox(height: 14),

        //------------GENDER---------------

        DropdownButtonFormField(
          value: _gender,
          focusNode: _genderFNode,
          onChanged: (String? value) => setState(() => _gender = value!),
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

        // TODO: Add datepicker
        //------------DOB---------------

        TextField(
          controller: _displayNameController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          focusNode: _displayNameFNode,
          onEditingComplete: () =>
              FocusScope.of(context).requestFocus(_phoneNumberFNode),
          decoration: _textFieldDecoration(
            labelText: 'Date of birth',
          ),
        ),
        SizedBox(height: 14),

        //------------PHONE NUMBER---------------

        TextField(
          controller: _phoneNumberController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.phone,
          focusNode: _phoneNumberFNode,
          onEditingComplete: () =>
              FocusScope.of(context).requestFocus(_emailFNode),
          decoration: _textFieldDecoration(
            labelText: 'Phone number',
          ),
        ),
        SizedBox(height: 14),

        //------------EMAIL---------------

        TextField(
          controller: _emailController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          focusNode: _emailFNode,
          decoration: _textFieldDecoration(
            labelText: 'Email',
          ),
        ),
        SizedBox(height: 14),
      ]),
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
