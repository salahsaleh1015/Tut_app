import 'package:flutter/material.dart';
import 'package:tut_app/presentation/forget_password/view_model/forget_password_view_model.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final ForgetPasswordViewModel _viewModel = ForgetPasswordViewModel(_forgetPasswordUseCase);
  final TextEditingController _userNameController = TextEditingController();


  _bind(){
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
