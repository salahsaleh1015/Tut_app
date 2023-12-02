
import 'package:flutter/material.dart';
import 'package:tut_app/application/di.dart';
import 'package:tut_app/presentation/register/view_model/register_view_model.dart';
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameTextEditingController = TextEditingController();
  final TextEditingController _phoneNumberTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  _bind(){
    _userNameTextEditingController.addListener(() {
      _viewModel.setUserName(_userNameTextEditingController.text);
    });
    _phoneNumberTextEditingController.addListener(() {
      _viewModel.setPhoneNumber(_phoneNumberTextEditingController.text);
    });

    _emailTextEditingController.addListener(() {
      _viewModel.setEmail(_emailTextEditingController.text);
    });

    _passwordTextEditingController.addListener(() {
      _viewModel.setPassword(_passwordTextEditingController.text);
    });

  }

  @override
  void initState() {
    _bind();
    _viewModel.start();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }




  @override
  void dispose() {
   _viewModel.dispose();
    super.dispose();
  }
}
