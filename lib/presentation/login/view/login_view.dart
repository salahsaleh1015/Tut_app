import 'package:flutter/material.dart';
import 'package:tut_app/presentation/login/view_model/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = LoginViewModel(_loginUseCase);
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  _bind() {
    _viewModel.start();

    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });

    _userNameController.addListener(() {
      _viewModel.setUserName(_userNameController.text);
    });
  }

  @override
  void initState() {
    _bind();
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
